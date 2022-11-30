<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="IsPremium"/>
  <xsl:param name="DisableOLEDB" select="'false'"/>

  <xsl:template match="/">
    <compileUnit namespace="{a:project/a:namespace}.Data">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.Data.OleDb"/>
        <namespaceImport name="System.Globalization"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Net.Mail"/>
        <namespaceImport name="System.IO"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Threading"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Caching"/>
        <namespaceImport name="System.Web.Configuration"/>
        <namespaceImport name="System.Data.Common"/>
        <namespaceImport name="System.Runtime.Serialization"/>
        <namespaceImport name="System.Collections"/>
      </imports>
      <types>
        <!-- class ImportMapDictionary -->
        <typeDeclaration name="ImportMapDictionary">
          <baseTypes>
            <typeReference type="SortedDictionary">
              <typeArguments>
                <typeReference type="System.Int32"/>
                <typeReference type="DataField"/>
              </typeArguments>
            </typeReference>
          </baseTypes>
        </typeDeclaration>
        <!-- class ImportLookupDictionary -->
        <typeDeclaration name="ImportLookupDictionary">
          <baseTypes>
            <typeReference type="SortedDictionary">
              <typeArguments>
                <typeReference type="System.String"/>
                <typeReference type="DataField"/>
              </typeArguments>
            </typeReference>
          </baseTypes>
        </typeDeclaration>
        <!-- class ImportProcessor -->
        <typeDeclaration name="ImportProcessor" isPartial="true">
          <baseTypes>
            <typeReference type="ImportProcessorBase"/>
          </baseTypes>
        </typeDeclaration>
        <!-- class CsvImportProcessor -->
        <xsl:if test="$IsPremium='true'">
          <typeDeclaration isPartial="true" name="CsvImportProcessor">
            <attributes public="true"/>
            <baseTypes>
              <typeReference type="ImportProcessorBase"/>
            </baseTypes>
            <members>
              <!-- method OpenRead (string,string)-->
              <memberMethod returnType="IDataReader" name="OpenRead">
                <attributes override="true" public="true"/>
                <parameters>
                  <parameter type="System.String" name="fileName"/>
                  <parameter type="System.String" name="selectClause"/>
                </parameters>
                <statements>
                  <methodReturnStatement>
                    <objectCreateExpression type="CsvReader">
                      <parameters>
                        <objectCreateExpression type="StreamReader">
                          <parameters>
                            <argumentReferenceExpression name="fileName"/>
                            <primitiveExpression value="true"/>
                          </parameters>
                        </objectCreateExpression>
                        <primitiveExpression value="true"/>
                      </parameters>
                    </objectCreateExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method CountRecords (string)-->
              <memberMethod returnType="System.Int32" name="CountRecords">
                <attributes public="true" override="true"/>
                <parameters>
                  <parameter type="System.String" name="fileName"/>
                </parameters>
                <statements>
                  <variableDeclarationStatement type="System.Int32" name="count">
                    <init>
                      <primitiveExpression value="0"/>
                    </init>
                  </variableDeclarationStatement>
                  <usingStatement>
                    <variable type="CsvReader" name="reader">
                      <init>
                        <objectCreateExpression type="CsvReader">
                          <parameters>
                            <objectCreateExpression type="StreamReader">
                              <parameters>
                                <argumentReferenceExpression name="fileName"/>
                              </parameters>
                            </objectCreateExpression>
                            <primitiveExpression value="true"/>
                          </parameters>
                        </objectCreateExpression>
                      </init>
                    </variable>
                    <statements>
                      <whileStatement>
                        <test>
                          <methodInvokeExpression methodName="ReadNextRecord">
                            <target>
                              <variableReferenceExpression name="reader"/>
                            </target>
                          </methodInvokeExpression>
                        </test>
                        <statements>
                          <assignStatement>
                            <variableReferenceExpression name="count"/>
                            <binaryOperatorExpression operator="Add">
                              <variableReferenceExpression name="count"/>
                              <primitiveExpression value="1"/>
                            </binaryOperatorExpression>
                          </assignStatement>
                        </statements>
                      </whileStatement>
                      <methodReturnStatement>
                        <variableReferenceExpression name="count"/>
                      </methodReturnStatement>
                    </statements>
                  </usingStatement>
                </statements>
              </memberMethod>
            </members>
          </typeDeclaration>
        </xsl:if>
        <!-- class ImportProcessorFactory -->
        <typeDeclaration isPartial="true" name="ImportProcessorFactory">
          <attributes public="true"/>
          <baseTypes>
            <typeReference type="ImportProcessorFactoryBase"/>
          </baseTypes>
        </typeDeclaration>
        <!-- class ImportProcessorFactoryBase -->
        <typeDeclaration name="ImportProcessorFactoryBase">
          <attributes public="true"/>
          <members>
            <!-- method CreateProcessor (string) -->
            <memberMethod returnType="ImportProcessorBase" name="CreateProcessor">
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fileName"/>
              </parameters>
              <statements>
                <xsl:if test="$IsPremium='true'">
                  <variableDeclarationStatement type="System.String" name="extension">
                    <init>
                      <methodInvokeExpression methodName="ToLower">
                        <target>
                          <methodInvokeExpression methodName="GetExtension">
                            <target>
                              <propertyReferenceExpression name="Path"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="fileName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </target>
                      </methodInvokeExpression>
                    </init>
                  </variableDeclarationStatement>
                  <xsl:if test="$DisableOLEDB='false'">
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanOr">
                          <methodInvokeExpression methodName="Contains">
                            <target>
                              <variableReferenceExpression name="extension"/>
                            </target>
                            <parameters>
                              <primitiveExpression value=".xls"/>
                            </parameters>
                          </methodInvokeExpression>
                          <methodInvokeExpression methodName="Contains">
                            <target>
                              <variableReferenceExpression name="extension"/>
                            </target>
                            <parameters>
                              <primitiveExpression value=".xlsx"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <objectCreateExpression type="ImportProcessor"/>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                  </xsl:if>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanOr">
                        <methodInvokeExpression methodName="Contains">
                          <target>
                            <variableReferenceExpression name="extension"/>
                          </target>
                          <parameters>
                            <primitiveExpression value=".csv"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="Contains">
                          <target>
                            <variableReferenceExpression name="extension"/>
                          </target>
                          <parameters>
                            <primitiveExpression value=".txt"/>
                          </parameters>
                        </methodInvokeExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <objectCreateExpression type="CsvImportProcessor"/>
                      </methodReturnStatement>
                    </trueStatements>
                  </conditionStatement>
                </xsl:if>
                <throwExceptionStatement>
                  <objectCreateExpression type="Exception">
                    <parameters>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <propertyReferenceExpression name="String"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="The format of file &lt;b&gt;{{0}}&lt;/b&gt; is not supported."/>
                          <methodInvokeExpression methodName="GetFileName">
                            <target>
                              <propertyReferenceExpression name="Path"/>
                            </target>
                            <parameters>
                              <argumentReferenceExpression name="fileName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </objectCreateExpression>
                </throwExceptionStatement>
              </statements>
            </memberMethod>
            <!-- method Create(string) -->
            <memberMethod returnType="ImportProcessorBase" name="Create">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="System.String" name="fileName"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ImportProcessorFactoryBase" name="factory">
                  <init>
                    <objectCreateExpression type="ImportProcessorFactory"/>
                  </init>
                </variableDeclarationStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateProcessor">
                    <target>
                      <variableReferenceExpression name="factory"/>
                    </target>
                    <parameters>
                      <argumentReferenceExpression name="fileName"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class ImportProcessorBase -->
        <typeDeclaration name="ImportProcessorBase">
          <members>
            <!-- property SharedTempPath -->
            <memberProperty type="System.String" name="SharedTempPath">
              <attributes public="true" final="true" static="true"/>
              <getStatements>
                <variableDeclarationStatement type="System.String" name="p">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="AppSettings">
                          <typeReferenceExpression type="WebConfigurationManager"/>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="SharedTempPath"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="IsNullOrEmpty">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="p"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="p"/>
                      <methodInvokeExpression methodName="GetTempPath">
                        <target>
                          <typeReferenceExpression type="Path"/>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsPathRooted">
                        <target>
                          <typeReferenceExpression type="Path"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="p"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="p"/>
                      <methodInvokeExpression methodName="Combine">
                        <target>
                          <typeReferenceExpression type="Path"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="BaseDirectory">
                            <propertyReferenceExpression name="CurrentDomain">
                              <typeReferenceExpression type="AppDomain"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <variableReferenceExpression name="p"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="p"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- constructor () -->
            <constructor>
              <attributes public="true"/>
            </constructor>
            <!-- method Execute(ActionArgs) -->
            <memberMethod name="Execute">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="ActionArgs" name="args"/>
              </parameters>
              <statements>
                <xsl:if test="$IsPremium='true'">
                  <methodInvokeExpression methodName="Process">
                    <parameters>
                      <argumentReferenceExpression name="args"/>
                    </parameters>
                  </methodInvokeExpression>
                  <!--<variableDeclarationStatement type="WaitCallback" name="callback">
                    <init>
                      <addressOfExpression>
                        <methodReferenceExpression methodName="Process"/>
                      </addressOfExpression>
                    </init>
                  </variableDeclarationStatement>
                  <methodInvokeExpression methodName="QueueUserWorkItem">
                    <target>
                      <typeReferenceExpression type="ThreadPool"/>
                    </target>
                    <parameters>
                      <variableReferenceExpression name="callback"/>
                      <argumentReferenceExpression name="args"/>
                    </parameters>
                  </methodInvokeExpression>-->
                </xsl:if>
              </statements>
            </memberMethod>
            <xsl:if test="$IsPremium='true'">
              <xsl:call-template name="GenerateMembers"/>
            </xsl:if>
          </members>
        </typeDeclaration>
        <xsl:if test="$IsPremium='true'">
          <!-- class CsvReader-->
          <typeDeclaration isPartial="true" name="CsvReader">
            <comment>
              <![CDATA[Copyright (c) 2005 Sébastien Lorion
 
MIT license (http://en.wikipedia.org/wiki/MIT_License)
  
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights 
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do so, 
subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.]]>
            </comment>
            <attributes public="true"/>
            <baseTypes>
              <typeReference type="System.Object"/>
              <typeReference type="IDataReader"/>
              <!--<typeReference type="IEnumerable">
              <typeArguments>
                <typeReference type="System.String[]"/>
              </typeArguments>
            </typeReference>-->
              <typeReference type="IDisposable"/>
            </baseTypes>
            <members>
              <!-- constructor (TextReader, bool) -->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="TextReader" name="reader"/>
                  <parameter type="System.Boolean" name="hasHeaders"/>
                </parameters>
                <chainedConstructorArgs>
                  <argumentReferenceExpression name="reader"/>
                  <argumentReferenceExpression name="hasHeaders"/>
                  <propertyReferenceExpression name="DefaultDelimiter"/>
                  <propertyReferenceExpression name="DefaultQuote"/>
                  <propertyReferenceExpression name="DefaultEscape"/>
                  <propertyReferenceExpression name="DefaultComment"/>
                  <propertyReferenceExpression name="UnquotedOnly">
                    <typeReferenceExpression type="ValueTrimmingOptions"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="DefaultBufferSize"/>
                </chainedConstructorArgs>
              </constructor>
              <!-- constructor (TextReader, bool, int) -->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="TextReader" name="reader"/>
                  <parameter type="System.Boolean" name="hasHeaders"/>
                  <parameter type="System.Int32" name="bufferSize"/>
                </parameters>
                <chainedConstructorArgs>
                  <argumentReferenceExpression name="reader"/>
                  <argumentReferenceExpression name="hasHeaders"/>
                  <propertyReferenceExpression name="DefaultDelimiter"/>
                  <propertyReferenceExpression name="DefaultQuote"/>
                  <propertyReferenceExpression name="DefaultEscape"/>
                  <propertyReferenceExpression name="DefaultComment"/>
                  <propertyReferenceExpression name="UnquotedOnly">
                    <typeReferenceExpression type="ValueTrimmingOptions"/>
                  </propertyReferenceExpression>
                  <argumentReferenceExpression name="bufferSize"/>
                </chainedConstructorArgs>
              </constructor>
              <!-- constructor (TextReader, bool, char) -->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="TextReader" name="reader"/>
                  <parameter type="System.Boolean" name="hasHeaders"/>
                  <parameter type="System.Char" name="delimiter"/>
                </parameters>
                <chainedConstructorArgs>
                  <argumentReferenceExpression name="reader"/>
                  <argumentReferenceExpression name="hasHeaders"/>
                  <argumentReferenceExpression name="delimiter"/>
                  <propertyReferenceExpression name="DefaultQuote"/>
                  <propertyReferenceExpression name="DefaultEscape"/>
                  <propertyReferenceExpression name="DefaultComment"/>
                  <propertyReferenceExpression name="UnquotedOnly">
                    <typeReferenceExpression type="ValueTrimmingOptions"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="DefaultBufferSize"/>
                </chainedConstructorArgs>
              </constructor>
              <!-- constructor (TextReader, bool, char, int) -->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="TextReader" name="reader"/>
                  <parameter type="System.Boolean" name="hasHeaders"/>
                  <parameter type="System.Char" name="delimiter"/>
                  <parameter type="System.Int32" name="bufferSize"/>
                </parameters>
                <chainedConstructorArgs>
                  <argumentReferenceExpression name="reader"/>
                  <argumentReferenceExpression name="hasHeaders"/>
                  <argumentReferenceExpression name="delimiter"/>
                  <propertyReferenceExpression name="DefaultQuote"/>
                  <propertyReferenceExpression name="DefaultEscape"/>
                  <propertyReferenceExpression name="DefaultComment"/>
                  <propertyReferenceExpression name="UnquotedOnly">
                    <typeReferenceExpression type="ValueTrimmingOptions"/>
                  </propertyReferenceExpression>
                  <argumentReferenceExpression name="bufferSize"/>
                </chainedConstructorArgs>
              </constructor>
              <!-- constructor (TextReader, bool, char, char, char, char, ValueTrimmingOptions) -->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="TextReader" name="reader"/>
                  <parameter type="System.Boolean" name="hasHeaders"/>
                  <parameter type="System.Char" name="delimiter"/>
                  <parameter type="System.Char" name="quote"/>
                  <parameter type="System.Char" name="escape"/>
                  <parameter type="System.Char" name="comment"/>
                  <parameter type="ValueTrimmingOptions" name="trimmingOptions"/>
                </parameters>
                <chainedConstructorArgs>
                  <argumentReferenceExpression name="reader"/>
                  <argumentReferenceExpression name="hasHeaders"/>
                  <argumentReferenceExpression name="delimiter"/>
                  <argumentReferenceExpression name="quote"/>
                  <argumentReferenceExpression name="escape"/>
                  <argumentReferenceExpression name="comment"/>
                  <argumentReferenceExpression name="trimmingOptions"/>
                  <propertyReferenceExpression name="DefaultBufferSize"/>
                </chainedConstructorArgs>
              </constructor>
              <!-- constructor (TextReader, bool, char, char, char, char, ValueTrimmingOptions, int) -->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="TextReader" name="reader"/>
                  <parameter type="System.Boolean" name="hasHeaders"/>
                  <parameter type="System.Char" name="delimiter"/>
                  <parameter type="System.Char" name="quote"/>
                  <parameter type="System.Char" name="escape"/>
                  <parameter type="System.Char" name="comment"/>
                  <parameter type="ValueTrimmingOptions" name="trimmingOptions"/>
                  <parameter type="System.Int32" name="bufferSize"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <argumentReferenceExpression name="reader"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentNullException">
                          <parameters>
                            <primitiveExpression value="reader"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="LessThanOrEqual">
                        <argumentReferenceExpression name="bufferSize"/>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentOutOfRangeException">
                          <parameters>
                            <primitiveExpression value="bufferSize"/>
                            <argumentReferenceExpression name="bufferSize"/>
                            <propertyReferenceExpression name="BufferSizeTooSmall">
                              <typeReferenceExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="bufferSize"/>
                    <argumentReferenceExpression name="bufferSize"/>
                  </assignStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IsTypeOf">
                        <argumentReferenceExpression name="reader"/>
                        <typeReferenceExpression type="StreamReader"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <variableDeclarationStatement type="Stream" name="stream">
                        <init>
                          <propertyReferenceExpression name="BaseStream">
                            <castExpression targetType="StreamReader">
                              <argumentReferenceExpression name="reader"/>
                            </castExpression>
                          </propertyReferenceExpression>
                        </init>
                      </variableDeclarationStatement>
                      <conditionStatement>
                        <condition>
                          <propertyReferenceExpression name="CanSeek">
                            <variableReferenceExpression name="stream"/>
                          </propertyReferenceExpression>
                        </condition>
                        <trueStatements>
                          <conditionStatement>
                            <condition>
                              <binaryOperatorExpression operator="GreaterThan">
                                <propertyReferenceExpression name="Length">
                                  <variableReferenceExpression name="stream"/>
                                </propertyReferenceExpression>
                                <primitiveExpression value="0"/>
                              </binaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <assignStatement>
                                <fieldReferenceExpression name="bufferSize"/>
                                <castExpression targetType="System.Int32">
                                  <methodInvokeExpression methodName="Min">
                                    <target>
                                      <typeReferenceExpression type="Math"/>
                                    </target>
                                    <parameters>
                                      <argumentReferenceExpression name="bufferSize"/>
                                      <propertyReferenceExpression name="Length">
                                        <variableReferenceExpression name="stream"/>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </castExpression>
                              </assignStatement>
                            </trueStatements>
                          </conditionStatement>
                        </trueStatements>
                      </conditionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="reader"/>
                    <argumentReferenceExpression name="reader"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="delimiter"/>
                    <argumentReferenceExpression name="delimiter"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="quote"/>
                    <argumentReferenceExpression name="quote"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="escape"/>
                    <argumentReferenceExpression name="escape"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="comment"/>
                    <argumentReferenceExpression name="comment"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="hasHeaders"/>
                    <argumentReferenceExpression name="hasHeaders"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="trimmingOptions"/>
                    <argumentReferenceExpression name="trimmingOptions"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="supportsMultiline"/>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="skipEmptyLines"/>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="DefaultHeaderName">
                      <thisReferenceExpression/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="Column"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentRecordIndex"/>
                    <primitiveExpression value="-1"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="defaultParseErrorAction"/>
                    <propertyReferenceExpression name="RaiseEvent">
                      <typeReferenceExpression type="ParseErrorAction"/>
                    </propertyReferenceExpression>
                  </assignStatement>
                </statements>
              </constructor>
              <!-- field DefaultBufferSize-->
              <memberField type="System.Int32" name="DefaultBufferSize">
                <attributes public="true" const="true"/>
                <init>
                  <primitiveExpression value="4096"/>
                </init>
              </memberField>
              <!-- field DefaultDelimiter-->
              <memberField type="System.Char" name="DefaultDelimiter">
                <attributes public="true" const="true"/>
                <init>
                  <primitiveExpression value="," convertTo="Char"/>
                </init>
              </memberField>
              <!-- field DefaultQuote-->
              <memberField type="System.Char" name="DefaultQuote">
                <attributes public="true" const="true"/>
                <init>
                  <primitiveExpression value="&quot;" convertTo="Char"/>
                </init>
              </memberField>
              <!-- field DefaultEscape-->
              <memberField type="System.Char" name="DefaultEscape">
                <attributes public="true" const="true"/>
                <init>
                  <primitiveExpression value="&quot;" convertTo="Char"/>
                </init>
              </memberField>
              <!-- field DefaultComment-->
              <memberField type="System.Char" name="DefaultComment">
                <attributes public="true" const="true"/>
                <init>
                  <primitiveExpression value="#" convertTo="Char"/>
                </init>
              </memberField>
              <!-- field FieldHeaderComparer-->
              <memberField type="StringComparer" name="fieldHeaderComparer">
                <init>
                  <propertyReferenceExpression name="CurrentCultureIgnoreCase">
                    <typeReferenceExpression type="StringComparer"/>
                  </propertyReferenceExpression>
                </init>
              </memberField>
              <!-- field reader -->
              <memberField type="TextReader" name="reader"/>
              <!-- property Comment-->
              <memberProperty type="System.Char" name="Comment">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="comment"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field comment -->
              <memberField type="System.Char" name="comment"/>
              <!-- property Escape-->
              <memberProperty type="System.Char" name="Escape">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="escape"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field escape -->
              <memberField type="System.Char" name="escape"/>
              <!-- property Delimiter-->
              <memberProperty type="System.Char" name="Delimiter">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="delimiter"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field delimiter-->
              <memberField type="System.Char" name="delimiter"/>
              <!-- property Quote-->
              <memberProperty type="System.Char" name="Quote">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="quote"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field quote-->
              <memberField type="System.Char" name="quote"/>
              <!-- property HasHeaders-->
              <memberProperty type="System.Boolean" name="HasHeaders">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="hasHeaders"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field hasHeaders -->
              <memberField type="System.Boolean" name="hasHeaders"/>
              <!-- property TrimmingOptions-->
              <memberProperty type="ValueTrimmingOptions" name="TrimmingOptions">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="trimmingOptions"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field trimmingOptions-->
              <memberField type="ValueTrimmingOptions" name="trimmingOptions"/>
              <!-- property BufferSize-->
              <memberProperty type="System.Int32" name="BufferSize">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="bufferSize"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field bufferSize-->
              <memberField type="System.Int32" name="bufferSize"/>
              <!-- property DefaultParseErrorAction-->
              <memberProperty type="ParseErrorAction" name="DefaultParseErrorAction">
                <attributes public="true" final="true"/>
              </memberProperty>
              <!-- property MissingFieldAction-->
              <memberProperty type="MissingFieldAction" name="MissingFieldAction">
                <attributes public="true" final="true"/>
              </memberProperty>
              <!-- property SupportsMultiline-->
              <memberProperty type="System.Boolean" name="SupportsMultiline">
                <attributes public="true" final="true"/>
              </memberProperty>
              <!-- property SkipEmptyLines-->
              <memberProperty type="System.Boolean" name="SkipEmptyLines">
                <attributes public="true" final="true"/>
              </memberProperty>
              <!-- property DefaultHeaderName-->
              <memberProperty type="System.String" name="DefaultHeaderName">
                <attributes public="true" final="true"/>
              </memberProperty>
              <!-- property FieldCount-->
              <memberProperty type="System.Int32" name="FieldCount" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodInvokeExpression methodName="EnsureInitialize"/>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="fieldCount"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field fieldCount-->
              <memberField type="System.Int32" name="fieldCount"/>
              <!-- property EndOfStream-->
              <memberProperty type="System.Boolean" name="EndOfStream">
                <attributes public="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="eof"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field eof-->
              <memberField type="System.Boolean" name="eof"/>
              <!-- method GetFieldHeaders -->
              <memberMethod returnType="System.String[]" name="GetFieldHeaders">
                <attributes public="true" final="true"/>
                <statements>
                  <methodInvokeExpression methodName="EnsureInitialize"/>
                  <variableDeclarationStatement type="System.String[]" name="fieldHeaders">
                    <init>
                      <arrayCreateExpression>
                        <createType type="System.String"/>
                        <sizeExpression>
                          <propertyReferenceExpression name="Length">
                            <fieldReferenceExpression name="fieldHeaders"/>
                          </propertyReferenceExpression>
                        </sizeExpression>
                      </arrayCreateExpression>
                    </init>
                  </variableDeclarationStatement>
                  <forStatement>
                    <variable type="System.Int32" name="i">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variable>
                    <test>
                      <binaryOperatorExpression operator="LessThan">
                        <variableReferenceExpression name="i"/>
                        <propertyReferenceExpression name="Length">
                          <variableReferenceExpression name="fieldHeaders"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </test>
                    <increment>
                      <variableReferenceExpression name="i"/>
                    </increment>
                    <statements>
                      <assignStatement>
                        <arrayIndexerExpression>
                          <target>
                            <variableReferenceExpression name="fieldHeaders"/>
                          </target>
                          <indices>
                            <variableReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <arrayIndexerExpression>
                          <target>
                            <fieldReferenceExpression name="fieldHeaders"/>
                          </target>
                          <indices>
                            <variableReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                      </assignStatement>
                    </statements>
                  </forStatement>
                  <methodReturnStatement>
                    <variableReferenceExpression name="fieldHeaders"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- field fieldHeaders-->
              <memberField type="System.String[]" name="fieldHeaders"/>
              <!-- field fieldHeaderIndexes-->
              <memberField type="Dictionary" name="fieldHeaderIndexes">
                <typeArguments>
                  <typeReference type="System.String"/>
                  <typeReference type="System.Int32"/>
                </typeArguments>
              </memberField>
              <!-- property CurrentRecordIndex-->
              <memberProperty type="System.Int64" name="CurrentRecordIndex">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="CurrentRecordIndex"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field currentRecordIndex-->
              <memberField type="System.Int64" name="currentRecordIndex"/>
              <!-- property MissingFieldFlag-->
              <memberProperty type="System.Boolean" name="MissingFieldFlag">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="missingFieldFlag"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field missingFieldFlag-->
              <memberField type="System.Boolean" name="missingFieldFlag"/>
              <!-- property ParseErrorFlag-->
              <memberProperty type="System.Boolean" name="ParseErrorFlag">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="parseErrorFlag"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- field parseErrorFlag-->
              <memberField type="System.Boolean" name="parseErrorFlag"/>
              <!-- event ParseError-->
              <memberEvent type="EventHandler" name="ParseError">
                <typeArguments>
                  <typeReference type="ParseErrorEventArgs"/>
                </typeArguments>
                <attributes public="true" final="true"/>
              </memberEvent>
              <!-- method OnParseError-->
              <memberMethod name="OnParseError">
                <attributes family="true"/>
                <parameters>
                  <parameter type="ParseErrorEventArgs" name="e"/>
                </parameters>
                <statements>
                  <variableDeclarationStatement type="EventHandler" name="handler">
                    <typeArguments>
                      <typeReference type="ParseErrorEventArgs"/>
                    </typeArguments>
                    <init>
                      <eventReferenceExpression name="ParseError"/>
                    </init>
                  </variableDeclarationStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityInequality">
                        <variableReferenceExpression name="handler"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="handler">
                        <parameters>
                          <thisReferenceExpression/>
                          <argumentReferenceExpression name="e"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- property this[int, string]-->
              <memberProperty type="System.String" name="Item">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="record"/>
                  <parameter type="System.String" name="field"/>
                </parameters>
                <getStatements>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="Not">
                        <methodInvokeExpression methodName="MoveTo">
                          <parameters>
                            <argumentReferenceExpression name="record"/>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="InvalidOperationException">
                          <parameters>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="CannotReadRecordAtIndex">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="record"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodReturnStatement>
                    <arrayIndexerExpression>
                      <target>
                        <thisReferenceExpression/>
                      </target>
                      <indices>
                        <argumentReferenceExpression name="field"/>
                      </indices>
                    </arrayIndexerExpression>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property this[int, int]-->
              <memberProperty type="System.String" name="Item">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="record"/>
                  <parameter type="System.Int32" name="field"/>
                </parameters>
                <getStatements>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="Not">
                        <methodInvokeExpression methodName="MoveTo">
                          <parameters>
                            <argumentReferenceExpression name="record"/>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="InvalidOperationException">
                          <parameters>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="CannotReadRecordAtIndex">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="record"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodReturnStatement>
                    <arrayIndexerExpression>
                      <target>
                        <thisReferenceExpression/>
                      </target>
                      <indices>
                        <argumentReferenceExpression name="field"/>
                      </indices>
                    </arrayIndexerExpression>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property this[string]-->
              <memberProperty type="System.String" name="Item">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.String" name="field"/>
                </parameters>
                <getStatements>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="IsNullOrEmpty">
                        <argumentReferenceExpression name="field"/>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentNullException">
                          <parameters>
                            <primitiveExpression value="field"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="Not">
                        <fieldReferenceExpression name="hasHeaders"/>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="InvalidOperationException">
                          <parameters>
                            <propertyReferenceExpression name="NoHeaders">
                              <typeReferenceExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <variableDeclarationStatement type="System.Int32" name="index">
                    <init>
                      <methodInvokeExpression methodName="GetFieldIndex">
                        <parameters>
                          <argumentReferenceExpression name="field"/>
                        </parameters>
                      </methodInvokeExpression>
                    </init>
                  </variableDeclarationStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="LessThan">
                        <variableReferenceExpression name="index"/>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentException">
                          <parameters>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="FieldHeaderNotFound">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="field"/>
                              </parameters>
                            </methodInvokeExpression>
                            <primitiveExpression value="field"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodReturnStatement>
                    <arrayIndexerExpression>
                      <target>
                        <thisReferenceExpression/>
                      </target>
                      <indices>
                        <variableReferenceExpression name="index"/>
                      </indices>
                    </arrayIndexerExpression>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property this[int]-->
              <memberProperty type="System.String" name="Item">
                <attributes public="true" />
                <parameters>
                  <parameter type="System.Int32" name="field"/>
                </parameters>
                <getStatements>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="ReadField">
                      <parameters>
                        <argumentReferenceExpression name="field"/>
                        <primitiveExpression value="false"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- method EnsureInitialize -->
              <memberMethod name="EnsureInitialize">
                <attributes private="true"/>
                <statements>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="Not">
                        <fieldReferenceExpression name="initialized"/>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="ReadNextRecord">
                        <target>
                          <thisReferenceExpression/>
                        </target>
                        <parameters>
                          <primitiveExpression value="true"/>
                          <primitiveExpression value="false"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- field initalized-->
              <memberField type="System.Boolean" name="initialized"/>
              <!-- method GetFieldIndex(string) -->
              <memberMethod returnType="System.Int32" name="GetFieldIndex">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.String" name="header"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="EnsureInitialize"/>
                  <variableDeclarationStatement type="System.Int32" name="index"/>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanAnd">
                        <binaryOperatorExpression operator="IdentityInequality">
                          <fieldReferenceExpression name="fieldHeaderIndexes"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                        <methodInvokeExpression methodName="TryGetValue">
                          <target>
                            <fieldReferenceExpression name="fieldHeaderIndexes"/>
                          </target>
                          <parameters>
                            <argumentReferenceExpression name="header"/>
                            <directionExpression direction="Out">
                              <variableReferenceExpression name="index"/>
                            </directionExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <variableReferenceExpression name="index"/>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <methodReturnStatement>
                        <primitiveExpression value="-1"/>
                      </methodReturnStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method CopyCurrentRecordTo(string[])-->
              <memberMethod name="CopyCurrentRecordTo">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.String[]" name="array"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="CopyCurrentRecordTo">
                    <parameters>
                      <argumentReferenceExpression name="array"/>
                      <primitiveExpression value="0"/>
                    </parameters>
                  </methodInvokeExpression>
                </statements>
              </memberMethod>
              <!-- method CopyCurrentRecordTo(string[], int)-->
              <memberMethod name="CopyCurrentRecordTo">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.String[]" name="array"/>
                  <parameter type="System.Int32" name="index"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <argumentReferenceExpression name="array"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentNullException">
                          <parameters>
                            <primitiveExpression value="array"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanOr">
                        <binaryOperatorExpression operator="LessThan">
                          <argumentReferenceExpression name="index"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="GreaterThanOrEqual">
                          <argumentReferenceExpression name="index"/>
                          <propertyReferenceExpression name="Length">
                            <argumentReferenceExpression name="array"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentOutOfRangeException">
                          <parameters>
                            <primitiveExpression value="index"/>
                            <argumentReferenceExpression name="index"/>
                            <propertyReferenceExpression name="Empty">
                              <typeReferenceExpression type="String"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanOr">
                        <binaryOperatorExpression operator="LessThan">
                          <fieldReferenceExpression name="currentRecordIndex"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                        <unaryOperatorExpression operator="Not">
                          <fieldReferenceExpression name="initialized"/>
                        </unaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="InvalidOperationException">
                          <parameters>
                            <propertyReferenceExpression name="NoCurrentRecord">
                              <typeReferenceExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="LessThan">
                        <binaryOperatorExpression operator="Subtract">
                          <propertyReferenceExpression name="Length">
                            <argumentReferenceExpression name="array"/>
                          </propertyReferenceExpression>
                          <argumentReferenceExpression name="index"/>
                        </binaryOperatorExpression>
                        <fieldReferenceExpression name="fieldCount"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentException">
                          <parameters>
                            <propertyReferenceExpression name="NotEnoughSpaceInArray">
                              <typeReferenceExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="array"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <forStatement>
                    <variable type="System.Int32" name="i">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variable>
                    <test>
                      <binaryOperatorExpression operator="LessThan">
                        <variableReferenceExpression name="i"/>
                        <fieldReferenceExpression name="fieldCount"/>
                      </binaryOperatorExpression>
                    </test>
                    <increment>
                      <variableReferenceExpression name="i"/>
                    </increment>
                    <statements>
                      <conditionStatement>
                        <condition>
                          <fieldReferenceExpression name="parseErrorFlag"/>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <arrayIndexerExpression>
                              <target>
                                <argumentReferenceExpression name="array"/>
                              </target>
                              <indices>
                                <binaryOperatorExpression operator="Add">
                                  <argumentReferenceExpression name="index"/>
                                  <variableReferenceExpression name="i"/>
                                </binaryOperatorExpression>
                              </indices>
                            </arrayIndexerExpression>
                            <primitiveExpression value="null"/>
                          </assignStatement>
                        </trueStatements>
                        <falseStatements>
                          <assignStatement>
                            <arrayIndexerExpression>
                              <target>
                                <argumentReferenceExpression name="array"/>
                              </target>
                              <indices>
                                <binaryOperatorExpression operator="Add">
                                  <argumentReferenceExpression name="index"/>
                                  <variableReferenceExpression name="i"/>
                                </binaryOperatorExpression>
                              </indices>
                            </arrayIndexerExpression>
                            <arrayIndexerExpression>
                              <target>
                                <thisReferenceExpression/>
                              </target>
                              <indices>
                                <argumentReferenceExpression name="i"/>
                              </indices>
                            </arrayIndexerExpression>
                          </assignStatement>
                        </falseStatements>
                      </conditionStatement>
                    </statements>
                  </forStatement>
                </statements>
              </memberMethod>
              <!-- method GetCurrentRawData-->
              <memberMethod returnType="System.String" name="GetCurrentRawData">
                <attributes public="true" final="true"/>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BitwiseAnd">
                        <binaryOperatorExpression operator="IdentityInequality">
                          <fieldReferenceExpression name="buffer"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="GreaterThan">
                          <fieldReferenceExpression name="bufferLength"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <objectCreateExpression type="String">
                          <parameters>
                            <fieldReferenceExpression name="buffer"/>
                            <primitiveExpression value="0"/>
                            <fieldReferenceExpression name="bufferLength"/>
                          </parameters>
                        </objectCreateExpression>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <methodReturnStatement>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </methodReturnStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- field buffer -->
              <memberField type="System.Char[]" name="buffer"/>
              <!-- field bufferLength -->
              <memberField type="System.Int32" name="bufferLength"/>
              <!-- method IsWhiteSpace(char)-->
              <memberMethod returnType="System.Boolean" name="IsWhiteSpace">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter type="System.Char" name="c"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueEquality">
                        <argumentReferenceExpression name="c"/>
                        <fieldReferenceExpression name="delimiter"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <primitiveExpression value="false"/>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="LessThanOrEqual">
                            <argumentReferenceExpression name="c"/>
                            <convertExpression to="Char">
                              <primitiveExpression value="255" />
                            </convertExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <binaryOperatorExpression operator="BooleanOr">
                              <binaryOperatorExpression operator="ValueEquality">
                                <argumentReferenceExpression name="c"/>
                                <primitiveExpression value=" " convertTo="Char"/>
                              </binaryOperatorExpression>
                              <binaryOperatorExpression operator="ValueEquality">
                                <argumentReferenceExpression name="c"/>
                                <primitiveExpression value="&#9;" convertTo="Char" />
                              </binaryOperatorExpression>
                            </binaryOperatorExpression>
                          </methodReturnStatement>
                        </trueStatements>
                        <falseStatements>
                          <methodReturnStatement>
                            <binaryOperatorExpression operator="ValueEquality">
                              <methodInvokeExpression methodName="GetUnicodeCategory">
                                <target>
                                  <propertyReferenceExpression name="CharUnicodeInfo">
                                    <propertyReferenceExpression name="Globalization">
                                      <propertyReferenceExpression name="System"/>
                                    </propertyReferenceExpression>
                                  </propertyReferenceExpression>
                                </target>
                                <parameters>
                                  <argumentReferenceExpression name="c"/>
                                </parameters>
                              </methodInvokeExpression>
                              <propertyReferenceExpression name="SpaceSeparator">
                                <propertyReferenceExpression name="UnicodeCategory">
                                  <propertyReferenceExpression name="Globalization">
                                    <propertyReferenceExpression name="System"/>
                                  </propertyReferenceExpression>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                            </binaryOperatorExpression>
                          </methodReturnStatement>
                        </falseStatements>
                      </conditionStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method MoveTo(long)-->
              <memberMethod returnType="System.Boolean" name="MoveTo">
                <attributes public="true" />
                <parameters>
                  <parameter type="System.Int64" name="record"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="LessThan">
                        <argumentReferenceExpression name="record"/>
                        <fieldReferenceExpression name="currentRecordIndex"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <primitiveExpression value="false"/>
                      </methodReturnStatement>
                    </trueStatements>
                  </conditionStatement>
                  <variableDeclarationStatement type="System.Int64" name="offset">
                    <init>
                      <binaryOperatorExpression operator="Subtract">
                        <argumentReferenceExpression name="record"/>
                        <fieldReferenceExpression name="currentRecordIndex"/>
                      </binaryOperatorExpression>
                    </init>
                  </variableDeclarationStatement>
                  <whileStatement>
                    <test>
                      <binaryOperatorExpression operator="GreaterThan">
                        <variableReferenceExpression name="offset"/>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </test>
                    <statements>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="ReadNextRecord"/>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <primitiveExpression value="false"/>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                      <decrementStatement>
                        <variableReferenceExpression name="offset"/>
                      </decrementStatement>
                    </statements>
                  </whileStatement>
                  <methodReturnStatement>
                    <primitiveExpression value="true"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method ParseNewLine(int) -->
              <memberMethod returnType="System.Boolean" name="ParseNewLine">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="pos" direction="Ref"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueEquality">
                        <argumentReferenceExpression name="pos"/>
                        <fieldReferenceExpression name="bufferLength"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <assignStatement>
                        <argumentReferenceExpression name="pos"/>
                        <primitiveExpression value="0"/>
                      </assignStatement>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="ReadBuffer"/>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <primitiveExpression value="false"/>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <variableDeclarationStatement type="System.Char" name="c">
                    <init>
                      <arrayIndexerExpression>
                        <target>
                          <fieldReferenceExpression name="buffer"/>
                        </target>
                        <indices>
                          <argumentReferenceExpression name="pos"/>
                        </indices>
                      </arrayIndexerExpression>
                    </init>
                  </variableDeclarationStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanAnd">
                        <binaryOperatorExpression operator="ValueEquality">
                          <variableReferenceExpression name="c"/>
                          <primitiveExpression value="&#13;" convertTo="Char"/>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="ValueInequality">
                          <fieldReferenceExpression name="delimiter"/>
                          <primitiveExpression value="&#13;" convertTo="Char"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <incrementStatement>
                        <argumentReferenceExpression name="pos"/>
                      </incrementStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="LessThan">
                            <argumentReferenceExpression name="pos"/>
                            <fieldReferenceExpression name="bufferLength"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <conditionStatement>
                            <condition>
                              <binaryOperatorExpression operator="ValueEquality">
                                <arrayIndexerExpression>
                                  <target>
                                    <fieldReferenceExpression name="buffer"/>
                                  </target>
                                  <indices>
                                    <argumentReferenceExpression name="pos"/>
                                  </indices>
                                </arrayIndexerExpression>
                                <primitiveExpression value="&#10;" convertTo="Char"/>
                              </binaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <incrementStatement>
                                <argumentReferenceExpression name="pos"/>
                              </incrementStatement>
                            </trueStatements>
                          </conditionStatement>
                        </trueStatements>
                        <falseStatements>
                          <conditionStatement>
                            <condition>
                              <methodInvokeExpression methodName="ReadBuffer"/>
                            </condition>
                            <trueStatements>
                              <conditionStatement>
                                <condition>
                                  <binaryOperatorExpression operator="ValueEquality">
                                    <arrayIndexerExpression>
                                      <target>
                                        <fieldReferenceExpression name="buffer"/>
                                      </target>
                                      <indices>
                                        <primitiveExpression value="0"/>
                                      </indices>
                                    </arrayIndexerExpression>
                                    <primitiveExpression value="&#10;" convertTo="Char"/>
                                  </binaryOperatorExpression>
                                </condition>
                                <trueStatements>
                                  <assignStatement>
                                    <argumentReferenceExpression name="pos"/>
                                    <primitiveExpression value="1"/>
                                  </assignStatement>
                                </trueStatements>
                                <falseStatements>
                                  <assignStatement>
                                    <argumentReferenceExpression name="pos"/>
                                    <primitiveExpression value="0"/>
                                  </assignStatement>
                                </falseStatements>
                              </conditionStatement>
                            </trueStatements>
                          </conditionStatement>
                        </falseStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="GreaterThanOrEqual">
                            <argumentReferenceExpression name="pos"/>
                            <fieldReferenceExpression name="bufferLength"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodInvokeExpression methodName="ReadBuffer"/>
                          <assignStatement>
                            <argumentReferenceExpression name="pos"/>
                            <primitiveExpression value="0"/>
                          </assignStatement>
                        </trueStatements>
                      </conditionStatement>
                      <methodReturnStatement>
                        <primitiveExpression value="true"/>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <variableReferenceExpression name="c"/>
                            <primitiveExpression value="&#10;" convertTo="Char"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <incrementStatement>
                            <argumentReferenceExpression name="pos"/>
                          </incrementStatement>
                          <conditionStatement>
                            <condition>
                              <binaryOperatorExpression operator="GreaterThanOrEqual">
                                <argumentReferenceExpression name="pos"/>
                                <fieldReferenceExpression name="bufferLength"/>
                              </binaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <methodInvokeExpression methodName="ReadBuffer"/>
                              <assignStatement>
                                <argumentReferenceExpression name="pos"/>
                                <primitiveExpression value="0"/>
                              </assignStatement>
                            </trueStatements>
                          </conditionStatement>
                          <methodReturnStatement>
                            <primitiveExpression value="true"/>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                    </falseStatements>
                  </conditionStatement>

                  <methodReturnStatement>
                    <primitiveExpression value="false"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IsNewLine(int)-->
              <memberMethod returnType="System.Boolean" name="IsNewLine">
                <attributes private="true" family="true"/>
                <parameters>
                  <parameter type="System.Int32" name="pos"/>
                </parameters>
                <statements>
                  <variableDeclarationStatement type="System.Char" name="c">
                    <init>
                      <arrayIndexerExpression>
                        <target>
                          <fieldReferenceExpression name="buffer"/>
                        </target>
                        <indices>
                          <argumentReferenceExpression name="pos"/>
                        </indices>
                      </arrayIndexerExpression>
                    </init>
                  </variableDeclarationStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueEquality">
                        <variableReferenceExpression name="c"/>
                        <primitiveExpression value="&#10;" convertTo="Char"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <primitiveExpression value="true"/>
                      </methodReturnStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanAnd">
                        <binaryOperatorExpression operator="ValueEquality">
                          <variableReferenceExpression name="c"/>
                          <primitiveExpression value="&#13;" convertTo="Char"/>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="ValueInequality">
                          <fieldReferenceExpression name="delimiter"/>
                          <primitiveExpression value="&#13;" convertTo="Char"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <primitiveExpression value="true"/>
                      </methodReturnStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodReturnStatement>
                    <primitiveExpression value="false"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method ReadBuffer-->
              <memberMethod returnType="System.Boolean" name="ReadBuffer">
                <attributes private="true" final="true"/>
                <statements>
                  <conditionStatement>
                    <condition>
                      <fieldReferenceExpression name="eof"/>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <primitiveExpression value="false"/>
                      </methodReturnStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodInvokeExpression methodName="CheckDisposed"/>
                  <assignStatement>
                    <fieldReferenceExpression name="bufferLength"/>
                    <methodInvokeExpression methodName="Read">
                      <target>
                        <fieldReferenceExpression name="reader"/>
                      </target>
                      <parameters>
                        <fieldReferenceExpression name="buffer"/>
                        <primitiveExpression value="0"/>
                        <fieldReferenceExpression name="bufferSize"/>
                      </parameters>
                    </methodInvokeExpression>
                  </assignStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="GreaterThan">
                        <fieldReferenceExpression name="bufferLength"/>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <primitiveExpression value="true"/>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <assignStatement>
                        <fieldReferenceExpression name="eof"/>
                        <primitiveExpression value="true"/>
                      </assignStatement>
                      <assignStatement>
                        <fieldReferenceExpression name="buffer"/>
                        <primitiveExpression value="null"/>
                      </assignStatement>
                      <methodReturnStatement>
                        <primitiveExpression value="false"/>
                      </methodReturnStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method ReadField(int, bool, bool)-->
              <memberMethod returnType="System.String" name="ReadField">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="field"/>
                  <parameter type="System.Boolean" name="initializing"/>
                  <parameter type="System.Boolean" name="discardValue"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="Not">
                        <argumentReferenceExpression name="initializing"/>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="BooleanOr">
                            <binaryOperatorExpression operator="LessThan">
                              <argumentReferenceExpression name="field"/>
                              <primitiveExpression value="0"/>
                            </binaryOperatorExpression>
                            <binaryOperatorExpression operator="GreaterThanOrEqual">
                              <argumentReferenceExpression name="field"/>
                              <fieldReferenceExpression name="fieldCount"/>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <throwExceptionStatement>
                            <objectCreateExpression type="ArgumentOutOfRangeException">
                              <parameters>
                                <primitiveExpression value="field"/>
                                <argumentReferenceExpression name="field"/>
                                <methodInvokeExpression methodName="Format">
                                  <target>
                                    <typeReferenceExpression type="String"/>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="InvariantCulture">
                                      <typeReferenceExpression type="CultureInfo"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="FieldIndexOutOfRange">
                                      <typeReferenceExpression type="ExceptionMessage"/>
                                    </propertyReferenceExpression>
                                    <argumentReferenceExpression name="field"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </parameters>
                            </objectCreateExpression>
                          </throwExceptionStatement>
                        </trueStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="LessThan">
                            <fieldReferenceExpression name="currentRecordIndex"/>
                            <primitiveExpression value="0"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <throwExceptionStatement>
                            <objectCreateExpression type="InvalidOperationException">
                              <parameters>
                                <propertyReferenceExpression name="NoCurrentRecord">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </throwExceptionStatement>
                        </trueStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="IdentityInequality">
                            <arrayIndexerExpression>
                              <target>
                                <fieldReferenceExpression name="fields"/>
                              </target>
                              <indices>
                                <argumentReferenceExpression name="field"/>
                              </indices>
                            </arrayIndexerExpression>
                            <primitiveExpression value="null"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <arrayIndexerExpression>
                              <target>
                                <fieldReferenceExpression name="fields"/>
                              </target>
                              <indices>
                                <argumentReferenceExpression name="field"/>
                              </indices>
                            </arrayIndexerExpression>
                          </methodReturnStatement>
                        </trueStatements>
                        <falseStatements>
                          <conditionStatement>
                            <condition>
                              <fieldReferenceExpression name="missingFieldFlag"/>
                            </condition>
                            <trueStatements>
                              <methodReturnStatement>
                                <methodInvokeExpression methodName="HandleMissingField">
                                  <parameters>
                                    <primitiveExpression value="null"/>
                                    <argumentReferenceExpression name="field"/>
                                    <directionExpression direction="Ref">
                                      <fieldReferenceExpression name="nextFieldStart"/>
                                    </directionExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </methodReturnStatement>
                            </trueStatements>
                          </conditionStatement>
                        </falseStatements>
                      </conditionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodInvokeExpression methodName="CheckDisposed"/>
                  <variableDeclarationStatement type="System.Int32" name="index">
                    <init>
                      <fieldReferenceExpression name="nextFieldIndex"/>
                    </init>
                  </variableDeclarationStatement>
                  <whileStatement>
                    <test>
                      <binaryOperatorExpression operator="LessThan">
                        <variableReferenceExpression name="index"/>
                        <binaryOperatorExpression operator="Add">
                          <argumentReferenceExpression name="field"/>
                          <primitiveExpression value="1"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </test>
                    <statements>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <fieldReferenceExpression name="nextFieldStart"/>
                            <fieldReferenceExpression name="bufferLength"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <fieldReferenceExpression name="nextFieldStart"/>
                            <primitiveExpression value="0"/>
                          </assignStatement>
                          <methodInvokeExpression methodName="ReadBuffer"/>
                        </trueStatements>
                      </conditionStatement>
                      <variableDeclarationStatement type="System.String" name="value">
                        <init>
                          <primitiveExpression value="null"/>
                        </init>
                      </variableDeclarationStatement>
                      <conditionStatement>
                        <condition>
                          <fieldReferenceExpression name="missingFieldFlag"/>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <variableReferenceExpression name="value"/>
                            <methodInvokeExpression methodName="HandleMissingField">
                              <parameters>
                                <variableReferenceExpression name="value"/>
                                <variableReferenceExpression name="index"/>
                                <directionExpression direction="Ref">
                                  <fieldReferenceExpression name="nextFieldStart"/>
                                </directionExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </assignStatement>
                        </trueStatements>
                        <falseStatements>
                          <conditionStatement>
                            <condition>
                              <binaryOperatorExpression operator="ValueEquality">
                                <fieldReferenceExpression name="nextFieldStart"/>
                                <fieldReferenceExpression name="bufferLength"/>
                              </binaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <conditionStatement>
                                <condition>
                                  <binaryOperatorExpression operator="ValueEquality">
                                    <variableReferenceExpression name="index"/>
                                    <argumentReferenceExpression name="field"/>
                                  </binaryOperatorExpression>
                                </condition>
                                <trueStatements>
                                  <conditionStatement>
                                    <condition>
                                      <unaryOperatorExpression operator="Not">
                                        <argumentReferenceExpression name="discardValue"/>
                                      </unaryOperatorExpression>
                                    </condition>
                                    <trueStatements>
                                      <assignStatement>
                                        <variableReferenceExpression name="value"/>
                                        <propertyReferenceExpression name="Empty">
                                          <typeReferenceExpression type="String"/>
                                        </propertyReferenceExpression>
                                      </assignStatement>
                                      <assignStatement>
                                        <arrayIndexerExpression>
                                          <target>
                                            <fieldReferenceExpression name="fields"/>
                                          </target>
                                          <indices>
                                            <variableReferenceExpression name="index"/>
                                          </indices>
                                        </arrayIndexerExpression>
                                        <variableReferenceExpression name="value"/>
                                      </assignStatement>
                                    </trueStatements>
                                  </conditionStatement>
                                  <assignStatement>
                                    <fieldReferenceExpression name="missingFieldFlag"/>
                                    <primitiveExpression value="true"/>
                                  </assignStatement>
                                </trueStatements>
                                <falseStatements>
                                  <assignStatement>
                                    <variableReferenceExpression name="value"/>
                                    <methodInvokeExpression methodName="HandleMissingField">
                                      <parameters>
                                        <variableReferenceExpression name="value"/>
                                        <variableReferenceExpression name="index"/>
                                        <directionExpression direction="Ref">
                                          <fieldReferenceExpression name="nextFieldStart"/>
                                        </directionExpression>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </assignStatement>
                                </falseStatements>
                              </conditionStatement>
                            </trueStatements>
                            <falseStatements>

                              <conditionStatement>
                                <condition>
                                  <binaryOperatorExpression operator="IdentityInequality">
                                    <binaryOperatorExpression operator="BitwiseAnd">
                                      <fieldReferenceExpression name="trimmingOptions"/>
                                      <propertyReferenceExpression name="UnquotedOnly">
                                        <typeReferenceExpression type="ValueTrimmingOptions"/>
                                      </propertyReferenceExpression>
                                    </binaryOperatorExpression>
                                    <primitiveExpression value="0"/>
                                  </binaryOperatorExpression>
                                </condition>
                                <trueStatements>
                                  <methodInvokeExpression methodName="SkipWhiteSpaces">
                                    <parameters>
                                      <directionExpression direction="Ref">
                                        <fieldReferenceExpression name="nextFieldStart"/>
                                      </directionExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </trueStatements>
                              </conditionStatement>
                              <conditionStatement>
                                <condition>
                                  <fieldReferenceExpression name="eof"/>
                                </condition>
                                <trueStatements>
                                  <assignStatement>
                                    <variableReferenceExpression name="value"/>
                                    <propertyReferenceExpression name="Empty">
                                      <typeReferenceExpression type="String"/>
                                    </propertyReferenceExpression>
                                  </assignStatement>
                                  <assignStatement>
                                    <arrayIndexerExpression>
                                      <target>
                                        <fieldReferenceExpression name="fields"/>
                                      </target>
                                      <indices>
                                        <argumentReferenceExpression name="field"/>
                                      </indices>
                                    </arrayIndexerExpression>
                                    <variableReferenceExpression name="value"/>
                                  </assignStatement>
                                  <conditionStatement>
                                    <condition>
                                      <binaryOperatorExpression operator="LessThan">
                                        <variableReferenceExpression name="field"/>
                                        <fieldReferenceExpression name="fieldCount"/>
                                      </binaryOperatorExpression>
                                    </condition>
                                    <trueStatements>
                                      <assignStatement>
                                        <fieldReferenceExpression name="missingFieldFlag"/>
                                        <primitiveExpression value="true"/>
                                      </assignStatement>
                                    </trueStatements>
                                  </conditionStatement>
                                </trueStatements>
                                <falseStatements>
                                  <conditionStatement>
                                    <condition>
                                      <binaryOperatorExpression operator="ValueInequality">
                                        <arrayIndexerExpression>
                                          <target>
                                            <fieldReferenceExpression name="buffer"/>
                                          </target>
                                          <indices>
                                            <fieldReferenceExpression name="nextFieldStart"/>
                                          </indices>
                                        </arrayIndexerExpression>
                                        <fieldReferenceExpression name="quote"/>
                                      </binaryOperatorExpression>
                                    </condition>
                                    <trueStatements>
                                      <variableDeclarationStatement type="System.Int32" name="start">
                                        <init>
                                          <fieldReferenceExpression name="nextFieldStart"/>
                                        </init>
                                      </variableDeclarationStatement>
                                      <variableDeclarationStatement type="System.Int32" name="pos">
                                        <init>
                                          <fieldReferenceExpression name="nextFieldStart"/>
                                        </init>
                                      </variableDeclarationStatement>
                                      <whileStatement>
                                        <test>
                                          <primitiveExpression value="true"/>
                                        </test>
                                        <statements>
                                          <comment>read characters</comment>
                                          <whileStatement>
                                            <test>
                                              <binaryOperatorExpression operator="LessThan">
                                                <variableReferenceExpression name="pos"/>
                                                <fieldReferenceExpression name="bufferLength"/>
                                              </binaryOperatorExpression>
                                            </test>
                                            <statements>
                                              <variableDeclarationStatement type="System.Char" name="c">
                                                <init>
                                                  <arrayIndexerExpression>
                                                    <target>
                                                      <fieldReferenceExpression name="buffer"/>
                                                    </target>
                                                    <indices>
                                                      <variableReferenceExpression name="pos"/>
                                                    </indices>
                                                  </arrayIndexerExpression>
                                                </init>
                                              </variableDeclarationStatement>
                                              <conditionStatement>
                                                <condition>
                                                  <binaryOperatorExpression operator="ValueEquality">
                                                    <variableReferenceExpression name="c"/>
                                                    <fieldReferenceExpression name="delimiter"/>
                                                  </binaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <assignStatement>
                                                    <fieldReferenceExpression name="nextFieldStart"/>
                                                    <binaryOperatorExpression operator="Add">
                                                      <variableReferenceExpression name="pos"/>
                                                      <primitiveExpression value="1"/>
                                                    </binaryOperatorExpression>
                                                  </assignStatement>
                                                  <breakStatement/>
                                                </trueStatements>
                                                <falseStatements>
                                                  <conditionStatement>
                                                    <condition>
                                                      <binaryOperatorExpression operator="BooleanOr">
                                                        <binaryOperatorExpression operator="ValueEquality">
                                                          <variableReferenceExpression name="c"/>
                                                          <primitiveExpression value="&#13;" convertTo="Char"/>
                                                        </binaryOperatorExpression>
                                                        <binaryOperatorExpression operator="ValueEquality">
                                                          <variableReferenceExpression name="c"/>
                                                          <primitiveExpression value="&#10;" convertTo="Char"/>
                                                        </binaryOperatorExpression>
                                                      </binaryOperatorExpression>
                                                    </condition>
                                                    <trueStatements>
                                                      <assignStatement>
                                                        <fieldReferenceExpression name="nextFieldStart"/>
                                                        <variableReferenceExpression name="pos"/>
                                                      </assignStatement>
                                                      <assignStatement>
                                                        <fieldReferenceExpression name="eol"/>
                                                        <primitiveExpression value="true"/>
                                                      </assignStatement>
                                                      <breakStatement/>
                                                    </trueStatements>
                                                    <falseStatements>
                                                      <incrementStatement>
                                                        <variableReferenceExpression name="pos"/>
                                                      </incrementStatement>
                                                    </falseStatements>
                                                  </conditionStatement>
                                                </falseStatements>
                                              </conditionStatement>
                                            </statements>
                                          </whileStatement>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="LessThan">
                                                <variableReferenceExpression name="pos"/>
                                                <fieldReferenceExpression name="bufferLength"/>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <breakStatement/>
                                            </trueStatements>
                                            <falseStatements>
                                              <conditionStatement>
                                                <condition>
                                                  <unaryOperatorExpression operator="Not">
                                                    <argumentReferenceExpression name="discardValue"/>
                                                  </unaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <assignStatement>
                                                    <variableReferenceExpression name="value"/>
                                                    <binaryOperatorExpression operator="Add">
                                                      <variableReferenceExpression name="value"/>
                                                      <objectCreateExpression type="System.String">
                                                        <parameters>
                                                          <fieldReferenceExpression name="buffer"/>
                                                          <variableReferenceExpression name="start"/>
                                                          <binaryOperatorExpression operator="Subtract">
                                                            <variableReferenceExpression name="pos"/>
                                                            <variableReferenceExpression name="start"/>
                                                          </binaryOperatorExpression>
                                                        </parameters>
                                                      </objectCreateExpression>
                                                    </binaryOperatorExpression>
                                                  </assignStatement>
                                                </trueStatements>
                                              </conditionStatement>
                                              <assignStatement>
                                                <variableReferenceExpression name="start"/>
                                                <primitiveExpression value="0"/>
                                              </assignStatement>
                                              <assignStatement>
                                                <variableReferenceExpression name="pos"/>
                                                <primitiveExpression value="0"/>
                                              </assignStatement>
                                              <assignStatement>
                                                <fieldReferenceExpression name="nextFieldStart"/>
                                                <primitiveExpression value="0"/>
                                              </assignStatement>
                                              <conditionStatement>
                                                <condition>
                                                  <unaryOperatorExpression operator="Not">
                                                    <methodInvokeExpression methodName="ReadBuffer"/>
                                                  </unaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <breakStatement/>
                                                </trueStatements>
                                              </conditionStatement>
                                            </falseStatements>
                                          </conditionStatement>
                                        </statements>
                                      </whileStatement>
                                      <conditionStatement>
                                        <condition>
                                          <unaryOperatorExpression operator="Not">
                                            <argumentReferenceExpression name="discardValue"/>
                                          </unaryOperatorExpression>
                                        </condition>
                                        <trueStatements>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="ValueEquality">
                                                <binaryOperatorExpression operator="BitwiseAnd">
                                                  <fieldReferenceExpression name="trimmingOptions"/>
                                                  <propertyReferenceExpression name="UnquotedOnly">
                                                    <typeReferenceExpression type="ValueTrimmingOptions"/>
                                                  </propertyReferenceExpression>
                                                </binaryOperatorExpression>
                                                <primitiveExpression value="0"/>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <conditionStatement>
                                                <condition>
                                                  <binaryOperatorExpression operator="BooleanAnd">
                                                    <unaryOperatorExpression operator="Not">
                                                      <fieldReferenceExpression name="eof"/>
                                                    </unaryOperatorExpression>
                                                    <binaryOperatorExpression operator="GreaterThan">
                                                      <variableReferenceExpression name="pos"/>
                                                      <variableReferenceExpression name="start"/>
                                                    </binaryOperatorExpression>
                                                  </binaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <assignStatement>
                                                    <variableReferenceExpression name="value"/>
                                                    <binaryOperatorExpression operator="Add">
                                                      <variableReferenceExpression name="value"/>
                                                      <objectCreateExpression type="System.String">
                                                        <parameters>
                                                          <fieldReferenceExpression name="buffer"/>
                                                          <variableReferenceExpression name="start"/>
                                                          <binaryOperatorExpression operator="Subtract">
                                                            <variableReferenceExpression name="pos"/>
                                                            <variableReferenceExpression name="start"/>
                                                          </binaryOperatorExpression>
                                                        </parameters>
                                                      </objectCreateExpression>
                                                    </binaryOperatorExpression>
                                                  </assignStatement>
                                                </trueStatements>
                                              </conditionStatement>
                                            </trueStatements>
                                            <falseStatements>
                                              <conditionStatement>
                                                <condition>
                                                  <binaryOperatorExpression operator="BooleanAnd">
                                                    <unaryOperatorExpression operator="Not">
                                                      <fieldReferenceExpression name="eof"/>
                                                    </unaryOperatorExpression>
                                                    <binaryOperatorExpression operator="GreaterThan">
                                                      <variableReferenceExpression name="pos"/>
                                                      <variableReferenceExpression name="start"/>
                                                    </binaryOperatorExpression>
                                                  </binaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <decrementStatement>
                                                    <variableReferenceExpression name="pos"/>
                                                  </decrementStatement>
                                                  <whileStatement>
                                                    <test>
                                                      <binaryOperatorExpression operator="BooleanAnd">
                                                        <binaryOperatorExpression operator="GreaterThan">
                                                          <variableReferenceExpression name="pos"/>
                                                          <primitiveExpression value="-1"/>
                                                        </binaryOperatorExpression>
                                                        <methodInvokeExpression methodName="IsWhiteSpace">
                                                          <parameters>
                                                            <arrayIndexerExpression>
                                                              <target>
                                                                <fieldReferenceExpression name="buffer"/>
                                                              </target>
                                                              <indices>
                                                                <variableReferenceExpression name="pos"/>
                                                              </indices>
                                                            </arrayIndexerExpression>
                                                          </parameters>
                                                        </methodInvokeExpression>
                                                      </binaryOperatorExpression>
                                                    </test>
                                                    <statements>
                                                      <decrementStatement>
                                                        <variableReferenceExpression name="pos"/>
                                                      </decrementStatement>
                                                    </statements>
                                                  </whileStatement>
                                                  <incrementStatement>
                                                    <variableReferenceExpression name="pos"/>
                                                  </incrementStatement>
                                                  <conditionStatement>
                                                    <condition>
                                                      <binaryOperatorExpression operator="GreaterThan">
                                                        <variableReferenceExpression name="pos"/>
                                                        <primitiveExpression value="0"/>
                                                      </binaryOperatorExpression>
                                                    </condition>
                                                    <trueStatements>
                                                      <assignStatement>
                                                        <variableReferenceExpression name="value"/>
                                                        <binaryOperatorExpression operator="Add">
                                                          <variableReferenceExpression name="value"/>
                                                          <objectCreateExpression type="System.String">
                                                            <parameters>
                                                              <fieldReferenceExpression name="buffer"/>
                                                              <variableReferenceExpression name="start"/>
                                                              <binaryOperatorExpression operator="Subtract">
                                                                <variableReferenceExpression name="pos"/>
                                                                <variableReferenceExpression name="start"/>
                                                              </binaryOperatorExpression>
                                                            </parameters>
                                                          </objectCreateExpression>
                                                        </binaryOperatorExpression>
                                                      </assignStatement>
                                                    </trueStatements>
                                                  </conditionStatement>
                                                </trueStatements>
                                                <falseStatements>
                                                  <assignStatement>
                                                    <variableReferenceExpression name="pos"/>
                                                    <primitiveExpression value="-1"/>
                                                  </assignStatement>
                                                </falseStatements>
                                              </conditionStatement>
                                              <conditionStatement>
                                                <condition>
                                                  <binaryOperatorExpression operator="LessThanOrEqual">
                                                    <variableReferenceExpression name="pos"/>
                                                    <primitiveExpression value="0"/>
                                                  </binaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <conditionStatement>
                                                    <condition>
                                                      <binaryOperatorExpression operator="IdentityEquality">
                                                        <variableReferenceExpression name="value"/>
                                                        <primitiveExpression value="null"/>
                                                      </binaryOperatorExpression>
                                                    </condition>
                                                    <trueStatements>
                                                      <assignStatement>
                                                        <variableReferenceExpression name="pos"/>
                                                        <primitiveExpression value="-1"/>
                                                      </assignStatement>
                                                    </trueStatements>
                                                    <falseStatements>
                                                      <assignStatement>
                                                        <variableReferenceExpression name="pos"/>
                                                        <binaryOperatorExpression operator="Subtract">
                                                          <propertyReferenceExpression name="Length">
                                                            <variableReferenceExpression name="value"/>
                                                          </propertyReferenceExpression>
                                                          <primitiveExpression value="1"/>
                                                        </binaryOperatorExpression>
                                                      </assignStatement>
                                                    </falseStatements>
                                                  </conditionStatement>
                                                  <whileStatement>
                                                    <test>
                                                      <binaryOperatorExpression operator="BooleanAnd">
                                                        <binaryOperatorExpression operator="GreaterThan">
                                                          <variableReferenceExpression name="pos"/>
                                                          <primitiveExpression value="-1"/>
                                                        </binaryOperatorExpression>
                                                        <methodInvokeExpression methodName="IsWhiteSpace">
                                                          <parameters>
                                                            <arrayIndexerExpression>
                                                              <target>
                                                                <variableReferenceExpression name="value"/>
                                                              </target>
                                                              <indices>
                                                                <variableReferenceExpression name="pos"/>
                                                              </indices>
                                                            </arrayIndexerExpression>
                                                          </parameters>
                                                        </methodInvokeExpression>
                                                      </binaryOperatorExpression>
                                                    </test>
                                                    <statements>
                                                      <decrementStatement>
                                                        <variableReferenceExpression name="pos"/>
                                                      </decrementStatement>
                                                    </statements>
                                                  </whileStatement>
                                                  <incrementStatement>
                                                    <variableReferenceExpression name="pos"/>
                                                  </incrementStatement>
                                                  <conditionStatement>
                                                    <condition>
                                                      <binaryOperatorExpression operator="BooleanAnd">
                                                        <binaryOperatorExpression operator="GreaterThan">
                                                          <variableReferenceExpression name="pos"/>
                                                          <primitiveExpression value="0"/>
                                                        </binaryOperatorExpression>
                                                        <binaryOperatorExpression operator="ValueInequality">
                                                          <variableReferenceExpression name="pos"/>
                                                          <propertyReferenceExpression name="Length">
                                                            <variableReferenceExpression name="value"/>
                                                          </propertyReferenceExpression>
                                                        </binaryOperatorExpression>
                                                      </binaryOperatorExpression>
                                                    </condition>
                                                    <trueStatements>
                                                      <assignStatement>
                                                        <variableReferenceExpression name="value"/>
                                                        <methodInvokeExpression methodName="Substring">
                                                          <target>
                                                            <variableReferenceExpression name="value"/>
                                                          </target>
                                                          <parameters>
                                                            <primitiveExpression value="0"/>
                                                            <variableReferenceExpression name="pos"/>
                                                          </parameters>
                                                        </methodInvokeExpression>
                                                      </assignStatement>
                                                    </trueStatements>
                                                  </conditionStatement>
                                                </trueStatements>
                                              </conditionStatement>
                                            </falseStatements>
                                          </conditionStatement>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="IdentityEquality">
                                                <variableReferenceExpression name="value"/>
                                                <primitiveExpression value="null"/>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <assignStatement>
                                                <variableReferenceExpression name="value"/>
                                                <propertyReferenceExpression name="Empty">
                                                  <typeReferenceExpression type="System.String"/>
                                                </propertyReferenceExpression>
                                              </assignStatement>
                                            </trueStatements>
                                          </conditionStatement>
                                        </trueStatements>
                                      </conditionStatement>
                                      <conditionStatement>
                                        <condition>
                                          <binaryOperatorExpression operator="BooleanOr">
                                            <fieldReferenceExpression name="eol"/>
                                            <fieldReferenceExpression name="eof"/>
                                          </binaryOperatorExpression>
                                        </condition>
                                        <trueStatements>
                                          <assignStatement>
                                            <fieldReferenceExpression name="eol"/>
                                            <methodInvokeExpression methodName="ParseNewLine">
                                              <parameters>
                                                <directionExpression direction="Ref">
                                                  <fieldReferenceExpression name="nextFieldStart"/>
                                                </directionExpression>
                                              </parameters>
                                            </methodInvokeExpression>
                                          </assignStatement>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="BooleanAnd">
                                                <unaryOperatorExpression operator="Not">
                                                  <variableReferenceExpression name="initializing"/>
                                                </unaryOperatorExpression>
                                                <binaryOperatorExpression operator="ValueInequality">
                                                  <variableReferenceExpression name="index"/>
                                                  <binaryOperatorExpression operator="Subtract">
                                                    <fieldReferenceExpression name="fieldCount"/>
                                                    <primitiveExpression value="1"/>
                                                  </binaryOperatorExpression>
                                                </binaryOperatorExpression>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <conditionStatement>
                                                <condition>
                                                  <binaryOperatorExpression operator="BooleanAnd">
                                                    <binaryOperatorExpression operator="IdentityInequality">
                                                      <variableReferenceExpression name="value"/>
                                                      <primitiveExpression value="null"/>
                                                    </binaryOperatorExpression>
                                                    <binaryOperatorExpression operator="ValueEquality">
                                                      <propertyReferenceExpression name="Length">
                                                        <variableReferenceExpression name="value"/>
                                                      </propertyReferenceExpression>
                                                      <primitiveExpression value="0"/>
                                                    </binaryOperatorExpression>
                                                  </binaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <assignStatement>
                                                    <variableReferenceExpression name="value"/>
                                                    <primitiveExpression value="null"/>
                                                  </assignStatement>
                                                </trueStatements>
                                              </conditionStatement>
                                              <assignStatement>
                                                <variableReferenceExpression name="value"/>
                                                <methodInvokeExpression methodName="HandleMissingField">
                                                  <parameters>
                                                    <variableReferenceExpression name="value"/>
                                                    <variableReferenceExpression name="index"/>
                                                    <directionExpression direction="Ref">
                                                      <fieldReferenceExpression name="nextFieldStart"/>
                                                    </directionExpression>
                                                  </parameters>
                                                </methodInvokeExpression>
                                              </assignStatement>
                                            </trueStatements>
                                          </conditionStatement>
                                        </trueStatements>
                                      </conditionStatement>
                                      <conditionStatement>
                                        <condition>
                                          <unaryOperatorExpression operator="Not">
                                            <variableReferenceExpression name="discardValue"/>
                                          </unaryOperatorExpression>
                                        </condition>
                                        <trueStatements>
                                          <assignStatement>
                                            <arrayIndexerExpression>
                                              <target>
                                                <fieldReferenceExpression name="fields"/>
                                              </target>
                                              <indices>
                                                <variableReferenceExpression name="index"/>
                                              </indices>
                                            </arrayIndexerExpression>
                                            <variableReferenceExpression name="value"/>
                                          </assignStatement>
                                        </trueStatements>
                                      </conditionStatement>
                                    </trueStatements>
                                    <falseStatements>
                                      <variableDeclarationStatement type="System.Int32" name="start">
                                        <init>
                                          <binaryOperatorExpression operator="Add">
                                            <fieldReferenceExpression name="nextFieldStart"/>
                                            <primitiveExpression value="1"/>
                                          </binaryOperatorExpression>
                                        </init>
                                      </variableDeclarationStatement>
                                      <variableDeclarationStatement type="System.Int32" name="pos">
                                        <init>
                                          <variableReferenceExpression name="start"/>
                                        </init>
                                      </variableDeclarationStatement>
                                      <variableDeclarationStatement type="System.Boolean" name="quoted">
                                        <init>
                                          <primitiveExpression value="true"/>
                                        </init>
                                      </variableDeclarationStatement>
                                      <variableDeclarationStatement type="System.Boolean" name="escaped">
                                        <init>
                                          <primitiveExpression value="false"/>
                                        </init>
                                      </variableDeclarationStatement>
                                      <conditionStatement>
                                        <condition>
                                          <binaryOperatorExpression operator="ValueInequality">
                                            <binaryOperatorExpression operator="BitwiseAnd">
                                              <fieldReferenceExpression name="trimmingOptions"/>
                                              <propertyReferenceExpression name="QuotedOnly">
                                                <typeReferenceExpression type="ValueTrimmingOptions"/>
                                              </propertyReferenceExpression>
                                            </binaryOperatorExpression>
                                            <primitiveExpression value="0"/>
                                          </binaryOperatorExpression>
                                        </condition>
                                        <trueStatements>
                                          <methodInvokeExpression methodName="SkipWhiteSpaces">
                                            <parameters>
                                              <directionExpression direction="Ref">
                                                <variableReferenceExpression name="start"/>
                                              </directionExpression>
                                            </parameters>
                                          </methodInvokeExpression>
                                          <assignStatement>
                                            <variableReferenceExpression name="pos"/>
                                            <variableReferenceExpression name="start"/>
                                          </assignStatement>
                                        </trueStatements>
                                      </conditionStatement>
                                      <whileStatement>
                                        <test>
                                          <primitiveExpression value="true"/>
                                        </test>
                                        <statements>
                                          <comment>read value</comment>
                                          <whileStatement>
                                            <test>
                                              <binaryOperatorExpression operator="LessThan">
                                                <variableReferenceExpression name="pos"/>
                                                <fieldReferenceExpression name="bufferLength"/>
                                              </binaryOperatorExpression>
                                            </test>
                                            <statements>
                                              <variableDeclarationStatement type="System.Char" name="c">
                                                <init>
                                                  <arrayIndexerExpression>
                                                    <target>
                                                      <fieldReferenceExpression name="buffer"/>
                                                    </target>
                                                    <indices>
                                                      <variableReferenceExpression name="pos"/>
                                                    </indices>
                                                  </arrayIndexerExpression>
                                                </init>
                                              </variableDeclarationStatement>
                                              <conditionStatement>
                                                <condition>
                                                  <variableReferenceExpression name="escaped"/>
                                                </condition>
                                                <trueStatements>
                                                  <assignStatement>
                                                    <variableReferenceExpression name="escaped"/>
                                                    <primitiveExpression value="false"/>
                                                  </assignStatement>
                                                  <assignStatement>
                                                    <variableReferenceExpression name="start"/>
                                                    <variableReferenceExpression name="pos"/>
                                                  </assignStatement>
                                                </trueStatements>
                                                <falseStatements>
                                                  <conditionStatement>
                                                    <condition>
                                                      <binaryOperatorExpression operator="BooleanAnd">
                                                        <binaryOperatorExpression operator="ValueEquality">
                                                          <variableReferenceExpression name="c"/>
                                                          <fieldReferenceExpression name="escape"/>
                                                        </binaryOperatorExpression>
                                                        <binaryOperatorExpression operator="BooleanOr">
                                                          <binaryOperatorExpression operator="ValueInequality">
                                                            <fieldReferenceExpression name="escape"/>
                                                            <fieldReferenceExpression name="quote"/>
                                                          </binaryOperatorExpression>
                                                          <binaryOperatorExpression operator="BooleanOr">
                                                            <binaryOperatorExpression operator="BooleanAnd">
                                                              <binaryOperatorExpression operator="LessThan">
                                                                <binaryOperatorExpression operator="Add">
                                                                  <variableReferenceExpression name="pos"/>
                                                                  <primitiveExpression value="1"/>
                                                                </binaryOperatorExpression>
                                                                <fieldReferenceExpression name="bufferLength"/>
                                                              </binaryOperatorExpression>
                                                              <binaryOperatorExpression operator="ValueEquality">
                                                                <arrayIndexerExpression>
                                                                  <target>
                                                                    <fieldReferenceExpression name="buffer"/>
                                                                  </target>
                                                                  <indices>
                                                                    <binaryOperatorExpression operator="Add">
                                                                      <variableReferenceExpression name="pos"/>
                                                                      <primitiveExpression value="1"/>
                                                                    </binaryOperatorExpression>
                                                                  </indices>
                                                                </arrayIndexerExpression>
                                                                <fieldReferenceExpression name="quote"/>
                                                              </binaryOperatorExpression>
                                                            </binaryOperatorExpression>
                                                            <binaryOperatorExpression operator="BooleanAnd">
                                                              <binaryOperatorExpression operator="ValueEquality">
                                                                <binaryOperatorExpression operator="Add">
                                                                  <variableReferenceExpression name="pos"/>
                                                                  <primitiveExpression value="1"/>
                                                                </binaryOperatorExpression>
                                                                <fieldReferenceExpression name="bufferLength"/>
                                                              </binaryOperatorExpression>
                                                              <methodInvokeExpression methodName="Equals">
                                                                <target>
                                                                  <methodInvokeExpression methodName="Peek">
                                                                    <target>
                                                                      <fieldReferenceExpression name="reader"/>
                                                                    </target>
                                                                  </methodInvokeExpression>
                                                                </target>
                                                                <parameters>
                                                                  <fieldReferenceExpression name="quote"/>
                                                                </parameters>
                                                              </methodInvokeExpression>
                                                            </binaryOperatorExpression>
                                                          </binaryOperatorExpression>
                                                        </binaryOperatorExpression>
                                                      </binaryOperatorExpression>
                                                    </condition>
                                                    <trueStatements>
                                                      <conditionStatement>
                                                        <condition>
                                                          <unaryOperatorExpression operator="Not">
                                                            <argumentReferenceExpression name="discardValue"/>
                                                          </unaryOperatorExpression>
                                                        </condition>
                                                        <trueStatements>
                                                          <assignStatement>
                                                            <variableReferenceExpression name="value"/>
                                                            <binaryOperatorExpression operator="Add">
                                                              <variableReferenceExpression name="value"/>
                                                              <objectCreateExpression type="System.String">
                                                                <parameters>
                                                                  <fieldReferenceExpression name="buffer"/>
                                                                  <variableReferenceExpression name="start"/>
                                                                  <binaryOperatorExpression operator="Subtract">
                                                                    <variableReferenceExpression name="pos"/>
                                                                    <variableReferenceExpression name="start"/>
                                                                  </binaryOperatorExpression>
                                                                </parameters>
                                                              </objectCreateExpression>
                                                            </binaryOperatorExpression>
                                                          </assignStatement>
                                                        </trueStatements>
                                                      </conditionStatement>
                                                      <assignStatement>
                                                        <variableReferenceExpression name="escaped"/>
                                                        <primitiveExpression value="true"/>
                                                      </assignStatement>
                                                    </trueStatements>
                                                    <falseStatements>
                                                      <conditionStatement>
                                                        <condition>
                                                          <binaryOperatorExpression operator="ValueEquality">
                                                            <variableReferenceExpression name="c"/>
                                                            <fieldReferenceExpression name="quote"/>
                                                          </binaryOperatorExpression>
                                                        </condition>
                                                        <trueStatements>
                                                          <assignStatement>
                                                            <variableReferenceExpression name="quoted"/>
                                                            <primitiveExpression value="false"/>
                                                          </assignStatement>
                                                          <breakStatement/>
                                                        </trueStatements>
                                                      </conditionStatement>
                                                    </falseStatements>
                                                  </conditionStatement>
                                                </falseStatements>
                                              </conditionStatement>
                                              <incrementStatement>
                                                <variableReferenceExpression name="pos"/>
                                              </incrementStatement>
                                            </statements>
                                          </whileStatement>
                                          <conditionStatement>
                                            <condition>
                                              <unaryOperatorExpression operator="Not">
                                                <variableReferenceExpression name="quoted"/>
                                              </unaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <breakStatement/>
                                            </trueStatements>
                                            <falseStatements>
                                              <conditionStatement>
                                                <condition>
                                                  <binaryOperatorExpression operator="BooleanAnd">
                                                    <unaryOperatorExpression operator="Not">
                                                      <argumentReferenceExpression name="discardValue"/>
                                                    </unaryOperatorExpression>
                                                    <unaryOperatorExpression operator="Not">
                                                      <variableReferenceExpression name="escaped"/>
                                                    </unaryOperatorExpression>
                                                  </binaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <assignStatement>
                                                    <variableReferenceExpression name="value"/>
                                                    <binaryOperatorExpression operator="Add">
                                                      <variableReferenceExpression name="value"/>
                                                      <objectCreateExpression type="System.String">
                                                        <parameters>
                                                          <fieldReferenceExpression name="buffer"/>
                                                          <variableReferenceExpression name="start"/>
                                                          <binaryOperatorExpression operator="Subtract">
                                                            <variableReferenceExpression name="pos"/>
                                                            <variableReferenceExpression name="start"/>
                                                          </binaryOperatorExpression>
                                                        </parameters>
                                                      </objectCreateExpression>
                                                    </binaryOperatorExpression>
                                                  </assignStatement>
                                                </trueStatements>
                                              </conditionStatement>
                                              <assignStatement>
                                                <variableReferenceExpression name="start"/>
                                                <primitiveExpression value="0"/>
                                              </assignStatement>
                                              <assignStatement>
                                                <variableReferenceExpression name="pos"/>
                                                <primitiveExpression value="0"/>
                                              </assignStatement>
                                              <assignStatement>
                                                <fieldReferenceExpression name="nextFieldStart"/>
                                                <primitiveExpression value="0"/>
                                              </assignStatement>
                                              <conditionStatement>
                                                <condition>
                                                  <unaryOperatorExpression operator="Not">
                                                    <methodInvokeExpression methodName="ReadBuffer"/>
                                                  </unaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <methodInvokeExpression methodName="HandleParseError">
                                                    <parameters>
                                                      <objectCreateExpression type="MalformedCsvException">
                                                        <parameters>
                                                          <methodInvokeExpression methodName="GetCurrentRawData"/>
                                                          <fieldReferenceExpression name="nextFieldStart"/>
                                                          <methodInvokeExpression methodName="Max">
                                                            <target>
                                                              <typeReferenceExpression type="Math"/>
                                                            </target>
                                                            <parameters>
                                                              <primitiveExpression value="0"/>
                                                              <fieldReferenceExpression name="currentRecordIndex"/>
                                                            </parameters>
                                                          </methodInvokeExpression>
                                                          <variableReferenceExpression name="index"/>
                                                        </parameters>
                                                      </objectCreateExpression>
                                                      <directionExpression direction="Ref">
                                                        <fieldReferenceExpression name="nextFieldStart"/>
                                                      </directionExpression>
                                                    </parameters>
                                                  </methodInvokeExpression>
                                                  <methodReturnStatement>
                                                    <primitiveExpression value="null"/>
                                                  </methodReturnStatement>
                                                </trueStatements>
                                              </conditionStatement>
                                            </falseStatements>
                                          </conditionStatement>
                                        </statements>
                                      </whileStatement>
                                      <conditionStatement>
                                        <condition>
                                          <unaryOperatorExpression operator="Not">
                                            <fieldReferenceExpression name="eof"/>
                                          </unaryOperatorExpression>
                                        </condition>
                                        <trueStatements>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="BooleanAnd">
                                                <unaryOperatorExpression operator="Not">
                                                  <argumentReferenceExpression name="discardValue"/>
                                                </unaryOperatorExpression>
                                                <binaryOperatorExpression operator="GreaterThan">
                                                  <variableReferenceExpression name="pos"/>
                                                  <variableReferenceExpression name="start"/>
                                                </binaryOperatorExpression>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <assignStatement>
                                                <variableReferenceExpression name="value"/>
                                                <binaryOperatorExpression operator="Add">
                                                  <variableReferenceExpression name="value"/>
                                                  <objectCreateExpression type="System.String">
                                                    <parameters>
                                                      <fieldReferenceExpression name="buffer"/>
                                                      <variableReferenceExpression name="start"/>
                                                      <binaryOperatorExpression operator="Subtract">
                                                        <variableReferenceExpression name="pos"/>
                                                        <variableReferenceExpression name="start"/>
                                                      </binaryOperatorExpression>
                                                    </parameters>
                                                  </objectCreateExpression>
                                                </binaryOperatorExpression>
                                              </assignStatement>
                                            </trueStatements>
                                          </conditionStatement>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="BooleanAnd">
                                                <binaryOperatorExpression operator="BooleanAnd">
                                                  <unaryOperatorExpression operator="Not">
                                                    <argumentReferenceExpression name="discardValue"/>
                                                  </unaryOperatorExpression>
                                                  <binaryOperatorExpression operator="IdentityInequality">
                                                    <variableReferenceExpression name="value"/>
                                                    <primitiveExpression value="null"/>
                                                  </binaryOperatorExpression>
                                                </binaryOperatorExpression>
                                                <binaryOperatorExpression operator="ValueInequality">
                                                  <binaryOperatorExpression operator="BitwiseAnd">
                                                    <fieldReferenceExpression name="trimmingOptions"/>
                                                    <propertyReferenceExpression name="QuotedOnly">
                                                      <typeReferenceExpression type="ValueTrimmingOptions"/>
                                                    </propertyReferenceExpression>
                                                  </binaryOperatorExpression>
                                                  <primitiveExpression value="0"/>
                                                </binaryOperatorExpression>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <variableDeclarationStatement type="System.Int32" name="newLength">
                                                <init>
                                                  <propertyReferenceExpression name="Length">
                                                    <variableReferenceExpression name="value"/>
                                                  </propertyReferenceExpression>
                                                </init>
                                              </variableDeclarationStatement>
                                              <whileStatement>
                                                <test>
                                                  <binaryOperatorExpression operator="BooleanAnd">
                                                    <binaryOperatorExpression operator="GreaterThan">
                                                      <variableReferenceExpression name="newLength"/>
                                                      <primitiveExpression value="0"/>
                                                    </binaryOperatorExpression>
                                                    <methodInvokeExpression methodName="IsWhiteSpace">
                                                      <parameters>
                                                        <arrayIndexerExpression>
                                                          <target>
                                                            <variableReferenceExpression name="value"/>
                                                          </target>
                                                          <indices>
                                                            <binaryOperatorExpression operator="Subtract">
                                                              <variableReferenceExpression name="newLength"/>
                                                              <primitiveExpression value="1"/>
                                                            </binaryOperatorExpression>
                                                          </indices>
                                                        </arrayIndexerExpression>
                                                      </parameters>
                                                    </methodInvokeExpression>
                                                  </binaryOperatorExpression>
                                                </test>
                                                <statements>
                                                  <decrementStatement>
                                                    <variableReferenceExpression name="newLength"/>
                                                  </decrementStatement>
                                                </statements>
                                              </whileStatement>
                                              <conditionStatement>
                                                <condition>
                                                  <binaryOperatorExpression operator="LessThan">
                                                    <variableReferenceExpression name="newLength"/>
                                                    <propertyReferenceExpression name="Length">
                                                      <variableReferenceExpression name="value"/>
                                                    </propertyReferenceExpression>
                                                  </binaryOperatorExpression>
                                                </condition>
                                                <trueStatements>
                                                  <assignStatement>
                                                    <variableReferenceExpression name="value"/>
                                                    <methodInvokeExpression methodName="Substring">
                                                      <target>
                                                        <variableReferenceExpression name="value"/>
                                                      </target>
                                                      <parameters>
                                                        <primitiveExpression value="0"/>
                                                        <variableReferenceExpression name="newLength"/>
                                                      </parameters>
                                                    </methodInvokeExpression>
                                                  </assignStatement>
                                                </trueStatements>
                                              </conditionStatement>
                                            </trueStatements>
                                          </conditionStatement>
                                          <assignStatement>
                                            <fieldReferenceExpression name="nextFieldStart"/>
                                            <binaryOperatorExpression operator="Add">
                                              <variableReferenceExpression name="pos"/>
                                              <primitiveExpression value="1"/>
                                            </binaryOperatorExpression>
                                          </assignStatement>
                                          <methodInvokeExpression methodName="SkipWhiteSpaces">
                                            <parameters>
                                              <directionExpression direction="Ref">
                                                <fieldReferenceExpression name="nextFieldStart"/>
                                              </directionExpression>
                                            </parameters>
                                          </methodInvokeExpression>
                                          <variableDeclarationStatement type="System.Boolean" name="delimiterSkipped"/>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="BooleanAnd">
                                                <binaryOperatorExpression operator="LessThan">
                                                  <fieldReferenceExpression name="nextFieldStart"/>
                                                  <fieldReferenceExpression name="bufferLength"/>
                                                </binaryOperatorExpression>
                                                <binaryOperatorExpression operator="ValueEquality">
                                                  <arrayIndexerExpression>
                                                    <target>
                                                      <fieldReferenceExpression name="buffer"/>
                                                    </target>
                                                    <indices>
                                                      <fieldReferenceExpression name="nextFieldStart"/>
                                                    </indices>
                                                  </arrayIndexerExpression>
                                                  <fieldReferenceExpression name="delimiter"/>
                                                </binaryOperatorExpression>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <assignStatement>
                                                <variableReferenceExpression name="delimiterSkipped"/>
                                                <primitiveExpression value="true"/>
                                              </assignStatement>
                                              <incrementStatement>
                                                <fieldReferenceExpression name="nextFieldStart"/>
                                              </incrementStatement>
                                            </trueStatements>
                                            <falseStatements>
                                              <assignStatement>
                                                <variableReferenceExpression name="delimiterSkipped"/>
                                                <primitiveExpression value="false"/>
                                              </assignStatement>
                                            </falseStatements>
                                          </conditionStatement>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="BooleanAnd">
                                                <binaryOperatorExpression operator="BooleanAnd">
                                                  <unaryOperatorExpression operator="Not">
                                                    <fieldReferenceExpression name="eof"/>
                                                  </unaryOperatorExpression>
                                                  <unaryOperatorExpression operator="Not">
                                                    <variableReferenceExpression name="delimiterSkipped"/>
                                                  </unaryOperatorExpression>
                                                </binaryOperatorExpression>
                                                <binaryOperatorExpression operator="BooleanOr">
                                                  <variableReferenceExpression name="initializing"/>
                                                  <binaryOperatorExpression operator="ValueEquality">
                                                    <variableReferenceExpression name="index"/>
                                                    <binaryOperatorExpression operator="Subtract">
                                                      <fieldReferenceExpression name="fieldCount"/>
                                                      <primitiveExpression value="1"/>
                                                    </binaryOperatorExpression>
                                                  </binaryOperatorExpression>
                                                </binaryOperatorExpression>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <assignStatement>
                                                <fieldReferenceExpression name="eol"/>
                                                <methodInvokeExpression methodName="ParseNewLine">
                                                  <parameters>
                                                    <directionExpression direction="Ref">
                                                      <fieldReferenceExpression name="nextFieldStart"/>
                                                    </directionExpression>
                                                  </parameters>
                                                </methodInvokeExpression>
                                              </assignStatement>
                                            </trueStatements>
                                          </conditionStatement>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="BooleanAnd">
                                                <binaryOperatorExpression operator="BooleanAnd">
                                                  <unaryOperatorExpression operator="Not">
                                                    <variableReferenceExpression name="delimiterSkipped"/>
                                                  </unaryOperatorExpression>
                                                  <unaryOperatorExpression operator="Not">
                                                    <fieldReferenceExpression name="eof"/>
                                                  </unaryOperatorExpression>
                                                </binaryOperatorExpression>
                                                <unaryOperatorExpression operator="Not">
                                                  <binaryOperatorExpression operator="BooleanOr">
                                                    <fieldReferenceExpression name="eol"/>
                                                    <methodInvokeExpression methodName="IsNewLine">
                                                      <parameters>
                                                        <fieldReferenceExpression name="nextFieldStart"/>
                                                      </parameters>
                                                    </methodInvokeExpression>
                                                  </binaryOperatorExpression>
                                                </unaryOperatorExpression>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <methodInvokeExpression methodName="HandleParseError">
                                                <parameters>
                                                  <objectCreateExpression type="MalformedCsvException">
                                                    <parameters>
                                                      <methodInvokeExpression methodName="GetCurrentRawData"/>
                                                      <fieldReferenceExpression name="nextFieldStart"/>
                                                      <methodInvokeExpression methodName="Max">
                                                        <target>
                                                          <typeReferenceExpression type="Math"/>
                                                        </target>
                                                        <parameters>
                                                          <primitiveExpression value="0"/>
                                                          <fieldReferenceExpression name="currentRecordIndex"/>
                                                        </parameters>
                                                      </methodInvokeExpression>
                                                      <variableReferenceExpression name="index"/>
                                                    </parameters>
                                                  </objectCreateExpression>
                                                  <directionExpression direction="Ref">
                                                    <fieldReferenceExpression name="nextFieldStart"/>
                                                  </directionExpression>
                                                </parameters>
                                              </methodInvokeExpression>

                                            </trueStatements>
                                          </conditionStatement>
                                        </trueStatements>
                                      </conditionStatement>
                                      <conditionStatement>
                                        <condition>
                                          <unaryOperatorExpression operator="Not">
                                            <argumentReferenceExpression name="discardValue"/>
                                          </unaryOperatorExpression>
                                        </condition>
                                        <trueStatements>
                                          <conditionStatement>
                                            <condition>
                                              <binaryOperatorExpression operator="IdentityEquality">
                                                <variableReferenceExpression name="value"/>
                                                <primitiveExpression value="null"/>
                                              </binaryOperatorExpression>
                                            </condition>
                                            <trueStatements>
                                              <assignStatement>
                                                <variableReferenceExpression name="value"/>
                                                <propertyReferenceExpression name="Empty">
                                                  <typeReferenceExpression type="System.String"/>
                                                </propertyReferenceExpression>
                                              </assignStatement>
                                            </trueStatements>
                                          </conditionStatement>
                                          <assignStatement>
                                            <arrayIndexerExpression>
                                              <target>
                                                <fieldReferenceExpression name="fields"/>
                                              </target>
                                              <indices>
                                                <variableReferenceExpression name="index"/>
                                              </indices>
                                            </arrayIndexerExpression>
                                            <variableReferenceExpression name="value"/>
                                          </assignStatement>
                                        </trueStatements>
                                      </conditionStatement>
                                    </falseStatements>
                                  </conditionStatement>
                                </falseStatements>
                              </conditionStatement>
                            </falseStatements>
                          </conditionStatement>
                        </falseStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="Not">
                            <binaryOperatorExpression operator="BooleanOr">
                              <fieldReferenceExpression name="missingFieldFlag"/>
                              <binaryOperatorExpression operator="ValueEquality">
                                <fieldReferenceExpression name="nextFieldStart"/>
                                <fieldReferenceExpression name="bufferLength"/>
                              </binaryOperatorExpression>
                            </binaryOperatorExpression>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                        </trueStatements>
                      </conditionStatement>
                      <assignStatement>
                        <fieldReferenceExpression name="nextFieldIndex"/>
                        <methodInvokeExpression methodName="Max">
                          <target>
                            <typeReferenceExpression type="Math"/>
                          </target>
                          <parameters>
                            <binaryOperatorExpression operator="Add">
                              <variableReferenceExpression name="index"/>
                              <primitiveExpression value="1"/>
                            </binaryOperatorExpression>
                            <fieldReferenceExpression name="nextFieldIndex"/>
                          </parameters>
                        </methodInvokeExpression>
                      </assignStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <variableReferenceExpression name="index"/>
                            <variableReferenceExpression name="field"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <conditionStatement>
                            <condition>
                              <variableReferenceExpression name="initializing"/>
                            </condition>
                            <trueStatements>
                              <conditionStatement>
                                <condition>
                                  <binaryOperatorExpression operator="BooleanOr">
                                    <fieldReferenceExpression name="eol"/>
                                    <fieldReferenceExpression name="eof"/>
                                  </binaryOperatorExpression>
                                </condition>
                                <trueStatements>
                                  <methodReturnStatement>
                                    <primitiveExpression value="null"/>
                                  </methodReturnStatement>
                                </trueStatements>
                                <falseStatements>
                                  <conditionStatement>
                                    <condition>
                                      <methodInvokeExpression methodName="IsNullOrEmpty">
                                        <target>
                                          <typeReferenceExpression type="System.String"/>
                                        </target>
                                        <parameters>
                                          <variableReferenceExpression name="value"/>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </condition>
                                    <trueStatements>
                                      <methodReturnStatement>
                                        <propertyReferenceExpression name="Empty">
                                          <typeReferenceExpression type="System.String"/>
                                        </propertyReferenceExpression>
                                      </methodReturnStatement>
                                    </trueStatements>
                                    <falseStatements>
                                      <methodReturnStatement>
                                        <variableReferenceExpression name="value"/>
                                      </methodReturnStatement>
                                    </falseStatements>
                                  </conditionStatement>
                                </falseStatements>
                              </conditionStatement>
                            </trueStatements>
                            <falseStatements>
                              <methodReturnStatement>
                                <variableReferenceExpression name="value"/>
                              </methodReturnStatement>
                            </falseStatements>
                          </conditionStatement>
                        </trueStatements>
                      </conditionStatement>
                      <incrementStatement>
                        <variableReferenceExpression name="index"/>
                      </incrementStatement>
                    </statements>
                  </whileStatement>
                  <methodInvokeExpression methodName="HandleParseError">
                    <parameters>
                      <objectCreateExpression type="MalformedCsvException">
                        <parameters>
                          <methodInvokeExpression methodName="GetCurrentRawData"/>
                          <fieldReferenceExpression name="nextFieldStart"/>
                          <methodInvokeExpression methodName="Max">
                            <target>
                              <typeReferenceExpression type="Math"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="0"/>
                              <fieldReferenceExpression name="currentRecordIndex"/>
                            </parameters>
                          </methodInvokeExpression>
                          <variableReferenceExpression name="index"/>
                        </parameters>
                      </objectCreateExpression>
                      <directionExpression direction="Ref">
                        <fieldReferenceExpression name="nextFieldStart"/>
                      </directionExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <primitiveExpression value="null"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- field fields-->
              <memberField type="System.String[]" name="fields"/>
              <!-- field nextFieldStart-->
              <memberField type="System.Int32" name="nextFieldStart"/>
              <!-- field nextFieldIndex-->
              <memberField type="System.Int32" name="nextFieldIndex"/>
              <!-- field eol-->
              <memberField type="System.Boolean" name="eol"/>
              <!-- method ReadNextRecord-->
              <memberMethod returnType="System.Boolean" name="ReadNextRecord">
                <attributes public="true" final="true"/>
                <statements>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="ReadNextRecord">
                      <parameters>
                        <primitiveExpression value="false"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method ReadNextRecord(bool, bool)-->
              <memberMethod returnType="System.Boolean" name="ReadNextRecord">
                <attributes family="true"/>
                <parameters>
                  <parameter type="System.Boolean" name="onlyReadHeaders"/>
                  <parameter type="System.Boolean" name="skipToNextLine"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <fieldReferenceExpression name="eof"/>
                    </condition>
                    <trueStatements>
                      <conditionStatement>
                        <condition>
                          <fieldReferenceExpression name="firstRecordInCache"/>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <fieldReferenceExpression name="firstRecordInCache"/>
                            <primitiveExpression value="false"/>
                          </assignStatement>
                          <incrementStatement>
                            <fieldReferenceExpression name="currentRecordIndex"/>
                          </incrementStatement>
                          <methodReturnStatement>
                            <primitiveExpression value="true"/>
                          </methodReturnStatement>
                        </trueStatements>
                        <falseStatements>
                          <methodReturnStatement>
                            <primitiveExpression value="false"/>
                          </methodReturnStatement>
                        </falseStatements>
                      </conditionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodInvokeExpression methodName="CheckDisposed"/>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="Not">
                        <fieldReferenceExpression name="initialized"/>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <assignStatement>
                        <fieldReferenceExpression name="buffer"/>
                        <arrayCreateExpression>
                          <createType type="System.Char"/>
                          <sizeExpression>
                            <fieldReferenceExpression name="bufferSize"/>
                          </sizeExpression>
                        </arrayCreateExpression>
                      </assignStatement>
                      <assignStatement>
                        <fieldReferenceExpression name="fieldHeaders"/>
                        <arrayCreateExpression>
                          <createType type="System.String"/>
                          <sizeExpression>
                            <primitiveExpression value="0"/>
                          </sizeExpression>
                        </arrayCreateExpression>
                      </assignStatement>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="ReadBuffer"/>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <primitiveExpression value="false"/>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="SkipEmptyAndCommentedLines">
                              <parameters>
                                <directionExpression direction="Ref">
                                  <fieldReferenceExpression name="nextFieldStart"/>
                                </directionExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <primitiveExpression value="false"/>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                      <assignStatement>
                        <fieldReferenceExpression name="fieldCount"/>
                        <primitiveExpression value="0"/>
                      </assignStatement>
                      <assignStatement>
                        <fieldReferenceExpression name="fields"/>
                        <arrayCreateExpression>
                          <createType type="System.String"/>
                          <sizeExpression>
                            <primitiveExpression value="512"/>
                          </sizeExpression>
                        </arrayCreateExpression>
                      </assignStatement>
                      <whileStatement>
                        <test>
                          <binaryOperatorExpression operator="IdentityInequality">
                            <methodInvokeExpression methodName="ReadField">
                              <parameters>
                                <fieldReferenceExpression name="fieldCount"/>
                                <primitiveExpression value="true"/>
                                <primitiveExpression value="false"/>
                              </parameters>
                            </methodInvokeExpression>
                            <primitiveExpression value="null"/>
                          </binaryOperatorExpression>
                        </test>
                        <statements>
                          <conditionStatement>
                            <condition>
                              <fieldReferenceExpression name="parseErrorFlag"/>
                            </condition>
                            <trueStatements>
                              <assignStatement>
                                <fieldReferenceExpression name="fieldCount"/>
                                <primitiveExpression value="0"/>
                              </assignStatement>
                              <methodInvokeExpression methodName="Clear">
                                <target>
                                  <typeReferenceExpression type="System.Array"/>
                                </target>
                                <parameters>
                                  <fieldReferenceExpression name="fields"/>
                                  <primitiveExpression value="0"/>
                                  <propertyReferenceExpression name="Length">
                                    <fieldReferenceExpression name="fields"/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                              <assignStatement>
                                <fieldReferenceExpression name="parseErrorFlag"/>
                                <primitiveExpression value="false"/>
                              </assignStatement>
                              <assignStatement>
                                <fieldReferenceExpression name="nextFieldIndex"/>
                                <primitiveExpression value="0"/>
                              </assignStatement>
                            </trueStatements>
                            <falseStatements>
                              <incrementStatement>
                                <fieldReferenceExpression name="fieldCount"/>
                              </incrementStatement>
                              <conditionStatement>
                                <condition>
                                  <binaryOperatorExpression operator="ValueEquality">
                                    <fieldReferenceExpression name="fieldCount"/>
                                    <propertyReferenceExpression name="Length">
                                      <fieldReferenceExpression name="fields"/>
                                    </propertyReferenceExpression>
                                  </binaryOperatorExpression>
                                </condition>
                                <trueStatements>
                                  <methodInvokeExpression methodName="Resize">
                                    <typeArguments>
                                      <typeReference type="System.String"/>
                                    </typeArguments>
                                    <target>
                                      <typeReferenceExpression type="System.Array"/>
                                    </target>
                                    <parameters>
                                      <directionExpression direction="Ref">
                                        <fieldReferenceExpression name="fields"/>
                                      </directionExpression>
                                      <binaryOperatorExpression operator="Multiply">
                                        <binaryOperatorExpression operator="Add">
                                          <fieldReferenceExpression name="fieldCount"/>
                                          <primitiveExpression value="1"/>
                                        </binaryOperatorExpression>
                                        <primitiveExpression value="2"/>
                                      </binaryOperatorExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </trueStatements>
                              </conditionStatement>
                            </falseStatements>
                          </conditionStatement>
                        </statements>
                      </whileStatement>
                      <incrementStatement>
                        <fieldReferenceExpression name="fieldCount"/>
                      </incrementStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueInequality">
                            <propertyReferenceExpression name="Length">
                              <fieldReferenceExpression name="fields"/>
                            </propertyReferenceExpression>
                            <fieldReferenceExpression name="fieldCount"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodInvokeExpression methodName="Resize">
                            <typeArguments>
                              <typeReference type="System.String"/>
                            </typeArguments>
                            <target>
                              <typeReferenceExpression type="System.Array"/>
                            </target>
                            <parameters>
                              <directionExpression direction="Ref">
                                <fieldReferenceExpression name="fields"/>
                              </directionExpression>
                              <fieldReferenceExpression name="fieldCount"/>
                            </parameters>
                          </methodInvokeExpression>
                        </trueStatements>
                      </conditionStatement>
                      <assignStatement>
                        <fieldReferenceExpression name="initialized"/>
                        <primitiveExpression value="true"/>
                      </assignStatement>
                      <conditionStatement>
                        <condition>
                          <fieldReferenceExpression name="hasHeaders"/>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <fieldReferenceExpression name="currentRecordIndex"/>
                            <primitiveExpression value="-1"/>
                          </assignStatement>
                          <assignStatement>
                            <fieldReferenceExpression name="firstRecordInCache"/>
                            <primitiveExpression value="false"/>
                          </assignStatement>
                          <assignStatement>
                            <fieldReferenceExpression name="fieldHeaders"/>
                            <arrayCreateExpression>
                              <createType type="System.String"/>
                              <sizeExpression>
                                <fieldReferenceExpression name="fieldCount"/>
                              </sizeExpression>
                            </arrayCreateExpression>
                          </assignStatement>
                          <assignStatement>
                            <fieldReferenceExpression name="fieldHeaderIndexes"/>
                            <objectCreateExpression type="Dictionary">
                              <typeArguments>
                                <typeReference type="System.String"/>
                                <typeReference type="System.Int32"/>
                              </typeArguments>
                              <parameters>
                                <fieldReferenceExpression name="fieldCount"/>
                                <fieldReferenceExpression name="fieldHeaderComparer"/>
                              </parameters>
                            </objectCreateExpression>
                          </assignStatement>
                          <forStatement>
                            <variable type="System.Int32" name="i">
                              <init>
                                <primitiveExpression value="0"/>
                              </init>
                            </variable>
                            <test>
                              <binaryOperatorExpression operator="LessThan">
                                <variableReferenceExpression name="i"/>
                                <propertyReferenceExpression name="Length">
                                  <fieldReferenceExpression name="fields"/>
                                </propertyReferenceExpression>
                              </binaryOperatorExpression>
                            </test>
                            <increment>
                              <variableReferenceExpression name="i"/>
                            </increment>
                            <statements>
                              <variableDeclarationStatement type="System.String" name="headerName">
                                <init>
                                  <arrayIndexerExpression>
                                    <target>
                                      <fieldReferenceExpression name="fields"/>
                                    </target>
                                    <indices>
                                      <variableReferenceExpression name="i"/>
                                    </indices>
                                  </arrayIndexerExpression>
                                </init>
                              </variableDeclarationStatement>
                              <conditionStatement>
                                <condition>
                                  <binaryOperatorExpression operator="BooleanOr">
                                    <unaryOperatorExpression operator="IsNullOrEmpty">
                                      <variableReferenceExpression name="headerName"/>
                                    </unaryOperatorExpression>
                                    <binaryOperatorExpression operator="ValueEquality">
                                      <propertyReferenceExpression name="Length">
                                        <methodInvokeExpression methodName="Trim">
                                          <target>
                                            <variableReferenceExpression name="headerName"/>
                                          </target>
                                        </methodInvokeExpression>
                                      </propertyReferenceExpression>
                                      <primitiveExpression value="0"/>
                                    </binaryOperatorExpression>
                                  </binaryOperatorExpression>
                                </condition>
                                <trueStatements>
                                  <assignStatement>
                                    <variableReferenceExpression name="headerName"/>
                                    <binaryOperatorExpression operator="Add">
                                      <propertyReferenceExpression name="DefaultHeaderName">
                                        <thisReferenceExpression/>
                                      </propertyReferenceExpression>
                                      <methodInvokeExpression methodName="ToString">
                                        <target>
                                          <variableReferenceExpression name="i"/>
                                        </target>
                                      </methodInvokeExpression>
                                    </binaryOperatorExpression>
                                  </assignStatement>
                                </trueStatements>
                              </conditionStatement>
                              <assignStatement>
                                <arrayIndexerExpression>
                                  <target>
                                    <fieldReferenceExpression name="fieldHeaders"/>
                                  </target>
                                  <indices>
                                    <variableReferenceExpression name="i"/>
                                  </indices>
                                </arrayIndexerExpression>
                                <variableReferenceExpression name="headerName"/>
                              </assignStatement>
                              <methodInvokeExpression methodName="Add">
                                <target>
                                  <fieldReferenceExpression name="fieldHeaderIndexes"/>
                                </target>
                                <parameters>
                                  <variableReferenceExpression name="headerName"/>
                                  <variableReferenceExpression name="i"/>
                                </parameters>
                              </methodInvokeExpression>
                            </statements>
                          </forStatement>
                          <conditionStatement>
                            <condition>
                              <unaryOperatorExpression operator="Not">
                                <argumentReferenceExpression name="onlyReadHeaders"/>
                              </unaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <conditionStatement>
                                <condition>
                                  <unaryOperatorExpression operator="Not">
                                    <methodInvokeExpression methodName="SkipEmptyAndCommentedLines">
                                      <parameters>
                                        <directionExpression direction="Ref">
                                          <fieldReferenceExpression name="nextFieldStart"/>
                                        </directionExpression>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </unaryOperatorExpression>
                                </condition>
                                <trueStatements>
                                  <methodReturnStatement>
                                    <primitiveExpression value="false"/>
                                  </methodReturnStatement>
                                </trueStatements>
                              </conditionStatement>
                              <methodInvokeExpression methodName="Clear">
                                <target>
                                  <typeReferenceExpression type="Array"/>
                                </target>
                                <parameters>
                                  <fieldReferenceExpression name="fields"/>
                                  <primitiveExpression value="0"/>
                                  <propertyReferenceExpression name="Length">
                                    <fieldReferenceExpression name="fields"/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                              <assignStatement>
                                <fieldReferenceExpression name="nextFieldIndex"/>
                                <primitiveExpression value="0"/>
                              </assignStatement>
                              <assignStatement>
                                <fieldReferenceExpression name="eol"/>
                                <primitiveExpression value="false"/>
                              </assignStatement>
                              <incrementStatement>
                                <fieldReferenceExpression name="currentRecordIndex"/>
                              </incrementStatement>
                              <methodReturnStatement>
                                <primitiveExpression value="true"/>
                              </methodReturnStatement>
                            </trueStatements>
                          </conditionStatement>
                        </trueStatements>
                        <falseStatements>
                          <conditionStatement>
                            <condition>
                              <argumentReferenceExpression name="onlyReadHeaders"/>
                            </condition>
                            <trueStatements>
                              <assignStatement>
                                <fieldReferenceExpression name="firstRecordInCache"/>
                                <primitiveExpression value="true"/>
                              </assignStatement>
                              <assignStatement>
                                <fieldReferenceExpression name="currentRecordIndex"/>
                                <primitiveExpression value="-1"/>
                              </assignStatement>
                            </trueStatements>
                            <falseStatements>
                              <assignStatement>
                                <fieldReferenceExpression name="firstRecordInCache"/>
                                <primitiveExpression value="false"/>
                              </assignStatement>
                              <assignStatement>
                                <fieldReferenceExpression name="currentRecordIndex"/>
                                <primitiveExpression value="0"/>
                              </assignStatement>
                            </falseStatements>
                          </conditionStatement>
                        </falseStatements>
                      </conditionStatement>
                    </trueStatements>
                    <falseStatements>
                      <conditionStatement>
                        <condition>
                          <argumentReferenceExpression name="skipToNextLine"/>
                        </condition>
                        <trueStatements>
                          <methodInvokeExpression methodName="SkipToNextLine">
                            <target>
                              <thisReferenceExpression/>
                            </target>
                            <parameters>
                              <directionExpression direction="Ref">
                                <fieldReferenceExpression name="nextFieldStart"/>
                              </directionExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </trueStatements>
                        <falseStatements>
                          <conditionStatement>
                            <condition>
                              <binaryOperatorExpression operator="BooleanAnd">
                                <binaryOperatorExpression operator="GreaterThan">
                                  <fieldReferenceExpression name="currentRecordIndex"/>
                                  <primitiveExpression value="-1"/>
                                </binaryOperatorExpression>
                                <unaryOperatorExpression operator="Not">
                                  <fieldReferenceExpression name="missingFieldFlag"/>
                                </unaryOperatorExpression>
                              </binaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <conditionStatement>
                                <condition>
                                  <binaryOperatorExpression operator="BooleanAnd">
                                    <unaryOperatorExpression operator="Not">
                                      <fieldReferenceExpression name="eol"/>
                                    </unaryOperatorExpression>
                                    <unaryOperatorExpression operator="Not">
                                      <fieldReferenceExpression name="eof"/>
                                    </unaryOperatorExpression>
                                  </binaryOperatorExpression>
                                </condition>
                                <trueStatements>
                                  <conditionStatement>
                                    <condition>
                                      <unaryOperatorExpression operator="Not">
                                        <fieldReferenceExpression name="supportsMultiline"/>
                                      </unaryOperatorExpression>
                                    </condition>
                                    <trueStatements>
                                      <methodInvokeExpression methodName="SkipToNextLine">
                                        <target>
                                          <thisReferenceExpression/>
                                        </target>
                                        <parameters>
                                          <directionExpression direction="Ref">
                                            <fieldReferenceExpression name="nextFieldStart"/>
                                          </directionExpression>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </trueStatements>
                                    <falseStatements>
                                      <whileStatement>
                                        <test>
                                          <binaryOperatorExpression operator="IdentityInequality">
                                            <methodInvokeExpression methodName="ReadField">
                                              <parameters>
                                                <fieldReferenceExpression name="nextFieldIndex"/>
                                                <primitiveExpression value="true"/>
                                                <primitiveExpression value="true"/>
                                              </parameters>
                                            </methodInvokeExpression>
                                            <primitiveExpression value="null"/>
                                          </binaryOperatorExpression>
                                        </test>
                                      </whileStatement>
                                    </falseStatements>
                                  </conditionStatement>
                                </trueStatements>
                              </conditionStatement>
                            </trueStatements>
                          </conditionStatement>
                        </falseStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="BooleanAnd">
                            <unaryOperatorExpression operator="Not">
                              <fieldReferenceExpression name="firstRecordInCache"/>
                            </unaryOperatorExpression>
                            <unaryOperatorExpression operator="Not">
                              <methodInvokeExpression methodName="SkipEmptyAndCommentedLines">
                                <parameters>
                                  <directionExpression direction="Ref">
                                    <fieldReferenceExpression name="nextFieldStart"/>
                                  </directionExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </unaryOperatorExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <primitiveExpression value="false"/>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="BooleanOr">
                            <fieldReferenceExpression name="hasHeaders"/>
                            <unaryOperatorExpression operator="Not">
                              <fieldReferenceExpression name="firstRecordInCache"/>
                            </unaryOperatorExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <fieldReferenceExpression name="eol"/>
                            <primitiveExpression value="false"/>
                          </assignStatement>
                        </trueStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <fieldReferenceExpression name="firstRecordInCache"/>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <fieldReferenceExpression name="firstRecordInCache"/>
                            <primitiveExpression value="false"/>
                          </assignStatement>
                        </trueStatements>
                        <falseStatements>
                          <methodInvokeExpression methodName="Clear">
                            <target>
                              <typeReferenceExpression type="Array"/>
                            </target>
                            <parameters>
                              <fieldReferenceExpression name="fields"/>
                              <primitiveExpression value="0"/>
                              <propertyReferenceExpression name="Length">
                                <fieldReferenceExpression name="fields"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                          <assignStatement>
                            <fieldReferenceExpression name="nextFieldIndex"/>
                            <primitiveExpression value="0"/>
                          </assignStatement>
                        </falseStatements>
                      </conditionStatement>
                      <assignStatement>
                        <fieldReferenceExpression name="missingFieldFlag"/>
                        <primitiveExpression value="false"/>
                      </assignStatement>
                      <assignStatement>
                        <fieldReferenceExpression name="parseErrorFlag"/>
                        <primitiveExpression value="false"/>
                      </assignStatement>
                      <incrementStatement>
                        <fieldReferenceExpression name="currentRecordIndex"/>
                      </incrementStatement>
                    </falseStatements>
                  </conditionStatement>
                  <methodReturnStatement>
                    <primitiveExpression value="true"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- field firstRecordInCache-->
              <memberField type="System.Boolean" name="firstRecordInCache"/>
              <!-- method SkipEmptyAndCommentedLines(ref int)-->
              <memberMethod returnType="System.Boolean" name="SkipEmptyAndCommentedLines">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter direction="Ref" type="System.Int32" name="pos"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="LessThan">
                        <argumentReferenceExpression name="pos"/>
                        <fieldReferenceExpression name="bufferLength"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="DoSkipEmptyAndCommentedLines">
                        <parameters>
                          <directionExpression direction="Ref">
                            <argumentReferenceExpression name="pos"/>
                          </directionExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                  <whileStatement>
                    <test>
                      <binaryOperatorExpression operator="BooleanAnd">
                        <binaryOperatorExpression operator="GreaterThanOrEqual">
                          <argumentReferenceExpression name="pos"/>
                          <fieldReferenceExpression name="bufferLength"/>
                        </binaryOperatorExpression>
                        <unaryOperatorExpression operator="Not">
                          <fieldReferenceExpression name="eof"/>
                        </unaryOperatorExpression>
                      </binaryOperatorExpression>
                    </test>
                    <statements>
                      <conditionStatement>
                        <condition>
                          <methodInvokeExpression methodName="ReadBuffer"/>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <argumentReferenceExpression name="pos"/>
                            <primitiveExpression value="0"/>
                          </assignStatement>
                          <methodInvokeExpression methodName="DoSkipEmptyAndCommentedLines">
                            <parameters>
                              <directionExpression direction="Ref">
                                <argumentReferenceExpression name="pos"/>
                              </directionExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </trueStatements>
                        <falseStatements>
                          <methodReturnStatement>
                            <primitiveExpression value="false"/>
                          </methodReturnStatement>
                        </falseStatements>
                      </conditionStatement>
                    </statements>
                  </whileStatement>
                  <methodReturnStatement>
                    <unaryOperatorExpression operator="Not">
                      <fieldReferenceExpression name="eof"/>
                    </unaryOperatorExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method DoSkipEmptyAndCommentedLines(ref int)-->
              <memberMethod name="DoSkipEmptyAndCommentedLines">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter direction="Ref" type="System.Int32" name="pos"/>
                </parameters>
                <statements>
                  <whileStatement>
                    <test>
                      <binaryOperatorExpression operator="LessThan">
                        <argumentReferenceExpression name="pos"/>
                        <fieldReferenceExpression name="bufferLength"/>
                      </binaryOperatorExpression>
                    </test>
                    <statements>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <arrayIndexerExpression>
                              <target>
                                <fieldReferenceExpression name="buffer"/>
                              </target>
                              <indices>
                                <argumentReferenceExpression name="pos"/>
                              </indices>
                            </arrayIndexerExpression>
                            <fieldReferenceExpression name="comment"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <argumentReferenceExpression name="pos"/>
                            <binaryOperatorExpression operator="Add">
                              <argumentReferenceExpression name="pos"/>
                              <primitiveExpression value="1"/>
                            </binaryOperatorExpression>
                          </assignStatement>
                          <methodInvokeExpression methodName="SkipToNextLine">
                            <parameters>
                              <directionExpression direction="Ref">
                                <argumentReferenceExpression name="pos"/>
                              </directionExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </trueStatements>
                        <falseStatements>
                          <conditionStatement>
                            <condition>
                              <unaryOperatorExpression operator="Not">
                                <binaryOperatorExpression operator="BooleanAnd">
                                  <fieldReferenceExpression name="skipEmptyLines"/>
                                  <methodInvokeExpression methodName="ParseNewLine">
                                    <parameters>
                                      <directionExpression direction="Ref">
                                        <argumentReferenceExpression name="pos"/>
                                      </directionExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </binaryOperatorExpression>
                              </unaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <breakStatement/>
                            </trueStatements>
                          </conditionStatement>
                        </falseStatements>
                      </conditionStatement>
                    </statements>
                  </whileStatement>
                </statements>
              </memberMethod>
              <!-- method SkipWhiteSpaces(int)-->
              <memberMethod returnType="System.Boolean" name="SkipWhiteSpaces">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="pos" direction="Ref"/>
                </parameters>
                <statements>
                  <whileStatement>
                    <test>
                      <primitiveExpression value="true"/>
                    </test>
                    <statements>
                      <comment>skip spaces</comment>
                      <whileStatement>
                        <test>
                          <binaryOperatorExpression operator="BooleanAnd">
                            <binaryOperatorExpression operator="LessThan">
                              <argumentReferenceExpression name="pos"/>
                              <fieldReferenceExpression name="bufferLength"/>
                            </binaryOperatorExpression>
                            <methodInvokeExpression methodName="IsWhiteSpace">
                              <parameters>
                                <arrayIndexerExpression>
                                  <target>
                                    <fieldReferenceExpression name="buffer"/>
                                  </target>
                                  <indices>
                                    <argumentReferenceExpression name="pos"/>
                                  </indices>
                                </arrayIndexerExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </binaryOperatorExpression>
                        </test>
                        <statements>
                          <incrementStatement>
                            <argumentReferenceExpression name="pos"/>
                          </incrementStatement>
                        </statements>
                      </whileStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="LessThan">
                            <argumentReferenceExpression name="pos"/>
                            <fieldReferenceExpression name="bufferLength"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <breakStatement/>
                        </trueStatements>
                        <falseStatements>
                          <assignStatement>
                            <argumentReferenceExpression name="pos"/>
                            <primitiveExpression value="0"/>
                          </assignStatement>
                          <conditionStatement>
                            <condition>
                              <unaryOperatorExpression operator="Not">
                                <methodInvokeExpression methodName="ReadBuffer"/>
                              </unaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <methodReturnStatement>
                                <primitiveExpression value="false"/>
                              </methodReturnStatement>
                            </trueStatements>
                          </conditionStatement>
                        </falseStatements>
                      </conditionStatement>
                    </statements>
                  </whileStatement>
                  <methodReturnStatement>
                    <primitiveExpression value="true"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method SkipToNextLine(int)-->
              <memberMethod returnType="System.Boolean" name="SkipToNextLine">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter direction="Ref" type="System.Int32" name="pos"/>
                </parameters>
                <statements>
                  <comment>It should be ((pos = 0) == 0), double-check to ensure it works</comment>
                  <assignStatement>
                    <argumentReferenceExpression name="pos"/>
                    <primitiveExpression value="0"/>
                  </assignStatement>
                  <whileStatement>
                    <test>
                      <binaryOperatorExpression operator="BooleanAnd">
                        <binaryOperatorExpression operator="BooleanOr">
                          <binaryOperatorExpression operator="LessThan">
                            <argumentReferenceExpression name="pos"/>
                            <fieldReferenceExpression name="bufferLength"/>
                          </binaryOperatorExpression>
                          <methodInvokeExpression methodName="ReadBuffer"/>
                        </binaryOperatorExpression>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="ParseNewLine">
                            <parameters>
                              <directionExpression direction="Ref">
                                <argumentReferenceExpression name="pos"/>
                              </directionExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </binaryOperatorExpression>
                    </test>
                    <statements>
                      <assignStatement>
                        <argumentReferenceExpression name="pos"/>
                        <primitiveExpression value="0"/>
                      </assignStatement>
                      <incrementStatement>
                        <argumentReferenceExpression name="pos"/>
                      </incrementStatement>
                    </statements>
                  </whileStatement>
                  <methodReturnStatement>
                    <unaryOperatorExpression operator="Not">
                      <fieldReferenceExpression name="eof"/>
                    </unaryOperatorExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method HandleParseError(MalformedCsvException, ref int)-->
              <memberMethod name="HandleParseError">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter type="MalformedCsvException" name="error"/>
                  <parameter direction="Ref" type="System.Int32" name="pos"/>
                </parameters>
                <statements>
                  <comment>check this one as well, uses switches</comment>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <argumentReferenceExpression name="error"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentNullException">
                          <parameters>
                            <primitiveExpression value="error"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="parseErrorFlag"/>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueEquality">
                        <fieldReferenceExpression name="defaultParseErrorAction"/>
                        <propertyReferenceExpression name="ThrowException">
                          <typeReferenceExpression type="ParseErrorAction"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <argumentReferenceExpression name="error"/>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueEquality">
                        <fieldReferenceExpression name="defaultParseErrorAction"/>
                        <propertyReferenceExpression name="RaiseEvent">
                          <typeReferenceExpression type="ParseErrorAction"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <variableDeclarationStatement type="ParseErrorEventArgs" name="e">
                        <init>
                          <objectCreateExpression type="ParseErrorEventArgs">
                            <parameters>
                              <argumentReferenceExpression name="error"/>
                              <propertyReferenceExpression name="ThrowException">
                                <typeReferenceExpression type="ParseErrorAction"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </objectCreateExpression>
                        </init>
                      </variableDeclarationStatement>
                      <methodInvokeExpression methodName="OnParseError">
                        <parameters>
                          <variableReferenceExpression name="e"/>
                        </parameters>
                      </methodInvokeExpression>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <propertyReferenceExpression name="Action">
                              <variableReferenceExpression name="e"/>
                            </propertyReferenceExpression>
                            <propertyReferenceExpression name="ThrowException">
                              <typeReferenceExpression type="ParseErrorAction"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <throwExceptionStatement>
                            <propertyReferenceExpression name="Error">
                              <variableReferenceExpression name="e"/>
                            </propertyReferenceExpression>
                          </throwExceptionStatement>
                        </trueStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <propertyReferenceExpression name="Action">
                              <variableReferenceExpression name="e"/>
                            </propertyReferenceExpression>
                            <propertyReferenceExpression name="RaiseEvent">
                              <typeReferenceExpression type="ParseErrorAction"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <throwExceptionStatement>
                            <objectCreateExpression type="InvalidOperationException">
                              <parameters>
                                <methodInvokeExpression methodName="Format">
                                  <target>
                                    <typeReferenceExpression type="System.String"/>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="InvariantCulture">
                                      <typeReferenceExpression type="CultureInfo"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="ParseErrorActionInvalidInsideParseErrorEvent">
                                      <typeReferenceExpression type="ExceptionMessage"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="Action">
                                      <variableReferenceExpression name="e"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>
                                <propertyReferenceExpression name="Error">
                                  <variableReferenceExpression name="e"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </throwExceptionStatement>
                        </trueStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <propertyReferenceExpression name="Action">
                              <variableReferenceExpression name="e"/>
                            </propertyReferenceExpression>
                            <propertyReferenceExpression name="AdvanceToNextLine">
                              <typeReferenceExpression type="ParseErrorAction"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <conditionStatement>
                            <condition>
                              <binaryOperatorExpression operator="BooleanAnd">
                                <unaryOperatorExpression operator="Not">
                                  <fieldReferenceExpression name="missingFieldFlag"/>
                                </unaryOperatorExpression>
                                <binaryOperatorExpression operator="GreaterThanOrEqual">
                                  <argumentReferenceExpression name="pos"/>
                                  <primitiveExpression value="0"/>
                                </binaryOperatorExpression>
                              </binaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <methodInvokeExpression methodName="SkipToNextLine">
                                <parameters>
                                  <directionExpression direction="Ref">
                                    <argumentReferenceExpression name="pos"/>
                                  </directionExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </trueStatements>
                          </conditionStatement>
                        </trueStatements>
                        <falseStatements>
                          <throwExceptionStatement>
                            <objectCreateExpression type="NotSupportedException">
                              <parameters>
                                <methodInvokeExpression methodName="Format">
                                  <target>
                                    <typeReferenceExpression type="System.String"/>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="InvariantCulture">
                                      <typeReferenceExpression type="CultureInfo"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="ParseErrorActionNotSupported">
                                      <typeReferenceExpression type="ExceptionMessage"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="Action">
                                      <variableReferenceExpression name="e"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>
                                <propertyReferenceExpression name="Error">
                                  <variableReferenceExpression name="e"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </throwExceptionStatement>
                        </falseStatements>
                      </conditionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueEquality">
                        <fieldReferenceExpression name="defaultParseErrorAction"/>
                        <propertyReferenceExpression name="AdvanceToNextLine">
                          <typeReferenceExpression type="ParseErrorAction"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="BooleanAnd">
                            <unaryOperatorExpression operator="Not">
                              <fieldReferenceExpression name="missingFieldFlag"/>
                            </unaryOperatorExpression>
                            <binaryOperatorExpression operator="GreaterThanOrEqual">
                              <argumentReferenceExpression name="pos"/>
                              <primitiveExpression value="0"/>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodInvokeExpression methodName="SkipToNextLine">
                            <parameters>
                              <directionExpression direction="Ref">
                                <argumentReferenceExpression name="pos"/>
                              </directionExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </trueStatements>
                      </conditionStatement>
                    </trueStatements>
                    <falseStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="NotSupportedException">
                          <parameters>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="System.String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="ParseErrorActionNotSupported">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <fieldReferenceExpression name="defaultParseErrorAction"/>
                              </parameters>
                            </methodInvokeExpression>
                            <argumentReferenceExpression name="error"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method HandleMissingField(string, int, ref int)-->
              <memberMethod returnType="System.String" name="HandleMissingField">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter type="System.String" name="value"/>
                  <parameter type="System.Int32" name="fieldIndex"/>
                  <parameter type="System.Int32" name="currentPosition" direction="Ref"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanOr">
                        <binaryOperatorExpression operator="LessThan">
                          <argumentReferenceExpression name="fieldIndex"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="GreaterThanOrEqual">
                          <argumentReferenceExpression name="fieldIndex"/>
                          <fieldReferenceExpression name="fieldCount"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentOutOfRangeException">
                          <parameters>
                            <primitiveExpression value="fieldIndex"/>
                            <argumentReferenceExpression name="fieldIndex"/>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="System.String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="FieldIndexOutOfRange">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="fieldIndex"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="missingFieldFlag"/>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <forStatement>
                    <variable type="System.Int32" name="i">
                      <init>
                        <binaryOperatorExpression operator="Add">
                          <argumentReferenceExpression name="fieldIndex"/>
                          <primitiveExpression value="1"/>
                        </binaryOperatorExpression>
                      </init>
                    </variable>
                    <test>
                      <binaryOperatorExpression operator="LessThan">
                        <variableReferenceExpression name="i"/>
                        <fieldReferenceExpression name="fieldCount"/>
                      </binaryOperatorExpression>
                    </test>
                    <increment>
                      <variableReferenceExpression name="i"/>
                    </increment>
                    <statements>
                      <assignStatement>
                        <arrayIndexerExpression>
                          <target>
                            <fieldReferenceExpression name="fields"/>
                          </target>
                          <indices>
                            <variableReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="null"/>
                      </assignStatement>
                    </statements>
                  </forStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityInequality">
                        <argumentReferenceExpression name="value"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <argumentReferenceExpression name="value"/>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <fieldReferenceExpression name="missingFieldAction"/>
                            <propertyReferenceExpression name="ParseError">
                              <typeReferenceExpression type="MissingFieldAction"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodInvokeExpression methodName="HandleParseError">
                            <parameters>
                              <objectCreateExpression type="MissingFieldCsvException">
                                <parameters>
                                  <methodInvokeExpression methodName="GetCurrentRawData"/>
                                  <argumentReferenceExpression name="currentPosition"/>
                                  <methodInvokeExpression methodName="Max">
                                    <target>
                                      <typeReferenceExpression type="Math"/>
                                    </target>
                                    <parameters>
                                      <primitiveExpression value="0"/>
                                      <fieldReferenceExpression name="currentRecordIndex"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                  <argumentReferenceExpression name="fieldIndex"/>
                                </parameters>
                              </objectCreateExpression>
                              <directionExpression direction="Ref">
                                <argumentReferenceExpression name="currentPosition"/>
                              </directionExpression>
                            </parameters>
                          </methodInvokeExpression>
                          <methodReturnStatement>
                            <argumentReferenceExpression name="value"/>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <fieldReferenceExpression name="missingFieldAction"/>
                            <propertyReferenceExpression name="ReplaceByEmpty">
                              <typeReferenceExpression type="MissingFieldAction"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <propertyReferenceExpression name="Empty">
                              <typeReferenceExpression type="System.String"/>
                            </propertyReferenceExpression>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <fieldReferenceExpression name="missingFieldAction"/>
                            <propertyReferenceExpression name="ReplaceByNull">
                              <typeReferenceExpression type="MissingFieldAction"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <primitiveExpression value="null"/>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                      <throwExceptionStatement>
                        <objectCreateExpression type="NotSupportedException">
                          <parameters>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="System.String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="MissingFieldActionNotSupported">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <fieldReferenceExpression name="missingFieldAction"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method ValidateDataReader(DataReaderValidations)-->
              <memberMethod name="ValidateDataReader">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter type="DataReaderValidations" name="validations"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanAnd">
                        <binaryOperatorExpression operator="ValueInequality">
                          <binaryOperatorExpression operator="BitwiseAnd">
                            <argumentReferenceExpression name="validations"/>
                            <propertyReferenceExpression name="IsInitialized">
                              <typeReferenceExpression type="DataReaderValidations"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                        <unaryOperatorExpression operator="Not">
                          <fieldReferenceExpression name="initialized"/>
                        </unaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="InvalidOperationException">
                          <parameters>
                            <propertyReferenceExpression name="NoCurrentRecord">
                              <typeReferenceExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanAnd">
                        <binaryOperatorExpression operator="ValueInequality">
                          <binaryOperatorExpression operator="BitwiseAnd">
                            <argumentReferenceExpression name="validations"/>
                            <propertyReferenceExpression name="IsNotClosed">
                              <typeReferenceExpression type="DataReaderValidations"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                        <fieldReferenceExpression name="isDisposed"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="InvalidOperationException">
                          <parameters>
                            <propertyReferenceExpression name="ReaderClosed">
                              <typeReferenceExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method CopyFieldToArray(int, long, Array, int, int)-->
              <memberMethod returnType="System.Int64" name="CopyFieldToArray">
                <attributes private="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="field"/>
                  <parameter type="System.Int64" name="fieldOffset"/>
                  <parameter type="Array" name="destinationArray"/>
                  <parameter type="System.Int32" name="destinationOffset"/>
                  <parameter type="System.Int32" name="length"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="EnsureInitialize"/>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanOr">
                        <binaryOperatorExpression operator="LessThan">
                          <argumentReferenceExpression name="field"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="GreaterThanOrEqual">
                          <argumentReferenceExpression name="field"/>
                          <fieldReferenceExpression name="fieldCount"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentOutOfRangeException">
                          <parameters>
                            <primitiveExpression value="field"/>
                            <argumentReferenceExpression name="field"/>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="System.String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="FieldIndexOutOfRange">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="field"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanOr">
                        <binaryOperatorExpression operator="LessThan">
                          <argumentReferenceExpression name="fieldOffset"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="GreaterThanOrEqual">
                          <argumentReferenceExpression name="fieldOffset"/>
                          <propertyReferenceExpression name="MaxValue">
                            <typeReferenceExpression type="System.Int32"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentOutOfRangeException">
                          <parameters>
                            <primitiveExpression value="fieldOffset"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueEquality">
                        <argumentReferenceExpression name="length"/>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <primitiveExpression value="0"/>
                      </methodReturnStatement>
                    </trueStatements>
                  </conditionStatement>
                  <variableDeclarationStatement type="System.String" name="value">
                    <init>
                      <arrayIndexerExpression>
                        <target>
                          <thisReferenceExpression/>
                        </target>
                        <indices>
                          <argumentReferenceExpression name="field"/>
                        </indices>
                      </arrayIndexerExpression>
                    </init>
                  </variableDeclarationStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <variableReferenceExpression name="value"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <assignStatement>
                        <variableReferenceExpression name="value"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="System.String"/>
                        </propertyReferenceExpression>
                      </assignStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <methodInvokeExpression methodName="GetType">
                          <target>
                            <argumentReferenceExpression name="destinationArray"/>
                          </target>
                        </methodInvokeExpression>
                        <typeofExpression type="System.Char[]"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="Copy">
                        <target>
                          <typeReferenceExpression type="Array"/>
                        </target>
                        <parameters>
                          <methodInvokeExpression methodName="ToCharArray">
                            <target>
                              <argumentReferenceExpression name="value"/>
                            </target>
                            <parameters>
                              <castExpression targetType="System.Int32">
                                <argumentReferenceExpression name="fieldOffset"/>
                              </castExpression>
                              <argumentReferenceExpression name="length"/>
                            </parameters>
                          </methodInvokeExpression>
                          <primitiveExpression value="0"/>
                          <argumentReferenceExpression name="destinationArray"/>
                          <argumentReferenceExpression name="destinationOffset"/>
                          <argumentReferenceExpression name="length"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                    <falseStatements>
                      <variableDeclarationStatement type="System.Char[]" name="chars">
                        <init>
                          <methodInvokeExpression methodName="ToCharArray">
                            <target>
                              <variableReferenceExpression name="value"/>
                            </target>
                            <parameters>
                              <castExpression targetType="System.Int32">
                                <argumentReferenceExpression name="fieldOffset"/>
                              </castExpression>
                              <argumentReferenceExpression name="length"/>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variableDeclarationStatement>
                      <variableDeclarationStatement type="System.Byte[]" name="source">
                        <init>
                          <arrayCreateExpression>
                            <createType type="System.Byte"/>
                            <sizeExpression>
                              <propertyReferenceExpression name="Length">
                                <variableReferenceExpression name="chars"/>
                              </propertyReferenceExpression>
                            </sizeExpression>
                          </arrayCreateExpression>
                        </init>
                      </variableDeclarationStatement>
                      <forStatement>
                        <variable type="System.Int32" name="i">
                          <init>
                            <primitiveExpression value="0"/>
                          </init>
                        </variable>
                        <test>
                          <binaryOperatorExpression operator="LessThan">
                            <variableReferenceExpression name="i"/>
                            <propertyReferenceExpression name="Length">
                              <variableReferenceExpression name="chars"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                        </test>
                        <increment>
                          <variableReferenceExpression name="i"/>
                        </increment>
                        <statements>
                          <assignStatement>
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="source"/>
                              </target>
                              <indices>
                                <variableReferenceExpression name="i"/>
                              </indices>
                            </arrayIndexerExpression>
                            <convertExpression to="Byte">
                              <arrayIndexerExpression>
                                <target>
                                  <variableReferenceExpression name="chars"/>
                                </target>
                                <indices>
                                  <variableReferenceExpression name="i"/>
                                </indices>
                              </arrayIndexerExpression>
                            </convertExpression>
                          </assignStatement>
                        </statements>
                      </forStatement>
                      <methodInvokeExpression methodName="Copy">
                        <target>
                          <typeReferenceExpression type="Array"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="source"/>
                          <primitiveExpression value="0"/>
                          <argumentReferenceExpression name="destinationArray"/>
                          <argumentReferenceExpression name="destinationOffset"/>
                          <argumentReferenceExpression name="length"/>
                        </parameters>
                      </methodInvokeExpression>
                    </falseStatements>
                  </conditionStatement>
                  <methodReturnStatement>
                    <argumentReferenceExpression name="length"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- property IDataReader.RecordsAffected-->
              <memberProperty type="System.Int32" name="RecordsAffected" privateImplementationType="IDataReader">
                <attributes/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="-1"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property IDataReader.IsClosed-->
              <memberProperty type="System.Boolean" name="IsClosed" privateImplementationType="IDataReader">
                <attributes />
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="eof"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- method IDataReader.NextResult-->
              <memberMethod returnType="System.Boolean" name="NextResult" privateImplementationType="IDataReader">
                <attributes final="true"/>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <propertyReferenceExpression name="IsNotClosed">
                        <typeReferenceExpression type="DataReaderValidations"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <primitiveExpression value="false"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataReader.Close-->
              <memberMethod name="Close" privateImplementationType="IDataReader">
                <attributes final="true"/>
                <statements>
                  <methodInvokeExpression methodName="Dispose">
                    <target>
                      <castExpression targetType="IDataReader">
                        <thisReferenceExpression/>
                      </castExpression>
                    </target>
                  </methodInvokeExpression>
                </statements>
              </memberMethod>
              <!-- method IDataReader.Read-->
              <memberMethod returnType="System.Boolean" name="Read" privateImplementationType="IDataReader">
                <attributes final="true"/>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <propertyReferenceExpression name="IsNotClosed">
                        <typeReferenceExpression type="DataReaderValidations"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="ReadNextRecord"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- property IDataReader.Depth-->
              <memberProperty type="System.Int32" name="Depth" privateImplementationType="IDataReader">
                <attributes />
                <getStatements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <propertyReferenceExpression name="IsNotClosed">
                        <typeReferenceExpression type="DataReaderValidations"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <primitiveExpression value="0"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- method IDataReader.GetSchemaTable-->
              <memberMethod returnType="DataTable" name="GetSchemaTable" privateImplementationType="IDataReader">
                <attributes final="true"/>
                <statements>
                  <methodInvokeExpression methodName="EnsureInitialize"/>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <propertyReferenceExpression name="IsNotClosed">
                        <typeReferenceExpression type="DataReaderValidations"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <variableDeclarationStatement type="DataTable" name="schema">
                    <init>
                      <objectCreateExpression type="DataTable">
                        <parameters>
                          <primitiveExpression value="SchemaTable"/>
                        </parameters>
                      </objectCreateExpression>
                    </init>
                  </variableDeclarationStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="Locale">
                      <variableReferenceExpression name="schema"/>
                    </propertyReferenceExpression>
                    <propertyReferenceExpression name="InvariantCulture">
                      <typeReferenceExpression type="CultureInfo"/>
                    </propertyReferenceExpression>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="MinimumCapacity">
                      <variableReferenceExpression name="schema"/>
                    </propertyReferenceExpression>
                    <fieldReferenceExpression name="fieldCount"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="AllowDBNull">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="BaseColumnName">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.String"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="BaseSchemaName">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.String"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="BaseTableName">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.String"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="ColumnName">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.String"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="ColumnOrdinal">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Int32"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="ColumnSize">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Int32"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="DataType">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Object"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="IsAliased">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="IsExpression">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="IsKey">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="IsLong">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="IsUnique">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="NumericPrecision">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Int16"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="NumericScale">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Int16"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="ProviderType">
                            <typeReferenceExpression type="SchemaTableColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Int32"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>

                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="BaseCatalogName">
                            <typeReferenceExpression type="SchemaTableOptionalColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.String"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="BaseServerName">
                            <typeReferenceExpression type="SchemaTableOptionalColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.String"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="IsAutoIncrement">
                            <typeReferenceExpression type="SchemaTableOptionalColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="IsHidden">
                            <typeReferenceExpression type="SchemaTableOptionalColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="IsReadOnly">
                            <typeReferenceExpression type="SchemaTableOptionalColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="ReadOnly">
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Columns">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="IsRowVersion">
                            <typeReferenceExpression type="SchemaTableOptionalColumn"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.Boolean"/>
                        </parameters>
                      </methodInvokeExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>

                  <variableDeclarationStatement type="System.String[]" name="columnNames"/>
                  <conditionStatement>
                    <condition>
                      <fieldReferenceExpression name="hasHeaders"/>
                    </condition>
                    <trueStatements>
                      <assignStatement>
                        <variableReferenceExpression name="columnNames"/>
                        <fieldReferenceExpression name="fieldHeaders"/>
                      </assignStatement>
                    </trueStatements>
                    <falseStatements>
                      <assignStatement>
                        <variableReferenceExpression name="columnNames"/>
                        <arrayCreateExpression>
                          <createType type="System.String"/>
                          <sizeExpression>
                            <fieldReferenceExpression name="fieldCount"/>
                          </sizeExpression>
                        </arrayCreateExpression>
                      </assignStatement>
                      <forStatement>
                        <variable type="System.Int32" name="i">
                          <init>
                            <primitiveExpression value="0"/>
                          </init>
                        </variable>
                        <test>
                          <binaryOperatorExpression operator="LessThan">
                            <variableReferenceExpression name="i"/>
                            <fieldReferenceExpression name="fieldCount"/>
                          </binaryOperatorExpression>
                        </test>
                        <increment>
                          <variableReferenceExpression name="i"/>
                        </increment>
                        <statements>
                          <assignStatement>
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="columnNames"/>
                              </target>
                              <indices>
                                <variableReferenceExpression name="i"/>
                              </indices>
                            </arrayIndexerExpression>
                            <binaryOperatorExpression operator="Add">
                              <primitiveExpression value="Column"/>
                              <methodInvokeExpression methodName="ToString">
                                <target>
                                  <variableReferenceExpression name="i"/>
                                </target>
                                <parameters>
                                  <propertyReferenceExpression name="InvariantCulture">
                                    <typeReferenceExpression type="CultureInfo"/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </binaryOperatorExpression>
                          </assignStatement>
                        </statements>
                      </forStatement>
                    </falseStatements>
                  </conditionStatement>
                  <variableDeclarationStatement type="System.Object[]" name="schemaRow">
                    <init>
                      <arrayCreateExpression>
                        <createType type="System.Object"/>
                        <initializers>
                          <primitiveExpression value="true"/>
                          <primitiveExpression value="null"/>
                          <propertyReferenceExpression name="Empty">
                            <typeReferenceExpression type="System.String"/>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="Empty">
                            <typeReferenceExpression type="System.String"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="null"/>
                          <primitiveExpression value="null"/>
                          <propertyReferenceExpression name="MaxValue">
                            <typeReferenceExpression type="System.Int32"/>
                          </propertyReferenceExpression>
                          <typeofExpression type="System.String"/>
                          <primitiveExpression value="false"/>
                          <primitiveExpression value="false"/>
                          <primitiveExpression value="false"/>
                          <primitiveExpression value="false"/>
                          <primitiveExpression value="false"/>
                          <propertyReferenceExpression name="Value">
                            <typeReferenceExpression type="DBNull"/>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="Value">
                            <typeReferenceExpression type="DBNull"/>
                          </propertyReferenceExpression>
                          <castExpression targetType="System.Int32">
                            <propertyReferenceExpression name="String">
                              <typeReferenceExpression type="DbType"/>
                            </propertyReferenceExpression>
                          </castExpression>

                          <propertyReferenceExpression name="Empty">
                            <typeReferenceExpression type="System.String"/>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="Empty">
                            <typeReferenceExpression type="System.String"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="false"/>
                          <primitiveExpression value="false"/>
                          <primitiveExpression value="true"/>
                          <primitiveExpression value="false"/>
                        </initializers>
                      </arrayCreateExpression>
                    </init>
                  </variableDeclarationStatement>
                  <forStatement>
                    <variable type="System.Int32" name="j">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variable>
                    <test>
                      <binaryOperatorExpression operator="LessThan">
                        <variableReferenceExpression name="j"/>
                        <propertyReferenceExpression name="Length">
                          <variableReferenceExpression name="columnNames"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </test>
                    <increment>
                      <variableReferenceExpression name="j"/>
                    </increment>
                    <statements>
                      <assignStatement>
                        <arrayIndexerExpression>
                          <target>
                            <variableReferenceExpression name="schemaRow"/>
                          </target>
                          <indices>
                            <primitiveExpression value="1"/>
                          </indices>
                        </arrayIndexerExpression>
                        <arrayIndexerExpression>
                          <target>
                            <variableReferenceExpression name="columnNames"/>
                          </target>
                          <indices>
                            <variableReferenceExpression name="j"/>
                          </indices>
                        </arrayIndexerExpression>
                      </assignStatement>
                      <assignStatement>
                        <arrayIndexerExpression>
                          <target>
                            <variableReferenceExpression name="schemaRow"/>
                          </target>
                          <indices>
                            <primitiveExpression value="4"/>
                          </indices>
                        </arrayIndexerExpression>
                        <arrayIndexerExpression>
                          <target>
                            <variableReferenceExpression name="columnNames"/>
                          </target>
                          <indices>
                            <variableReferenceExpression name="j"/>
                          </indices>
                        </arrayIndexerExpression>
                      </assignStatement>
                      <assignStatement>
                        <arrayIndexerExpression>
                          <target>
                            <variableReferenceExpression name="schemaRow"/>
                          </target>
                          <indices>
                            <primitiveExpression value="5"/>
                          </indices>
                        </arrayIndexerExpression>
                        <variableReferenceExpression name="j"/>
                      </assignStatement>
                      <methodInvokeExpression methodName="Add">
                        <target>
                          <propertyReferenceExpression name="Rows">
                            <variableReferenceExpression name="schema"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="schemaRow"/>
                        </parameters>
                      </methodInvokeExpression>
                    </statements>
                  </forStatement>

                  <methodReturnStatement>
                    <variableReferenceExpression name="schema"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetInt32(int)-->
              <memberMethod returnType="System.Int32" name="GetInt32" privateImplementationType="IDataRecord">
                <attributes final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <variableDeclarationStatement type="System.String" name="value">
                    <init>
                      <arrayIndexerExpression>
                        <target>
                          <thisReferenceExpression/>
                        </target>
                        <indices>
                          <argumentReferenceExpression name="i"/>
                        </indices>
                      </arrayIndexerExpression>
                    </init>
                  </variableDeclarationStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <variableReferenceExpression name="value"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <methodInvokeExpression methodName="Parse">
                          <target>
                            <typeReferenceExpression type="System.Int32"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Empty">
                              <typeReferenceExpression type="System.String"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <methodReturnStatement>
                        <methodInvokeExpression methodName="Parse">
                          <target>
                            <typeReferenceExpression type="System.Int32"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="value"/>
                            <propertyReferenceExpression name="InvariantCulture">
                              <typeReferenceExpression type="CultureInfo"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </methodReturnStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- property IDataRecord.this[string]-->
              <memberProperty type="System.Object" name="Item" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.String" name="name"/>
                </parameters>
                <getStatements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <arrayIndexerExpression>
                      <target>
                        <thisReferenceExpression/>
                      </target>
                      <indices>
                        <argumentReferenceExpression name="name"/>
                      </indices>
                    </arrayIndexerExpression>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property IDataRecord.this[int]-->
              <memberProperty type="System.Object" name="Item" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <getStatements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <arrayIndexerExpression>
                      <target>
                        <thisReferenceExpression/>
                      </target>
                      <indices>
                        <argumentReferenceExpression name="i"/>
                      </indices>
                    </arrayIndexerExpression>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- method IDataRecord.GetValue(int)-->
              <memberMethod returnType="System.Object" name="GetValue" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <variableDeclarationStatement type="System.Boolean" name="isNull">
                    <init>
                      <methodInvokeExpression methodName="IsDBNull">
                        <target>
                          <castExpression targetType="IDataRecord">
                            <thisReferenceExpression/>
                          </castExpression>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="i"/>
                        </parameters>
                      </methodInvokeExpression>
                    </init>
                  </variableDeclarationStatement>
                  <conditionStatement>
                    <condition>
                      <variableReferenceExpression name="isNull"/>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <propertyReferenceExpression name="Value">
                          <typeReferenceExpression type="DBNull"/>
                        </propertyReferenceExpression>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <methodReturnStatement>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                      </methodReturnStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.IsDBNull(int)-->
              <memberMethod returnType="System.Boolean" name="IsDBNull" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <arrayIndexerExpression>
                        <target>
                          <thisReferenceExpression/>
                        </target>
                        <indices>
                          <argumentReferenceExpression name="i"/>
                        </indices>
                      </arrayIndexerExpression>
                    </unaryOperatorExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetBytes(int, long, byte[], int, int)-->
              <memberMethod returnType="System.Int64" name="GetBytes" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                  <parameter type="System.Int64" name="fieldOffset"/>
                  <parameter type="System.Byte[]" name="buffer"/>
                  <parameter type="System.Int32" name="bufferoffset"/>
                  <parameter type="System.Int32" name="length"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="CopyFieldToArray">
                      <parameters>
                        <argumentReferenceExpression name="i"/>
                        <argumentReferenceExpression name="fieldOffset"/>
                        <argumentReferenceExpression name="buffer"/>
                        <argumentReferenceExpression name="bufferoffset"/>
                        <argumentReferenceExpression name="length"/>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetByte(int)-->
              <memberMethod returnType="System.Byte" name="GetByte" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="Parse">
                      <target>
                        <typeReferenceExpression type="System.Byte"/>
                      </target>
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <propertyReferenceExpression name="CurrentCulture">
                          <typeReferenceExpression type="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetFieldType(int)-->
              <memberMethod returnType="Type" name="GetFieldType" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="EnsureInitialize"/>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanOr">
                        <binaryOperatorExpression operator="LessThan">
                          <argumentReferenceExpression name="i"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="GreaterThanOrEqual">
                          <argumentReferenceExpression name="i"/>
                          <fieldReferenceExpression name="fieldCount"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentOutOfRangeException">
                          <parameters>
                            <primitiveExpression value="i"/>
                            <argumentReferenceExpression name="i"/>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="System.String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="FieldIndexOutOfRange">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="i"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodReturnStatement>
                    <typeofExpression type="System.String"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetDecimal(int)-->
              <memberMethod returnType="System.Decimal" name="GetDecimal" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="Parse">
                      <target>
                        <typeReferenceExpression type="System.Decimal"/>
                      </target>
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <propertyReferenceExpression name="CurrentCulture">
                          <typeReferenceExpression type="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetValues(object[])-->
              <memberMethod returnType="System.Int32" name="GetValues" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Object[]" name="values"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <variableDeclarationStatement type="IDataRecord" name="record">
                    <init>
                      <castExpression targetType="IDataRecord">
                        <thisReferenceExpression/>
                      </castExpression>
                    </init>
                  </variableDeclarationStatement>
                  <forStatement>
                    <variable type="System.Int32" name="i">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variable>
                    <test>
                      <binaryOperatorExpression operator="LessThan">
                        <variableReferenceExpression name="i"/>
                        <fieldReferenceExpression name="fieldCount"/>
                      </binaryOperatorExpression>
                    </test>
                    <increment>
                      <variableReferenceExpression name="i"/>
                    </increment>
                    <statements>
                      <assignStatement>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="values"/>
                          </target>
                          <indices>
                            <variableReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <methodInvokeExpression methodName="GetValue">
                          <target>
                            <variableReferenceExpression name="record"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="i"/>
                          </parameters>
                        </methodInvokeExpression>
                      </assignStatement>
                    </statements>
                  </forStatement>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="fieldCount"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetName(int)-->
              <memberMethod returnType="System.String" name="GetName" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <propertyReferenceExpression name="IsNotClosed">
                        <typeReferenceExpression type="DataReaderValidations"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="BooleanOr">
                        <binaryOperatorExpression operator="LessThan">
                          <argumentReferenceExpression name="i"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="GreaterThanOrEqual">
                          <argumentReferenceExpression name="i"/>
                          <fieldReferenceExpression name="fieldCount"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentOutOfRangeException">
                          <parameters>
                            <primitiveExpression value="i"/>
                            <argumentReferenceExpression name="i"/>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="System.String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="FieldIndexOutOfRange">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="i"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <fieldReferenceExpression name="hasHeaders"/>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <arrayIndexerExpression>
                          <target>
                            <fieldReferenceExpression name="fieldHeaders"/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <methodReturnStatement>
                        <binaryOperatorExpression operator="Add">
                          <primitiveExpression value="Column"/>
                          <methodInvokeExpression methodName="ToString">
                            <target>
                              <argumentReferenceExpression name="i"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="InvariantCulture">
                                <typeReferenceExpression type="CultureInfo"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </methodReturnStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetInt64(int)-->
              <memberMethod returnType="System.Int64" name="GetInt64" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="Parse">
                      <target>
                        <typeReferenceExpression type="System.Int64"/>
                      </target>
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <propertyReferenceExpression name="CurrentCulture">
                          <typeReferenceExpression type="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetDouble(int)-->
              <memberMethod returnType="System.Double" name="GetDouble" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="Parse">
                      <target>
                        <typeReferenceExpression type="System.Double"/>
                      </target>
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <propertyReferenceExpression name="CurrentCulture">
                          <typeReferenceExpression type="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetBoolean(int)-->
              <memberMethod returnType="System.Boolean" name="GetBoolean" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <variableDeclarationStatement type="System.String" name="value">
                    <init>
                      <arrayIndexerExpression>
                        <target>
                          <thisReferenceExpression/>
                        </target>
                        <indices>
                          <argumentReferenceExpression name="i"/>
                        </indices>
                      </arrayIndexerExpression>
                    </init>
                  </variableDeclarationStatement>
                  <variableDeclarationStatement type="System.Int32" name="result"/>
                  <conditionStatement>
                    <condition>
                      <methodInvokeExpression methodName="TryParse">
                        <target>
                          <typeReferenceExpression type="System.Int32"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="value"/>
                          <directionExpression direction="Out">
                            <variableReferenceExpression name="result"/>
                          </directionExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <binaryOperatorExpression operator="ValueInequality">
                          <variableReferenceExpression name="result"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <methodReturnStatement>
                        <methodInvokeExpression methodName="Parse">
                          <target>
                            <typeReferenceExpression type="System.Boolean"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="value"/>
                          </parameters>
                        </methodInvokeExpression>
                      </methodReturnStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetGuid(int)-->
              <memberMethod returnType="Guid" name="GetGuid" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <objectCreateExpression type="Guid">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                      </parameters>
                    </objectCreateExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetDateTime(int)-->
              <memberMethod returnType="DateTime" name="GetDateTime" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="Parse">
                      <target>
                        <typeReferenceExpression type="DateTime"/>
                      </target>
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <propertyReferenceExpression name="CurrentCulture">
                          <typeReferenceExpression type="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetOrdinal(string)-->
              <memberMethod returnType="System.Int32" name="GetOrdinal" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.String" name="name"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="EnsureInitialize"/>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <propertyReferenceExpression name="IsNotClosed">
                        <typeReferenceExpression type="DataReaderValidations"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <variableDeclarationStatement type="System.Int32" name="index"/>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="Not">
                        <methodInvokeExpression methodName="TryGetValue">
                          <target>
                            <fieldReferenceExpression name="fieldHeaderIndexes"/>
                          </target>
                          <parameters>
                            <argumentReferenceExpression name="name"/>
                            <directionExpression direction="Out">
                              <variableReferenceExpression name="index"/>
                            </directionExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentException">
                          <parameters>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="System.String"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="InvariantCulture">
                                  <typeReferenceExpression type="CultureInfo"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="FieldHeaderNotFound">
                                  <typeReferenceExpression type="ExceptionMessage"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="name"/>
                              </parameters>
                            </methodInvokeExpression>
                            <primitiveExpression value="name"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodReturnStatement>
                    <variableReferenceExpression name="index"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetDataTypeName(int)-->
              <memberMethod returnType="System.String" name="GetDataTypeName" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <propertyReferenceExpression name="FullName">
                      <typeofExpression type="System.String"/>
                    </propertyReferenceExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetFloat(int)-->
              <memberMethod returnType="System.Single" name="GetFloat" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="Parse">
                      <target>
                        <typeReferenceExpression type="System.Single"/>
                      </target>
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <propertyReferenceExpression name="CurrentCulture">
                          <typeReferenceExpression type="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetData(int)-->
              <memberMethod returnType="IDataReader" name="GetData" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueEquality">
                        <argumentReferenceExpression name="i"/>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodReturnStatement>
                        <thisReferenceExpression/>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <methodReturnStatement>
                        <primitiveExpression value="null"/>
                      </methodReturnStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetChars(int, long, char[], int, int)-->
              <memberMethod returnType="System.Int64" name="GetChars" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                  <parameter type="System.Int64" name="fieldoffset"/>
                  <parameter type="System.Char[]" name="buffer"/>
                  <parameter type="System.Int32" name="bufferoffset"/>
                  <parameter type="System.Int32" name="length"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="CopyFieldToArray">
                      <parameters>
                        <argumentReferenceExpression name="i"/>
                        <argumentReferenceExpression name="fieldoffset"/>
                        <argumentReferenceExpression name="buffer"/>
                        <argumentReferenceExpression name="bufferoffset"/>
                        <argumentReferenceExpression name="length"/>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetString(int)-->
              <memberMethod returnType="System.String" name="GetString" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <arrayIndexerExpression>
                      <target>
                        <thisReferenceExpression/>
                      </target>
                      <indices>
                        <argumentReferenceExpression name="i"/>
                      </indices>
                    </arrayIndexerExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetChar(int)-->
              <memberMethod returnType="System.Char" name="GetChar" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="Parse">
                      <target>
                        <typeReferenceExpression type="System.Char"/>
                      </target>
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IDataRecord.GetInt16(int)-->
              <memberMethod returnType="System.Int16" name="GetInt16" privateImplementationType="IDataRecord">
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="System.Int32" name="i"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="ValidateDataReader">
                    <parameters>
                      <binaryOperatorExpression operator="BitwiseOr">
                        <propertyReferenceExpression name="IsInitialized">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="IsNotClosed">
                          <typeReferenceExpression type="DataReaderValidations"/>
                        </propertyReferenceExpression>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodReturnStatement>
                    <methodInvokeExpression methodName="Parse">
                      <target>
                        <typeReferenceExpression type="System.Int16"/>
                      </target>
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="i"/>
                          </indices>
                        </arrayIndexerExpression>
                        <propertyReferenceExpression name="CurrentCulture">
                          <typeReferenceExpression type="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method GetEnumerator-->
              <memberMethod returnType="CsvReaderRecordEnumerator" name="GetEnumerator" >
                <attributes public="true" final="true"/>
                <statements>
                  <methodReturnStatement>
                    <objectCreateExpression type="CsvReaderRecordEnumerator">
                      <parameters>
                        <thisReferenceExpression/>
                      </parameters>
                    </objectCreateExpression>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
              <!-- method IEnumerable<string[]>.GetEnumerator-->
              <!--<memberMethod returnType="IEnumerator" name="GetEnumerator" privateImplementationType="IEnumerable">
              <typeArguments>
                <typeReference type="System.String[]"/>
              </typeArguments>
              <attributes public="true" final="true"/>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="GetEnumerator">
                    <target>
                      <thisReferenceExpression/>
                    </target>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>-->
              <!-- method IEnumerable.GetEnumerator-->
              <!--<memberMethod returnType="IEnumerator" name="GetEnumerator" privateImplementationType="IEnumerable">
              <attributes public="true" final="true"/>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="GetEnumerator">
                    <target>
                      <castExpression targetType="IEnumerable">
                        <thisReferenceExpression/>
                      </castExpression>
                    </target>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>-->
              <!-- field isDisposed-->
              <memberField type="System.Boolean" name="isDisposed">
                <init>
                  <primitiveExpression value="false"/>
                </init>
              </memberField>
              <!-- field lock-->
              <!--<memberField type="System.Object" name="lock">
              <init>
                <objectCreateExpression type="System.Object"/>
              </init>
            </memberField>-->
              <!-- event Disposed -->
              <memberEvent type="EventHandler" name="Disposed">
                <attributes public="true"/>
              </memberEvent>
              <!-- property IsDisposed-->
              <memberProperty type="System.Boolean" name="IsDisposed">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="isDisposed"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- method OnDisposed(EventArgs)-->
              <memberMethod name="OnDisposed">
                <attributes family="true"/>
                <parameters>
                  <parameter type="EventArgs" name="e"/>
                </parameters>
                <statements>
                  <variableDeclarationStatement type="EventHandler" name="handler">
                    <init>
                      <eventReferenceExpression name="Disposed"/>
                    </init>
                  </variableDeclarationStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityInequality">
                        <variableReferenceExpression name="handler"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="handler">
                        <parameters>
                          <thisReferenceExpression/>
                          <argumentReferenceExpression name="e"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method CheckDisposed-->
              <memberMethod name="CheckDisposed">
                <attributes family="true" final="true"/>
                <statements>
                  <conditionStatement>
                    <condition>
                      <fieldReferenceExpression name="isDisposed"/>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ObjectDisposedException">
                          <parameters>
                            <propertyReferenceExpression name="FullName">
                              <methodInvokeExpression methodName="GetType">
                                <target>
                                  <thisReferenceExpression/>
                                </target>
                              </methodInvokeExpression>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method Dispose-->
              <memberMethod name="Dispose" privateImplementationType="IDisposable">
                <attributes public="true" final="true"/>
                <statements>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="Not">
                        <fieldReferenceExpression name="isDisposed"/>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="Dispose">
                        <parameters>
                          <primitiveExpression value="true"/>
                        </parameters>
                      </methodInvokeExpression>
                      <methodInvokeExpression methodName="SuppressFinalize">
                        <target>
                          <typeReferenceExpression type="GC"/>
                        </target>
                        <parameters>
                          <thisReferenceExpression/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method Dispose(bool)-->
              <memberMethod name="Dispose">
                <attributes family="true"/>
                <parameters>
                  <parameter type="System.Boolean" name="disposing"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <unaryOperatorExpression operator="Not">
                        <fieldReferenceExpression name="isDisposed"/>
                      </unaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <tryStatement>
                        <statements>
                          <conditionStatement>
                            <condition>
                              <argumentReferenceExpression name="disposing"/>
                            </condition>
                            <trueStatements>
                              <conditionStatement>
                                <condition>
                                  <binaryOperatorExpression operator="IdentityInequality">
                                    <fieldReferenceExpression name="reader"/>
                                    <primitiveExpression value="null"/>
                                  </binaryOperatorExpression>
                                </condition>
                                <trueStatements>
                                  <!--<comment>lock (_lock)</comment>
                                <comment>{</comment>-->
                                  <conditionStatement>
                                    <condition>
                                      <binaryOperatorExpression operator="IdentityInequality">
                                        <fieldReferenceExpression name="reader"/>
                                        <primitiveExpression value="null"/>
                                      </binaryOperatorExpression>
                                    </condition>
                                    <trueStatements>
                                      <methodInvokeExpression methodName="Dispose">
                                        <target>
                                          <fieldReferenceExpression name="reader"/>
                                        </target>
                                      </methodInvokeExpression>
                                      <assignStatement>
                                        <fieldReferenceExpression name="reader"/>
                                        <primitiveExpression value="null"/>
                                      </assignStatement>
                                      <assignStatement>
                                        <fieldReferenceExpression name="buffer"/>
                                        <primitiveExpression value="null"/>
                                      </assignStatement>
                                      <assignStatement>
                                        <fieldReferenceExpression name="eof"/>
                                        <primitiveExpression value="true"/>
                                      </assignStatement>
                                    </trueStatements>
                                  </conditionStatement>
                                  <!--<comment>}</comment>-->
                                </trueStatements>
                              </conditionStatement>
                            </trueStatements>
                          </conditionStatement>
                        </statements>
                        <finally>
                          <assignStatement>
                            <fieldReferenceExpression name="isDisposed"/>
                            <primitiveExpression value="true"/>
                          </assignStatement>
                          <tryStatement>
                            <statements>
                              <methodInvokeExpression methodName="OnDisposed">
                                <parameters>
                                  <propertyReferenceExpression name="Empty">
                                    <typeReferenceExpression type="EventArgs"/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </statements>
                            <catch exceptionType="Exception">
                            </catch>
                          </tryStatement>
                        </finally>
                      </tryStatement>
                    </trueStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method ~CsvReader-->
              <!--<memberMethod name="~CsvReader">
              <attributes final="true"/>
              <statements>
                <methodInvokeExpression methodName="Dispose">
                  <parameters>
                    <primitiveExpression value="false"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>-->
            </members>
          </typeDeclaration>
          <!-- enum DataReaderValidations -->
          <typeDeclaration isEnum="true" name="DataReaderValidations">
            <attributes notPublic="true"/>
            <members>
              <!-- field None=0-->
              <memberField type="System.Int32" name="None">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="0"/>
                </init>
              </memberField>
              <!-- field IsInitialized=1-->
              <memberField type="System.Int32" name="IsInitialized">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="1"/>
                </init>
              </memberField>
              <!-- field IsNotClosed=2-->
              <memberField type="System.Int32" name="IsNotClosed">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="2"/>
                </init>
              </memberField>
            </members>
          </typeDeclaration>
          <!-- struct CsvReaderRecordEnumerator -->
          <typeDeclaration name="CsvReaderRecordEnumerator">
            <attributes public="true"/>
            <baseTypes>
              <typeReference type="System.Object"/>
              <!--<typeReference type="IEnumerator">
              <typeArguments>
                <typeReference type="System.String[]"/>
              </typeArguments>
            </typeReference>-->
              <typeReference type="IEnumerator"/>
              <typeReference type="IDisposable"/>
            </baseTypes>
            <members>
              <!-- constructor CsvReaderRecordEnumerator(CsvReader)-->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="CsvReader" name="reader"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <argumentReferenceExpression name="reader"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentNullException">
                          <parameters>
                            <primitiveExpression value="reader"/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="reader"/>
                    <argumentReferenceExpression name="reader"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="current"/>
                    <primitiveExpression value="null"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentRecordIndex"/>
                    <propertyReferenceExpression name="CurrentRecordIndex">
                      <argumentReferenceExpression name="reader"/>
                    </propertyReferenceExpression>
                  </assignStatement>
                </statements>
              </constructor>
              <!-- field current -->
              <memberField type="System.String[]" name="current"/>
              <!-- field currentRecordIndex-->
              <memberField type="System.Int64" name="currentRecordIndex"/>
              <!-- field reader-->
              <memberField type="CsvReader" name="reader"/>
              <!-- property Current-->
              <memberProperty type="System.String[]" name="Current">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="current"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- method MoveNext-->
              <memberMethod returnType="System.Boolean" name="MoveNext" privateImplementationType="IEnumerator">
                <attributes public="true" final="true"/>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueInequality">
                        <propertyReferenceExpression name="CurrentRecordIndex">
                          <fieldReferenceExpression name="reader"/>
                        </propertyReferenceExpression>
                        <fieldReferenceExpression name="currentRecordIndex"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="InvalidOperationException">
                          <parameters>
                            <propertyReferenceExpression name="EnumerationVersionCheckFailed">
                              <typeReferenceExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <methodInvokeExpression methodName="ReadNextRecord">
                        <target>
                          <fieldReferenceExpression name="reader"/>
                        </target>
                      </methodInvokeExpression>
                    </condition>
                    <trueStatements>
                      <assignStatement>
                        <fieldReferenceExpression name="current"/>
                        <arrayCreateExpression>
                          <createType type="System.String"/>
                          <sizeExpression>
                            <propertyReferenceExpression name="FieldCount">
                              <castExpression targetType="IDataRecord">
                                <fieldReferenceExpression name="reader"/>
                              </castExpression>
                            </propertyReferenceExpression>
                          </sizeExpression>
                        </arrayCreateExpression>
                      </assignStatement>
                      <methodInvokeExpression methodName="CopyCurrentRecordTo">
                        <target>
                          <fieldReferenceExpression name="reader"/>
                        </target>
                        <parameters>
                          <fieldReferenceExpression name="current"/>
                        </parameters>
                      </methodInvokeExpression>
                      <assignStatement>
                        <fieldReferenceExpression name="currentRecordIndex"/>
                        <propertyReferenceExpression name="CurrentRecordIndex">
                          <fieldReferenceExpression name="reader"/>
                        </propertyReferenceExpression>
                      </assignStatement>
                      <methodReturnStatement>
                        <primitiveExpression value="true"/>
                      </methodReturnStatement>
                    </trueStatements>
                    <falseStatements>
                      <assignStatement>
                        <fieldReferenceExpression name="current"/>
                        <primitiveExpression value="null"/>
                      </assignStatement>
                      <assignStatement>
                        <fieldReferenceExpression name="currentRecordIndex"/>
                        <propertyReferenceExpression name="CurrentRecordIndex">
                          <fieldReferenceExpression name="reader"/>
                        </propertyReferenceExpression>
                      </assignStatement>
                      <methodReturnStatement>
                        <primitiveExpression value="false"/>
                      </methodReturnStatement>
                    </falseStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
              <!-- method Reset-->
              <memberMethod name="Reset" privateImplementationType="IEnumerator">
                <attributes public="true" final="true"/>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueInequality">
                        <propertyReferenceExpression name="CurrentRecordIndex">
                          <fieldReferenceExpression name="reader"/>
                        </propertyReferenceExpression>
                        <fieldReferenceExpression name="currentRecordIndex"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="InvalidOperationException">
                          <parameters>
                            <propertyReferenceExpression name="EnumerationVersionCheckFailed">
                              <typeReferenceExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodInvokeExpression methodName="MoveTo">
                    <target>
                      <fieldReferenceExpression name="reader"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="-1"/>
                    </parameters>
                  </methodInvokeExpression>
                  <assignStatement>
                    <fieldReferenceExpression name="current"/>
                    <primitiveExpression value="null"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentRecordIndex"/>
                    <propertyReferenceExpression name="CurrentRecordIndex">
                      <fieldReferenceExpression name="reader"/>
                    </propertyReferenceExpression>
                  </assignStatement>
                </statements>
              </memberMethod>
              <!-- property IEnumerator.Current-->
              <memberProperty type="System.Object" name="Current" privateImplementationType="IEnumerator">
                <attributes public="true" final="true"/>
                <getStatements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="ValueInequality">
                        <propertyReferenceExpression name="CurrentRecordIndex">
                          <fieldReferenceExpression name="reader"/>
                        </propertyReferenceExpression>
                        <fieldReferenceExpression name="currentRecordIndex"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="InvalidOperationException">
                          <parameters>
                            <propertyReferenceExpression name="EnumerationVersionCheckFailed">
                              <typeReferenceExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <methodReturnStatement>
                    <propertyReferenceExpression name="Current">
                      <thisReferenceExpression/>
                    </propertyReferenceExpression>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- method Dispose-->
              <memberMethod name="Dispose" privateImplementationType="IDisposable">
                <attributes public="true" final="true"/>
                <statements>
                  <assignStatement>
                    <fieldReferenceExpression name="reader"/>
                    <primitiveExpression value="null"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="current"/>
                    <primitiveExpression value="null"/>
                  </assignStatement>
                </statements>
              </memberMethod>
            </members>
          </typeDeclaration>
          <!-- enum MissingFieldAction-->
          <typeDeclaration isEnum="true" name="MissingFieldAction">
            <attributes public="true"/>
            <members>
              <!-- field ParseError=0-->
              <memberField type="System.Int32" name="ParseError">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="0"/>
                </init>
              </memberField>
              <!-- field ReplaceByEmpty=1-->
              <memberField type="System.Int32" name="ReplaceByEmpty">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="1"/>
                </init>
              </memberField>
              <!-- field ReplaceByNull=2-->
              <memberField type="System.Int32" name="ReplaceByNull">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="2"/>
                </init>
              </memberField>
            </members>
          </typeDeclaration>
          <!-- enum ParseErrorAction-->
          <typeDeclaration isEnum="true" name="ParseErrorAction">
            <attributes public="true"/>
            <members>
              <!-- field RaiseEvent=0-->
              <memberField type="System.Int32" name="RaiseEvent">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="0"/>
                </init>
              </memberField>
              <!-- field AdvanceToNextLine=1-->
              <memberField type="System.Int32" name="AdvanceToNextLine">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="1"/>
                </init>
              </memberField>
              <!-- field ThrowException=2-->
              <memberField type="System.Int32" name="ThrowException">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="2"/>
                </init>
              </memberField>
            </members>
          </typeDeclaration>
          <!-- enum ValueTrimmingOptions-->
          <typeDeclaration isEnum="true" name="ValueTrimmingOptions">
            <attributes public="true"/>
            <customAttributes>
              <customAttribute name="Flags"/>
            </customAttributes>
            <members>
              <!-- field None=0-->
              <memberField type="System.Int32" name="None">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="0"/>
                </init>
              </memberField>
              <!-- field UnquotedOnly=1-->
              <memberField type="System.Int32" name="UnquotedOnly">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="1"/>
                </init>
              </memberField>
              <!-- field QuotedOnly=2-->
              <memberField type="System.Int32" name="QuotedOnly">
                <attributes public="true"/>
                <init>
                  <primitiveExpression value="2"/>
                </init>
              </memberField>
              <!-- field All-->
              <memberField type="System.Int32" name="All">
                <attributes public="true"/>
                <init>
                  <binaryOperatorExpression operator="BitwiseOr">
                    <propertyReferenceExpression name="UnquotedOnly"/>
                    <propertyReferenceExpression name="QuotedOnly"/>
                  </binaryOperatorExpression>
                </init>
              </memberField>
            </members>
          </typeDeclaration>
          <!-- class ParseErrorEventArgs-->
          <typeDeclaration name="ParseErrorEventArgs">
            <attributes public="true"/>
            <baseTypes>
              <typeReference type="EventArgs"/>
            </baseTypes>
            <members>
              <!-- property Error-->
              <memberProperty type="MalformedCsvException" name="Error">
                <attributes public="true" final="true"/>
              </memberProperty>
              <!-- property Action-->
              <memberProperty type="ParseErrorAction" name="Action">
                <attributes public="true" final="true"/>
              </memberProperty>
              <!-- constructor(MalformedCsvException, ParseErrorAction)-->
              <constructor>
                <attributes public="true" final="true"/>
                <parameters>
                  <parameter type="MalformedCsvException" name="error"/>
                  <parameter type="ParseErrorAction" name="defaultAction"/>
                </parameters>
                <baseConstructorArgs>
                </baseConstructorArgs>
              </constructor>
            </members>
          </typeDeclaration>
          <!-- class MalformedCsvException-->
          <typeDeclaration name="MalformedCsvException">
            <attributes public="true"/>
            <baseTypes>
              <typeReference type="Exception"/>
            </baseTypes>
            <members>
              <!-- field message-->
              <memberField type="System.String" name="message"/>
              <!-- field rawData-->
              <memberField type="System.String" name="rawData"/>
              <!-- field currentFieldIndex-->
              <memberField type="System.Int32" name="currentFieldIndex"/>
              <!-- field currentRecordIndex-->
              <memberField type="System.Int64" name="currentRecordIndex"/>
              <!-- field currentPosition-->
              <memberField type="System.Int32" name="currentPosition"/>
              <!-- constructor-->
              <constructor>
                <attributes public="true"/>
                <chainedConstructorArgs>
                  <castExpression targetType="System.String">
                    <primitiveExpression value="null"/>
                  </castExpression>
                  <primitiveExpression value="null"/>
                </chainedConstructorArgs>
              </constructor>
              <!-- constructor (string)-->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="System.String" name="message"/>
                </parameters>
                <chainedConstructorArgs>
                  <argumentReferenceExpression name="message"/>
                  <primitiveExpression value="null"/>
                </chainedConstructorArgs>
              </constructor>
              <!-- constructor (string, Exception)-->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="System.String" name="message"/>
                  <parameter type="Exception" name="innerException"/>
                </parameters>
                <baseConstructorArgs>
                  <propertyReferenceExpression name="Empty">
                    <typeReferenceExpression type="String"/>
                  </propertyReferenceExpression>
                  <argumentReferenceExpression name="innerException"/>
                </baseConstructorArgs>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <argumentReferenceExpression name="message"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <assignStatement>
                        <fieldReferenceExpression name="message"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="System.String"/>
                        </propertyReferenceExpression>
                      </assignStatement>
                    </trueStatements>
                    <falseStatements>
                      <assignStatement>
                        <fieldReferenceExpression name="message"/>
                        <argumentReferenceExpression name="message"/>
                      </assignStatement>
                    </falseStatements>
                  </conditionStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="rawData"/>
                    <propertyReferenceExpression name="Empty">
                      <typeReferenceExpression type="System.String"/>
                    </propertyReferenceExpression>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentPosition"/>
                    <primitiveExpression value="-1"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentRecordIndex"/>
                    <primitiveExpression value="-1"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentFieldIndex"/>
                    <primitiveExpression value="-1"/>
                  </assignStatement>
                </statements>
              </constructor>
              <!-- constructor (string, int, long, int)-->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="System.String" name="rawData"/>
                  <parameter type="System.Int32" name="currentPosition"/>
                  <parameter type="System.Int64" name="currentRecordIndex"/>
                  <parameter type="System.Int32" name="currentFieldIndex"/>
                </parameters>
                <chainedConstructorArgs>
                  <argumentReferenceExpression name="rawData"/>
                  <argumentReferenceExpression name="currentPosition"/>
                  <argumentReferenceExpression name="currentRecordIndex"/>
                  <argumentReferenceExpression name="currentFieldIndex"/>
                  <primitiveExpression value="null"/>
                </chainedConstructorArgs>
              </constructor>
              <!-- constructor (string, int, long, int, Exception)-->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="System.String" name="rawData"/>
                  <parameter type="System.Int32" name="currentPosition"/>
                  <parameter type="System.Int64" name="currentRecordIndex"/>
                  <parameter type="System.Int32" name="currentFieldIndex"/>
                  <parameter type="Exception" name="innerException"/>
                </parameters>
                <baseConstructorArgs>
                  <propertyReferenceExpression name="Empty">
                    <typeReferenceExpression type="String"/>
                  </propertyReferenceExpression>
                  <argumentReferenceExpression name="innerException"/>
                </baseConstructorArgs>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <argumentReferenceExpression name="rawData"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <assignStatement>
                        <fieldReferenceExpression name="rawData"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="System.String"/>
                        </propertyReferenceExpression>
                      </assignStatement>
                    </trueStatements>
                    <falseStatements>
                      <assignStatement>
                        <fieldReferenceExpression name="rawData"/>
                        <argumentReferenceExpression name="rawData"/>
                      </assignStatement>
                    </falseStatements>
                  </conditionStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentPosition"/>
                    <argumentReferenceExpression name="currentPosition"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentRecordIndex"/>
                    <argumentReferenceExpression name="currentRecordIndex"/>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentFieldIndex"/>
                    <argumentReferenceExpression name="currentFieldIndex"/>
                  </assignStatement>
                </statements>
              </constructor>
              <!-- constructor (SerializationInfo, StreamingContext)-->
              <constructor>
                <attributes family="true"/>
                <parameters>
                  <parameter type="SerializationInfo" name="info"/>
                  <parameter type="StreamingContext" name="context"/>
                </parameters>
                <baseConstructorArgs>
                  <argumentReferenceExpression name="info"/>
                  <argumentReferenceExpression name="context"/>
                </baseConstructorArgs>
                <statements>
                  <assignStatement>
                    <fieldReferenceExpression name="message"/>
                    <methodInvokeExpression methodName="GetString">
                      <target>
                        <argumentReferenceExpression name="info"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="MyMessage"/>
                      </parameters>
                    </methodInvokeExpression>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="rawData"/>
                    <methodInvokeExpression methodName="GetString">
                      <target>
                        <argumentReferenceExpression name="info"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="RawData"/>
                      </parameters>
                    </methodInvokeExpression>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentPosition"/>
                    <methodInvokeExpression methodName="GetInt32">
                      <target>
                        <argumentReferenceExpression name="info"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="CurrentPosition"/>
                      </parameters>
                    </methodInvokeExpression>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentRecordIndex"/>
                    <methodInvokeExpression methodName="GetInt64">
                      <target>
                        <argumentReferenceExpression name="info"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="currentRecordIndex"/>
                      </parameters>
                    </methodInvokeExpression>
                  </assignStatement>
                  <assignStatement>
                    <fieldReferenceExpression name="currentFieldIndex"/>
                    <methodInvokeExpression methodName="GetInt32">
                      <target>
                        <argumentReferenceExpression name="info"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="currentFieldIndex"/>
                      </parameters>
                    </methodInvokeExpression>
                  </assignStatement>
                </statements>
              </constructor>
              <!-- property RawData-->
              <memberProperty type="System.String" name="RawData">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="rawData"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property CurrentPosition-->
              <memberProperty type="System.Int32" name="CurrentPosition">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="currentPosition"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property CurrentRecordIndex-->
              <memberProperty type="System.Int64" name="CurrentRecordIndex">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="currentRecordIndex"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property CurrentFieldIndex-->
              <memberProperty type="System.Int32" name="CurrentFieldIndex">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="currentFieldIndex"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property Message-->
              <memberProperty type="System.String" name="Message">
                <attributes public="true" override="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="message"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- method GetObjectData(System.RunTime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext)-->
              <memberMethod name="GetObjectData">
                <attributes public="true" override="true"/>
                <parameters>
                  <parameter type="System.Runtime.Serialization.SerializationInfo" name="info"/>
                  <parameter type="System.Runtime.Serialization.StreamingContext" name="context"/>
                </parameters>
                <statements>
                  <methodInvokeExpression methodName="GetObjectData">
                    <target>
                      <baseReferenceExpression/>
                    </target>
                    <parameters>
                      <argumentReferenceExpression name="info"/>
                      <argumentReferenceExpression name="context"/>
                    </parameters>
                  </methodInvokeExpression>
                  <methodInvokeExpression methodName="AddValue">
                    <target>
                      <argumentReferenceExpression name="info"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="MyMessage"/>
                      <fieldReferenceExpression name="message"/>
                    </parameters>
                  </methodInvokeExpression>
                  <methodInvokeExpression methodName="AddValue">
                    <target>
                      <argumentReferenceExpression name="info"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="RawData"/>
                      <fieldReferenceExpression name="rawData"/>
                    </parameters>
                  </methodInvokeExpression>
                  <methodInvokeExpression methodName="AddValue">
                    <target>
                      <argumentReferenceExpression name="info"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="CurrentPosition"/>
                      <fieldReferenceExpression name="currentPosition"/>
                    </parameters>
                  </methodInvokeExpression>
                  <methodInvokeExpression methodName="AddValue">
                    <target>
                      <argumentReferenceExpression name="info"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="CurrentRecordIndex"/>
                      <fieldReferenceExpression name="currentRecordIndex"/>
                    </parameters>
                  </methodInvokeExpression>
                  <methodInvokeExpression methodName="AddValue">
                    <target>
                      <argumentReferenceExpression name="info"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="CurrentFieldIndex"/>
                      <fieldReferenceExpression name="currentFieldIndex"/>
                    </parameters>
                  </methodInvokeExpression>
                </statements>
              </memberMethod>
            </members>
          </typeDeclaration>
          <!-- class MissingFieldCsvException-->
          <typeDeclaration name="MissingFieldCsvException">
            <attributes public="true"/>
            <customAttributes>
              <customAttribute name="Serializable"/>
            </customAttributes>
            <baseTypes>
              <typeReference type="MalformedCsvException"/>
            </baseTypes>
            <members>
              <!-- constructor-->
              <constructor>
                <attributes public="true"/>
                <baseConstructorArgs/>
              </constructor>
              <!-- constructor (string)-->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="System.String" name="message"/>
                </parameters>
                <baseConstructorArgs>
                  <argumentReferenceExpression name="message"/>
                </baseConstructorArgs>
              </constructor>
              <!-- constructor (string, Exception)-->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="System.String" name="message"/>
                  <parameter type="Exception" name="innerException"/>
                </parameters>
                <baseConstructorArgs>
                  <argumentReferenceExpression name="message"/>
                  <argumentReferenceExpression name="innerException"/>
                </baseConstructorArgs>
              </constructor>
              <!-- constructor (string, int, long, int)-->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="System.String" name="rawData"/>
                  <parameter type="System.Int32" name="currentPosition"/>
                  <parameter type="System.Int64" name="currentRecordIndex"/>
                  <parameter type="System.Int32" name="currentFieldIndex"/>
                </parameters>
                <baseConstructorArgs>
                  <argumentReferenceExpression name="rawData"/>
                  <argumentReferenceExpression name="currentPosition"/>
                  <argumentReferenceExpression name="currentRecordIndex"/>
                  <argumentReferenceExpression name="currentFieldIndex"/>
                </baseConstructorArgs>
              </constructor>
              <!-- constructor (string, int, long, int, Exception)-->
              <constructor>
                <attributes public="true"/>
                <parameters>
                  <parameter type="System.String" name="rawData"/>
                  <parameter type="System.Int32" name="currentPosition"/>
                  <parameter type="System.Int64" name="currentRecordIndex"/>
                  <parameter type="System.Int32" name="currentFieldIndex"/>
                  <parameter type="Exception" name="innerException"/>
                </parameters>
                <baseConstructorArgs>
                  <argumentReferenceExpression name="rawData"/>
                  <argumentReferenceExpression name="currentPosition"/>
                  <argumentReferenceExpression name="currentRecordIndex"/>
                  <argumentReferenceExpression name="currentFieldIndex"/>
                  <argumentReferenceExpression name="innerException"/>
                </baseConstructorArgs>
              </constructor>
              <!-- constructor (SerializationInfo, StreamingContext)-->
              <constructor>
                <attributes family="true"/>
                <parameters>
                  <parameter type="SerializationInfo" name="info"/>
                  <parameter type="StreamingContext" name="context"/>
                </parameters>
                <baseConstructorArgs>
                  <argumentReferenceExpression name="info"/>
                  <argumentReferenceExpression name="context"/>
                </baseConstructorArgs>
              </constructor>
            </members>
          </typeDeclaration>
          <!-- class ExceptionMessage-->
          <typeDeclaration name="ExceptionMessage">
            <attributes nestedAssembly="true"/>
            <customAttributes>
              <!--<customAttribute name="System.CodeDom.Compiler.GeneratedCodeAttribute">
              <arguments>
                <primitiveExpression value="System.Resources.Tools.StronglyTypedResourceBuilder"/>
                <primitiveExpression value="2.0.0.0"/>
              </arguments>
            </customAttribute>-->
              <customAttribute name="System.Diagnostics.DebuggerNonUserCodeAttribute"/>
              <!--<customAttribute name="System.Runtime.CompilerServices.CompilerGeneratedAttribute"/>-->
            </customAttributes>
            <members>
              <!-- constructor-->
              <!-- add custom attributes???-->
              <constructor>
                <attributes assembly="true"/>
              </constructor>
              <!-- field resourceMan-->
              <!--<memberField type="System.Resources.ResourceManager" name="resourceMan">
              <attributes private="true" static="true" />
            </memberField>-->
              <!-- field resourceCulture-->
              <!--<memberField type="System.Globalization.CultureInfo" name="resourceCulture">
              <attributes private="true" static="true"/>
            </memberField>-->
              <!-- property ResourceManager -->
              <!--<memberProperty type="System.Resources.ResourceManager" name="ResourceManager">
              <attributes assembly="true" static="true"/>
              <customAttributes>
                <customAttribute type="System.ComponentModel.EditorBrowsableAttribute">
                  <arguments>
                    <propertyReferenceExpression name="Advanced">
                      <typeReferenceExpression type="System.ComponentModel.EditorBrowsableState"/>
                    </propertyReferenceExpression>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="ReferenceEquals">
                      <target>
                        <typeReferenceExpression type="System.Object"/>
                      </target>
                      <parameters>
                        <fieldReferenceExpression name="resourceMan"/>
                        <primitiveExpression value="null"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.Resources.ResourceManager" name="temp">
                      <init>
                        <objectCreateExpression type="System.Resources.ResourceManager">
                          <parameters>
                            <primitiveExpression value="CsvReaderDemo.Properties.Resources"/>
                            <propertyReferenceExpression name="Assembly">
                              <typeofExpression type="ExceptionMessage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <assignStatement>
                      <fieldReferenceExpression name="resourceMan"/>
                      <variableReferenceExpression name="temp"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <fieldReferenceExpression name="resourceMan"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>-->
              <!-- property Culture -->
              <!--<memberProperty type="System.Globalization.CultureInfo" name="Culture">
              <attributes assembly="true" static="true"/>
              <customAttributes>
                <customAttribute type="System.ComponentModel.EditorBrowsableAttribute">
                  <arguments>
                    <propertyReferenceExpression name="Advanced">
                      <typeReferenceExpression type="System.ComponentModel.EditorBrowsableState"/>
                    </propertyReferenceExpression>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="resourceCulture"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="resourceCulture"/>
                  <argumentReferenceExpression name="value"/>
                </assignStatement>
              </setStatements>
            </memberProperty>-->
              <!-- property BufferSizeTooSmall-->
              <memberProperty type="System.String" name="BufferSizeTooSmall">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Buffer size is too small."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="BufferSizeTooSmall"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property CannotMovePreviousRecordInForwardOnly-->
              <memberProperty type="System.String" name="CannotMovePreviousRecordInForwardOnly">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Cannot move previous record in forward only."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="CannotMovePreviousRecordInForwardOnly"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property CannotReadRecordAtIndex-->
              <memberProperty type="System.String" name="CannotReadRecordAtIndex">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Cannot read record at index."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="CannotReadRecordAtIndex"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property EnumerationFinishedOrNotStarted-->
              <memberProperty type="System.String" name="EnumerationFinishedOrNotStarted">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Enumeration finished or not started."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="EnumerationFinishedOrNotStarted"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property EnumerationVersionCheckFailed-->
              <memberProperty type="System.String" name="EnumerationVersionCheckFailed">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Enumeration version check failed."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="EnumerationVersionCheckFailed"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property FieldHeaderNotFound-->
              <memberProperty type="System.String" name="FieldHeaderNotFound">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Field header not found."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="FieldHeaderNotFound"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property FieldIndexOutOfRange-->
              <memberProperty type="System.String" name="FieldIndexOutOfRange">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Field index out of range."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="FieldIndexOutOfRange"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property MalformedCsvException-->
              <memberProperty type="System.String" name="MalformedCsvException">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Malformed CSV exception."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="MalformedCsvException"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property MissingFieldActionNotSupported-->
              <memberProperty type="System.String" name="MissingFieldActionNotSupported">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Missing field action not supported."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="MissingFieldActionNotSupported"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property NoCurrentRecord-->
              <memberProperty type="System.String" name="NoCurrentRecord">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="No current record."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="NoCurrentRecord"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property NoHeaders-->
              <memberProperty type="System.String" name="NoHeaders">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="No headers."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="NoHeaders"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property NotEnoughSpaceInArray-->
              <memberProperty type="System.String" name="NotEnoughSpaceInArray">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Not enough space in array."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="NotEnoughSpaceInArray"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property ParseErrorActionInvalidInsideParseErrorEvent-->
              <memberProperty type="System.String" name="ParseErrorActionInvalidInsideParseErrorEvent">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Parse error action invalid inside parse error event."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="PaseErrorActionInvalidInsideParseErrorEvent"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property ParseErrorActionNotSupported-->
              <memberProperty type="System.String" name="ParseErrorActionNotSupported">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Parse error action not supported."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="ParseErrorActionNotSupported"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property ReaderClosed-->
              <memberProperty type="System.String" name="ReaderClosed">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Reader closed."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="ReaderClosed"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property RecordIndexLessThanZero-->
              <memberProperty type="System.String" name="RecordIndexLessThanZero">
                <attributes assembly="true" static="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="Record index less than zero."/>
                    <!--<methodInvokeExpression methodName="GetString">
                    <target>
                      <typeReferenceExpression type="ResourceManager"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="RecordIndexLessThanZero"/>
                      <fieldReferenceExpression name="resourceCulture"/>
                    </parameters>
                  </methodInvokeExpression>-->
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
            </members>
          </typeDeclaration>
        </xsl:if>
      </types>
    </compileUnit>
  </xsl:template>
  <xsl:template name="GenerateMembers">
    <!-- method Process(object)  -->
    <memberMethod name="Process">
      <attributes private="true" static="true"/>
      <parameters>
        <parameter type="System.Object" name="args"/>
      </parameters>
      <statements>
        <variableDeclarationStatement type="List" name="arguments">
          <typeArguments>
            <typeReference type="System.String"/>
          </typeArguments>
          <init>
            <objectCreateExpression type="List">
              <typeArguments>
                <typeReference type="System.String"/>
              </typeArguments>
              <parameters>
                <methodInvokeExpression methodName="Split">
                  <target>
                    <propertyReferenceExpression name="CommandArgument">
                      <castExpression targetType="ActionArgs">
                        <argumentReferenceExpression name="args"/>
                      </castExpression>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value=";" convertTo="Char"/>
                  </parameters>
                </methodInvokeExpression>
              </parameters>
            </objectCreateExpression>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="System.String" name="fileName">
          <init>
            <methodInvokeExpression methodName="Combine">
              <target>
                <typeReferenceExpression type="Path"/>
              </target>
              <parameters>
                <propertyReferenceExpression name="SharedTempPath">
                  <typeReferenceExpression type="ImportProcessor"/>
                </propertyReferenceExpression>
                <arrayIndexerExpression>
                  <target>
                    <variableReferenceExpression name="arguments"/>
                  </target>
                  <indices>
                    <primitiveExpression value="0"/>
                  </indices>
                </arrayIndexerExpression>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <methodInvokeExpression methodName="RemoveAt">
          <target>
            <variableReferenceExpression name="arguments"/>
          </target>
          <parameters>
            <primitiveExpression value="0"/>
          </parameters>
        </methodInvokeExpression>
        <variableDeclarationStatement type="System.String" name="controller">
          <init>
            <arrayIndexerExpression>
              <target>
                <variableReferenceExpression name="arguments"/>
              </target>
              <indices>
                <primitiveExpression value="0"/>
              </indices>
            </arrayIndexerExpression>
          </init>
        </variableDeclarationStatement>
        <methodInvokeExpression methodName="RemoveAt">
          <target>
            <variableReferenceExpression name="arguments"/>
          </target>
          <parameters>
            <primitiveExpression value="0"/>
          </parameters>
        </methodInvokeExpression>
        <variableDeclarationStatement type="System.String" name="view">
          <init>
            <arrayIndexerExpression>
              <target>
                <variableReferenceExpression name="arguments"/>
              </target>
              <indices>
                <primitiveExpression value="0"/>
              </indices>
            </arrayIndexerExpression>
          </init>
        </variableDeclarationStatement>
        <methodInvokeExpression methodName="RemoveAt">
          <target>
            <variableReferenceExpression name="arguments"/>
          </target>
          <parameters>
            <primitiveExpression value="0"/>
          </parameters>
        </methodInvokeExpression>
        <variableDeclarationStatement type="System.String" name="notify">
          <init>
            <arrayIndexerExpression>
              <target>
                <variableReferenceExpression name="arguments"/>
              </target>
              <indices>
                <primitiveExpression value="0"/>
              </indices>
            </arrayIndexerExpression>
          </init>
        </variableDeclarationStatement>
        <methodInvokeExpression methodName="RemoveAt">
          <target>
            <variableReferenceExpression name="arguments"/>
          </target>
          <parameters>
            <primitiveExpression value="0"/>
          </parameters>
        </methodInvokeExpression>
        <variableDeclarationStatement type="ImportProcessorBase" name="ip">
          <init>
            <methodInvokeExpression methodName="Create">
              <target>
                <typeReferenceExpression type="ImportProcessorFactory"/>
              </target>
              <parameters>
                <variableReferenceExpression name="fileName"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <tryStatement>
          <statements>
            <methodInvokeExpression methodName="Process">
              <target>
                <variableReferenceExpression name="ip"/>
              </target>
              <parameters>
                <variableReferenceExpression name="fileName"/>
                <variableReferenceExpression name="controller"/>
                <variableReferenceExpression name="view"/>
                <variableReferenceExpression name="notify"/>
                <variableReferenceExpression name="arguments"/>
              </parameters>
            </methodInvokeExpression>
          </statements>
          <finally>
            <conditionStatement>
              <condition>
                <methodInvokeExpression methodName="Exists">
                  <target>
                    <typeReferenceExpression type="File"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="fileName"/>
                  </parameters>
                </methodInvokeExpression>
              </condition>
              <trueStatements>
                <tryStatement>
                  <statements>
                    <methodInvokeExpression methodName="Delete">
                      <target>
                        <typeReferenceExpression type="File"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="fileName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                  <catch exceptionType="Exception"/>
                </tryStatement>
              </trueStatements>
            </conditionStatement>
          </finally>
        </tryStatement>
      </statements>
    </memberMethod>
    <!-- method OpenRead(stirng, string) -->
    <memberMethod returnType="IDataReader" name="OpenRead">
      <attributes public="true" />
      <parameters>
        <parameter type="System.String" name="fileName"/>
        <parameter type="System.String" name="selectClause"/>
      </parameters>
      <statements>
        <variableDeclarationStatement type="System.String" name="extension">
          <init>
            <methodInvokeExpression methodName="ToLower">
              <target>
                <methodInvokeExpression methodName="GetExtension">
                  <target>
                    <typeReferenceExpression type="Path"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="fileName"/>
                  </parameters>
                </methodInvokeExpression>
              </target>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="System.String" name="tableName">
          <init>
            <primitiveExpression value="null"/>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="OleDbConnectionStringBuilder" name="connectionString">
          <init>
            <objectCreateExpression type="OleDbConnectionStringBuilder"/>
          </init>
        </variableDeclarationStatement>
        <assignStatement>
          <propertyReferenceExpression name="Provider">
            <variableReferenceExpression name="connectionString"/>
          </propertyReferenceExpression>
          <primitiveExpression value="Microsoft.ACE.OLEDB.12.0"/>
        </assignStatement>
        <conditionStatement>
          <condition>
            <binaryOperatorExpression operator="ValueEquality">
              <variableReferenceExpression name="extension"/>
              <primitiveExpression value=".csv"/>
            </binaryOperatorExpression>
          </condition>
          <trueStatements>
            <assignStatement>
              <arrayIndexerExpression>
                <target>
                  <variableReferenceExpression name="connectionString"/>
                </target>
                <indices>
                  <primitiveExpression value="Extended Properties"/>
                </indices>
              </arrayIndexerExpression>
              <primitiveExpression value="text;HDR=Yes;FMT=Delimited"/>
            </assignStatement>
            <assignStatement>
              <propertyReferenceExpression name="DataSource">
                <variableReferenceExpression name="connectionString"/>
              </propertyReferenceExpression>
              <methodInvokeExpression methodName="GetDirectoryName">
                <target>
                  <typeReferenceExpression type="Path"/>
                </target>
                <parameters>
                  <variableReferenceExpression name="fileName"/>
                </parameters>
              </methodInvokeExpression>
            </assignStatement>
            <assignStatement>
              <variableReferenceExpression name="tableName"/>
              <methodInvokeExpression methodName="GetFileName">
                <target>
                  <typeReferenceExpression type="Path"/>
                </target>
                <parameters>
                  <variableReferenceExpression name="fileName"/>
                </parameters>
              </methodInvokeExpression>
            </assignStatement>
          </trueStatements>
          <falseStatements>
            <conditionStatement>
              <condition>
                <binaryOperatorExpression operator="ValueEquality">
                  <variableReferenceExpression name="extension"/>
                  <primitiveExpression value=".xls"/>
                </binaryOperatorExpression>
              </condition>
              <trueStatements>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <variableReferenceExpression name="connectionString"/>
                    </target>
                    <indices>
                      <primitiveExpression value="Extended Properties"/>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="Excel 8.0;HDR=Yes;IMEX=1"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="DataSource">
                    <variableReferenceExpression name="connectionString"/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="fileName"/>
                </assignStatement>
              </trueStatements>
              <falseStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <variableReferenceExpression name="extension"/>
                      <primitiveExpression value=".xlsx"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <arrayIndexerExpression>
                        <target>
                          <variableReferenceExpression name="connectionString"/>
                        </target>
                        <indices>
                          <primitiveExpression value="Extended Properties"/>
                        </indices>
                      </arrayIndexerExpression>
                      <primitiveExpression value="Excel 12.0 Xml;HDR=YES"/>
                    </assignStatement>
                    <assignStatement>
                      <propertyReferenceExpression name="DataSource">
                        <variableReferenceExpression name="connectionString"/>
                      </propertyReferenceExpression>
                      <variableReferenceExpression name="fileName"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
              </falseStatements>
            </conditionStatement>
          </falseStatements>
        </conditionStatement>
        <variableDeclarationStatement type="OleDbConnection" name="connection">
          <init>
            <objectCreateExpression type="OleDbConnection">
              <parameters>
                <methodInvokeExpression methodName="ToString">
                  <target>
                    <variableReferenceExpression name="connectionString"/>
                  </target>
                </methodInvokeExpression>
              </parameters>
            </objectCreateExpression>
          </init>
        </variableDeclarationStatement>
        <methodInvokeExpression methodName="Open">
          <target>
            <variableReferenceExpression name="connection"/>
          </target>
        </methodInvokeExpression>
        <conditionStatement>
          <condition>
            <methodInvokeExpression methodName="IsNullOrEmpty">
              <target>
                <typeReferenceExpression type="String"/>
              </target>
              <parameters>
                <variableReferenceExpression name="tableName"/>
              </parameters>
            </methodInvokeExpression>
          </condition>
          <trueStatements>
            <variableDeclarationStatement type="DataTable" name="tables">
              <init>
                <methodInvokeExpression methodName="GetSchema">
                  <target>
                    <variableReferenceExpression name="connection"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="Tables"/>
                  </parameters>
                </methodInvokeExpression>
              </init>
            </variableDeclarationStatement>
            <assignStatement>
              <variableReferenceExpression name="tableName"/>
              <methodInvokeExpression methodName="ToString">
                <target>
                  <typeReferenceExpression type="Convert"/>
                </target>
                <parameters>
                  <arrayIndexerExpression>
                    <target>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Rows">
                            <variableReferenceExpression name="tables"/>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="0"/>
                        </indices>
                      </arrayIndexerExpression>
                    </target>
                    <indices>
                      <primitiveExpression value="TABLE_NAME"/>
                    </indices>
                  </arrayIndexerExpression>
                </parameters>
              </methodInvokeExpression>
            </assignStatement>
          </trueStatements>
        </conditionStatement>
        <tryStatement>
          <statements>
            <variableDeclarationStatement type="OleDbCommand" name="command">
              <init>
                <methodInvokeExpression methodName="CreateCommand">
                  <target>
                    <variableReferenceExpression name="connection"/>
                  </target>
                </methodInvokeExpression>
              </init>
            </variableDeclarationStatement>
            <assignStatement>
              <propertyReferenceExpression name="CommandText">
                <variableReferenceExpression name="command"/>
              </propertyReferenceExpression>
              <methodInvokeExpression methodName="Format">
                <target>
                  <typeReferenceExpression type="String"/>
                </target>
                <parameters>
                  <primitiveExpression>
                    <xsl:attribute name="value"><![CDATA[select {0} from [{1}]]]></xsl:attribute>
                  </primitiveExpression>
                  <variableReferenceExpression name="selectClause"/>
                  <variableReferenceExpression name="tableName"/>
                </parameters>
              </methodInvokeExpression>
            </assignStatement>
            <methodReturnStatement>
              <methodInvokeExpression methodName="ExecuteReader">
                <target>
                  <variableReferenceExpression name="command"/>
                </target>
                <parameters>
                  <propertyReferenceExpression name="CloseConnection">
                    <typeReferenceExpression type="CommandBehavior"/>
                  </propertyReferenceExpression>
                </parameters>
              </methodInvokeExpression>
            </methodReturnStatement>
          </statements>
          <catch exceptionType="Exception">
            <methodInvokeExpression methodName="Close">
              <target>
                <variableReferenceExpression name="connection"/>
              </target>
            </methodInvokeExpression>
            <throwExceptionStatement/>
          </catch>
        </tryStatement>
      </statements>
    </memberMethod>
    <!-- method EnumerateFields(IDataReader, ViewPage, ImportMapDictionary, ImportLookupDictionary, List<string>) -->
    <memberMethod name="EnumerateFields">
      <attributes private="true"/>
      <parameters>
        <parameter type="IDataReader" name="reader"/>
        <parameter type="ViewPage" name="page"/>
        <parameter type="ImportMapDictionary" name="map"/>
        <parameter type="ImportLookupDictionary" name="lookups"/>
        <parameter type="List" name="userMapping">
          <typeArguments>
            <typeReference type="System.String"/>
          </typeArguments>
        </parameter>
      </parameters>
      <statements>
        <variableDeclarationStatement type="List" name="mappedFields">
          <typeArguments>
            <typeReference type="String"/>
          </typeArguments>
          <init>
            <objectCreateExpression type="List">
              <typeArguments>
                <typeReference type="System.String"/>
              </typeArguments>
            </objectCreateExpression>
          </init>
        </variableDeclarationStatement>
        <forStatement>
          <variable type="System.Int32" name="i">
            <init>
              <primitiveExpression value="0"/>
            </init>
          </variable>
          <test>
            <binaryOperatorExpression operator="LessThan">
              <variableReferenceExpression name="i"/>
              <propertyReferenceExpression name="FieldCount">
                <argumentReferenceExpression name="reader"/>
              </propertyReferenceExpression>
            </binaryOperatorExpression>
          </test>
          <increment>
            <variableReferenceExpression name="i"/>
          </increment>
          <statements>
            <variableDeclarationStatement type="System.String" name="fieldName">
              <init>
                <methodInvokeExpression methodName="GetName">
                  <target>
                    <argumentReferenceExpression name="reader"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="i"/>
                  </parameters>
                </methodInvokeExpression>
              </init>
            </variableDeclarationStatement>
            <variableDeclarationStatement type="DataField" name="field">
              <init>
                <primitiveExpression value="null"/>
              </init>
            </variableDeclarationStatement>
            <variableDeclarationStatement type="System.Boolean" name="autoDetect">
              <init>
                <primitiveExpression value="true"/>
              </init>
            </variableDeclarationStatement>
            <conditionStatement>
              <condition>
                <binaryOperatorExpression operator="IdentityInequality">
                  <variableReferenceExpression name="userMapping"/>
                  <primitiveExpression value="null"/>
                </binaryOperatorExpression>
              </condition>
              <trueStatements>
                <variableDeclarationStatement type="System.String" name="mappedFieldName">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <argumentReferenceExpression name="userMapping"/>
                      </target>
                      <indices>
                        <variableReferenceExpression name="i"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <variableReferenceExpression name="autoDetect"/>
                  <methodInvokeExpression methodName="IsNullOrEmpty">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <variableReferenceExpression name="mappedFieldName"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <variableReferenceExpression name="autoDetect"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="fieldName"/>
                      <variableReferenceExpression name="mappedFieldName"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
              </trueStatements>
            </conditionStatement>
            <conditionStatement>
              <condition>
                <variableReferenceExpression name="autoDetect"/>
              </condition>
              <trueStatements>
                <foreachStatement>
                  <variable type="DataField" name="f"/>
                  <target>
                    <propertyReferenceExpression name="Fields">
                      <argumentReferenceExpression name="page"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanOr">
                          <methodInvokeExpression methodName="Equals">
                            <target>
                              <variableReferenceExpression name="fieldName"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="HeaderText">
                                <variableReferenceExpression name="f"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="CurrentCultureIgnoreCase">
                                <typeReferenceExpression type="StringComparison"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                          <methodInvokeExpression methodName="Equals">
                            <target>
                              <variableReferenceExpression name="fieldName"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="Label">
                                <variableReferenceExpression name="f"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="CurrentCultureIgnoreCase">
                                <typeReferenceExpression type="StringComparison"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="field"/>
                          <variableReferenceExpression name="f"/>
                        </assignStatement>
                        <breakStatement/>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
              </trueStatements>
            </conditionStatement>
            <conditionStatement>
              <condition>
                <binaryOperatorExpression operator="IdentityEquality">
                  <variableReferenceExpression name="field"/>
                  <primitiveExpression value="null"/>
                </binaryOperatorExpression>
              </condition>
              <trueStatements>
                <assignStatement>
                  <variableReferenceExpression name="field"/>
                  <methodInvokeExpression methodName="FindField">
                    <target>
                      <argumentReferenceExpression name="page"/>
                    </target>
                    <parameters>
                      <variableReferenceExpression name="fieldName"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </trueStatements>
            </conditionStatement>
            <conditionStatement>
              <condition>
                <binaryOperatorExpression operator="IdentityInequality">
                  <variableReferenceExpression name="field"/>
                  <primitiveExpression value="null"/>
                </binaryOperatorExpression>
              </condition>
              <trueStatements>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="AliasName">
                            <variableReferenceExpression name="field"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="field"/>
                      <methodInvokeExpression methodName="FindField">
                        <target>
                          <argumentReferenceExpression name="page"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="AliasName">
                            <variableReferenceExpression name="field"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="ReadOnly">
                        <variableReferenceExpression name="field"/>
                      </propertyReferenceExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="Contains">
                            <target>
                              <variableReferenceExpression name="mappedFields"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="field"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <argumentReferenceExpression name="map"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="i"/>
                            <variableReferenceExpression name="field"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <variableReferenceExpression name="mappedFields"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Name">
                              <variableReferenceExpression name="field"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                  <falseStatements>
                    <foreachStatement>
                      <variable type="DataField" name="f"/>
                      <target>
                        <propertyReferenceExpression name="Fields">
                          <argumentReferenceExpression name="page"/>
                        </propertyReferenceExpression>
                      </target>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="AliasName">
                                <variableReferenceExpression name="f"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="field"/>
                              </propertyReferenceExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <argumentReferenceExpression name="map"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="i"/>
                                <variableReferenceExpression name="field"/>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="lookups"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                                <variableReferenceExpression name="f"/>
                              </parameters>
                            </methodInvokeExpression>
                            <breakStatement/>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                  </falseStatements>
                </conditionStatement>
              </trueStatements>
            </conditionStatement>
          </statements>
        </forStatement>
      </statements>
    </memberMethod>
    <!-- method ResolveLookups(ImportLookupDictionary) -->
    <memberMethod name="ResolveLookups">
      <attributes public="true" final="true"/>
      <parameters>
        <parameter type="ImportLookupDictionary" name="lookups"/>
      </parameters>
      <statements>
        <foreachStatement>
          <variable type="System.String" name="fieldName"/>
          <target>
            <propertyReferenceExpression name="Keys">
              <argumentReferenceExpression name="lookups"/>
            </propertyReferenceExpression>
          </target>
          <statements>
            <variableDeclarationStatement type="DataField" name="lookupField">
              <init>
                <arrayIndexerExpression>
                  <target>
                    <variableReferenceExpression name="lookups"/>
                  </target>
                  <indices>
                    <variableReferenceExpression name="fieldName"/>
                  </indices>
                </arrayIndexerExpression>
              </init>
            </variableDeclarationStatement>
            <conditionStatement>
              <condition>
                <binaryOperatorExpression operator="BooleanAnd">
                  <binaryOperatorExpression operator="ValueEquality">
                    <propertyReferenceExpression name="Count">
                      <propertyReferenceExpression name="Items">
                        <variableReferenceExpression name="lookupField"/>
                      </propertyReferenceExpression>
                    </propertyReferenceExpression>
                    <primitiveExpression value="0"/>
                  </binaryOperatorExpression>
                  <binaryOperatorExpression operator="BooleanOr">
                    <methodInvokeExpression methodName="IsNullOrEmpty">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="ItemsDataValueField">
                          <variableReferenceExpression name="lookupField"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="IsNullOrEmpty">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="ItemsDataTextField">
                          <variableReferenceExpression name="lookupField"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </binaryOperatorExpression>
                </binaryOperatorExpression>
              </condition>
              <trueStatements>
                <variableDeclarationStatement type="PageRequest" name="lookupRequest">
                  <init>
                    <objectCreateExpression type="PageRequest"/>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Controller">
                    <variableReferenceExpression name="lookupRequest"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="ItemsDataController">
                    <variableReferenceExpression name="lookupField"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="View">
                    <variableReferenceExpression name="lookupRequest"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="ItemsDataView">
                    <variableReferenceExpression name="lookupField"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="RequiresMetaData">
                    <variableReferenceExpression name="lookupRequest"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="true"/>
                </assignStatement>
                <variableDeclarationStatement type="ViewPage" name="lp">
                  <init>
                    <methodInvokeExpression methodName="GetPage">
                      <target>
                        <methodInvokeExpression methodName="CreateDataController">
                          <target>
                            <typeReferenceExpression type="ControllerFactory"/>
                          </target>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Controller">
                          <variableReferenceExpression name="lookupRequest"/>
                        </propertyReferenceExpression>
                        <propertyReferenceExpression name="View">
                          <variableReferenceExpression name="lookupRequest"/>
                        </propertyReferenceExpression>
                        <variableReferenceExpression name="lookupRequest"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="IsNullOrEmpty">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="ItemsDataValueField">
                          <variableReferenceExpression name="lookupField"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <foreachStatement>
                      <variable type="DataField" name="f"/>
                      <target>
                        <propertyReferenceExpression name="Fields">
                          <variableReferenceExpression name="lp"/>
                        </propertyReferenceExpression>
                      </target>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <propertyReferenceExpression name="IsPrimaryKey">
                              <variableReferenceExpression name="f"/>
                            </propertyReferenceExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <propertyReferenceExpression name="ItemsDataValueField">
                                <variableReferenceExpression name="lookupField"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="f"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                            <breakStatement/>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="IsNullOrEmpty">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="ItemsDataTextField">
                          <variableReferenceExpression name="lookupField"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <foreachStatement>
                      <variable type="DataField" name="f"/>
                      <target>
                        <propertyReferenceExpression name="Fields">
                          <variableReferenceExpression name="lp"/>
                        </propertyReferenceExpression>
                      </target>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <binaryOperatorExpression operator="BooleanAnd">
                                <unaryOperatorExpression operator="Not">
                                  <propertyReferenceExpression name="IsPrimaryKey">
                                    <variableReferenceExpression name="f"/>
                                  </propertyReferenceExpression>
                                </unaryOperatorExpression>
                                <unaryOperatorExpression operator="Not">
                                  <propertyReferenceExpression name="Hidden">
                                    <variableReferenceExpression name="f"/>
                                  </propertyReferenceExpression>
                                </unaryOperatorExpression>
                              </binaryOperatorExpression>
                              <binaryOperatorExpression operator="BooleanOr">
                                <unaryOperatorExpression operator="Not">
                                  <propertyReferenceExpression name="AllowNulls">
                                    <variableReferenceExpression name="f"/>
                                  </propertyReferenceExpression>
                                </unaryOperatorExpression>
                                <binaryOperatorExpression operator="ValueEquality">
                                  <propertyReferenceExpression name="Type">
                                    <variableReferenceExpression name="f"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="String"/>
                                </binaryOperatorExpression>
                              </binaryOperatorExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <propertyReferenceExpression name="ItemsDataTextField">
                                <variableReferenceExpression name="lookupField"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="f"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                            <breakStatement/>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                  </trueStatements>
                </conditionStatement>
              </trueStatements>
            </conditionStatement>
          </statements>
        </foreachStatement>
      </statements>
    </memberMethod>
    <!-- method BeforeProcess(string, string, string, string, List<string) -->
    <memberMethod name="BeforeProcess">
      <attributes family="true"/>
      <parameters>
        <parameter type="System.String" name="fileName"/>
        <parameter type="System.String" name="controller"/>
        <parameter type="System.String" name="view"/>
        <parameter type="System.String" name="notify"/>
        <parameter type="List" name="userMapping">
          <typeArguments>
            <typeReference type="System.String"/>
          </typeArguments>
        </parameter>
      </parameters>
      <statements>
      </statements>
    </memberMethod>
    <!-- method AfterProcess(string, string, string, string, List<string) -->
    <memberMethod name="AfterProcess">
      <attributes family="true"/>
      <parameters>
        <parameter type="System.String" name="fileName"/>
        <parameter type="System.String" name="controller"/>
        <parameter type="System.String" name="view"/>
        <parameter type="System.String" name="notify"/>
        <parameter type="List" name="userMapping">
          <typeArguments>
            <typeReference type="System.String"/>
          </typeArguments>
        </parameter>
      </parameters>
      <statements>
      </statements>
    </memberMethod>
    <!-- method Process(string, string, string, string, List<string) -->
    <memberMethod name="Process">
      <attributes public="true"/>
      <parameters>
        <parameter type="System.String" name="fileName"/>
        <parameter type="System.String" name="controller"/>
        <parameter type="System.String" name="view"/>
        <parameter type="System.String" name="notify"/>
        <parameter type="List" name="userMapping">
          <typeArguments>
            <typeReference type="System.String"/>
          </typeArguments>
        </parameter>
      </parameters>
      <statements>
        <methodInvokeExpression methodName="BeforeProcess">
          <parameters>
            <argumentReferenceExpression name="fileName"/>
            <argumentReferenceExpression name="controller"/>
            <argumentReferenceExpression name="view"/>
            <argumentReferenceExpression name="notify"/>
            <argumentReferenceExpression name="userMapping"/>
          </parameters>
        </methodInvokeExpression>
        <variableDeclarationStatement type="System.String" name="logFileName">
          <init>
            <methodInvokeExpression methodName="GetTempFileName">
              <target>
                <typeReferenceExpression type="Path"/>
              </target>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="StreamWriter" name="log">
          <init>
            <methodInvokeExpression methodName="CreateText">
              <target>
                <typeReferenceExpression type="File"/>
              </target>
              <parameters>
                <variableReferenceExpression name="logFileName"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <methodInvokeExpression methodName="WriteLine">
          <target>
            <variableReferenceExpression name="log"/>
          </target>
          <parameters>
            <primitiveExpression value="{{0:s}} Import process started."/>
            <propertyReferenceExpression name="Now">
              <typeReferenceExpression type="DateTime"/>
            </propertyReferenceExpression>
          </parameters>
        </methodInvokeExpression>
        <comment>retrieve metadata</comment>
        <variableDeclarationStatement type="PageRequest" name="request">
          <init>
            <objectCreateExpression type="PageRequest"/>
          </init>
        </variableDeclarationStatement>
        <assignStatement>
          <propertyReferenceExpression name="Controller">
            <variableReferenceExpression name="request"/>
          </propertyReferenceExpression>
          <argumentReferenceExpression name="controller"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="View">
            <variableReferenceExpression name="request"/>
          </propertyReferenceExpression>
          <argumentReferenceExpression name="view"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="RequiresMetaData">
            <variableReferenceExpression name="request"/>
          </propertyReferenceExpression>
          <primitiveExpression value="true"/>
        </assignStatement>
        <variableDeclarationStatement type="ViewPage" name="page">
          <init>
            <methodInvokeExpression methodName="GetPage">
              <target>
                <methodInvokeExpression methodName="CreateDataController">
                  <target>
                    <typeReferenceExpression type="ControllerFactory"/>
                  </target>
                </methodInvokeExpression>
              </target>
              <parameters>
                <argumentReferenceExpression name="controller"/>
                <argumentReferenceExpression name="view"/>
                <variableReferenceExpression name="request"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <comment>open data reader and enumerate fields</comment>
        <variableDeclarationStatement type="IDataReader" name="reader">
          <init>
            <methodInvokeExpression methodName="OpenRead">
              <parameters>
                <variableReferenceExpression name="fileName"/>
                <primitiveExpression value="*"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="ImportMapDictionary" name="map">
          <init>
            <objectCreateExpression type="ImportMapDictionary"/>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="ImportLookupDictionary" name="lookups">
          <init>
            <objectCreateExpression type="ImportLookupDictionary"/>
          </init>
        </variableDeclarationStatement>
        <methodInvokeExpression methodName="EnumerateFields">
          <parameters>
            <variableReferenceExpression name="reader"/>
            <variableReferenceExpression name="page"/>
            <variableReferenceExpression name="map"/>
            <variableReferenceExpression name="lookups"/>
            <variableReferenceExpression name="userMapping"/>
          </parameters>
        </methodInvokeExpression>
        <comment>resolve lookup data value field and data text fields</comment>
        <methodInvokeExpression methodName="ResolveLookups">
          <parameters>
            <variableReferenceExpression name="lookups"/>
          </parameters>
        </methodInvokeExpression>
        <comment>insert records from the file</comment>
        <variableDeclarationStatement type="System.Int32" name="recordCount">
          <init>
            <primitiveExpression value="0"/>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="System.Int32" name="errorCount">
          <init>
            <primitiveExpression value="0"/>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="NumberFormatInfo" name="nfi">
          <init>
            <propertyReferenceExpression name="NumberFormat">
              <propertyReferenceExpression name="CurrentCulture">
                <typeReferenceExpression type="CultureInfo"/>
              </propertyReferenceExpression>
            </propertyReferenceExpression>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="Regex" name="numberCleanupRegex">
          <init>
            <objectCreateExpression type="Regex">
              <parameters>
                <methodInvokeExpression methodName="Format">
                  <target>
                    <typeReferenceExpression type="String"/>
                  </target>
                  <parameters>
                    <primitiveExpression>
                      <xsl:attribute name="value"><![CDATA[[^\d\{0}\{1}\{2}]]]></xsl:attribute>
                    </primitiveExpression>
                    <propertyReferenceExpression name="CurrencyDecimalSeparator">
                      <variableReferenceExpression name="nfi"/>
                    </propertyReferenceExpression>
                    <propertyReferenceExpression name="NegativeSign">
                      <variableReferenceExpression name="nfi"/>
                    </propertyReferenceExpression>
                    <propertyReferenceExpression name="NumberDecimalSeparator">
                      <variableReferenceExpression name="nfi"/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
              </parameters>
            </objectCreateExpression>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="SortedDictionary" name="externalFilterValues">
          <typeArguments>
            <typeReference type="System.String"/>
            <typeReference type="System.Object"/>
          </typeArguments>
          <init>
            <objectCreateExpression type="SortedDictionary">
              <typeArguments>
                <typeReference type="System.String"/>
                <typeReference type="System.Object"/>
              </typeArguments>
            </objectCreateExpression>
          </init>
        </variableDeclarationStatement>
        <conditionStatement>
          <condition>
            <binaryOperatorExpression operator="IdentityInequality">
              <propertyReferenceExpression name="ExternalFilter">
                <propertyReferenceExpression name="Current">
                  <typeReferenceExpression type="ActionArgs"/>
                </propertyReferenceExpression>
              </propertyReferenceExpression>
              <primitiveExpression value="null"/>
            </binaryOperatorExpression>
          </condition>
          <trueStatements>
            <foreachStatement>
              <variable type="FieldValue" name="fvo"/>
              <target>
                <propertyReferenceExpression name="ExternalFilter">
                  <propertyReferenceExpression name="Current">
                    <typeReferenceExpression type="ActionArgs"/>
                  </propertyReferenceExpression>
                </propertyReferenceExpression>
              </target>
              <statements>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <variableReferenceExpression name="externalFilterValues"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="Name">
                        <variableReferenceExpression name="fvo"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="fvo"/>
                  </propertyReferenceExpression>
                </assignStatement>
              </statements>
            </foreachStatement>
          </trueStatements>
        </conditionStatement>
        <comment>prepare default values</comment>
        <variableDeclarationStatement type="PageRequest" name="newRequest">
          <init>
            <objectCreateExpression type="PageRequest"/>
          </init>
        </variableDeclarationStatement>
        <assignStatement>
          <propertyReferenceExpression name="RequiresMetaData">
            <variableReferenceExpression name="newRequest"/>
          </propertyReferenceExpression>
          <primitiveExpression value="true"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="Inserting">
            <variableReferenceExpression name="newRequest"/>
          </propertyReferenceExpression>
          <primitiveExpression value="true"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="LastCommandName">
            <variableReferenceExpression name="newRequest"/>
          </propertyReferenceExpression>
          <primitiveExpression value="New"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="LastCommandArgument">
            <variableReferenceExpression name="newRequest"/>
          </propertyReferenceExpression>
          <argumentReferenceExpression name="view"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="Controller">
            <variableReferenceExpression name="newRequest"/>
          </propertyReferenceExpression>
          <argumentReferenceExpression name="controller"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="View">
            <variableReferenceExpression name="newRequest"/>
          </propertyReferenceExpression>
          <argumentReferenceExpression name="view"/>
        </assignStatement>
        <variableDeclarationStatement type="ViewPage" name="newPage">
          <init>
            <methodInvokeExpression methodName="GetPage">
              <target>
                <methodInvokeExpression methodName="CreateDataController">
                  <target>
                    <typeReferenceExpression type="ControllerFactory"/>
                  </target>
                </methodInvokeExpression>
              </target>
              <parameters>
                <argumentReferenceExpression name="controller"/>
                <argumentReferenceExpression name="view"/>
                <variableReferenceExpression name="newRequest"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="SortedDictionary" name="defaultValues">
          <typeArguments>
            <typeReference type="System.String"/>
            <typeReference type="System.Object"/>
          </typeArguments>
          <init>
            <objectCreateExpression type="SortedDictionary">
              <typeArguments>
                <typeReference type="System.String"/>
                <typeReference type="System.Object"/>
              </typeArguments>
            </objectCreateExpression>
          </init>
        </variableDeclarationStatement>
        <forStatement>
          <variable type="System.Int32" name="i">
            <init>
              <primitiveExpression value="0"/>
            </init>
          </variable>
          <test>
            <binaryOperatorExpression operator="LessThan">
              <variableReferenceExpression name="i"/>
              <propertyReferenceExpression name="Count">
                <propertyReferenceExpression name="Fields">
                  <variableReferenceExpression name="newPage"/>
                </propertyReferenceExpression>
              </propertyReferenceExpression>
            </binaryOperatorExpression>
          </test>
          <increment>
            <variableReferenceExpression name="i"/>
          </increment>
          <statements>
            <assignStatement>
              <arrayIndexerExpression>
                <target>
                  <variableReferenceExpression name="defaultValues"/>
                </target>
                <indices>
                  <propertyReferenceExpression name="Name">
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Fields">
                          <variableReferenceExpression name="newPage"/>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <variableReferenceExpression name="i"/>
                      </indices>
                    </arrayIndexerExpression>
                  </propertyReferenceExpression>
                </indices>
              </arrayIndexerExpression>
              <arrayIndexerExpression>
                <target>
                  <propertyReferenceExpression name="NewRow">
                    <variableReferenceExpression name="newPage"/>
                  </propertyReferenceExpression>
                </target>
                <indices>
                  <variableReferenceExpression name="i"/>
                </indices>
              </arrayIndexerExpression>
            </assignStatement>
          </statements>
        </forStatement>
        <comment>process data rows</comment>
        <whileStatement>
          <test>
            <methodInvokeExpression methodName="Read">
              <target>
                <variableReferenceExpression name="reader"/>
              </target>
            </methodInvokeExpression>
          </test>
          <statements>
            <variableDeclarationStatement type="ActionArgs" name="args">
              <init>
                <objectCreateExpression type="ActionArgs"/>
              </init>
            </variableDeclarationStatement>
            <assignStatement>
              <propertyReferenceExpression name="Controller">
                <variableReferenceExpression name="args"/>
              </propertyReferenceExpression>
              <argumentReferenceExpression name="controller"/>
            </assignStatement>
            <assignStatement>
              <propertyReferenceExpression name="View">
                <variableReferenceExpression name="args"/>
              </propertyReferenceExpression>
              <argumentReferenceExpression name="view"/>
            </assignStatement>
            <assignStatement>
              <propertyReferenceExpression name="LastCommandName">
                <variableReferenceExpression name="args"/>
              </propertyReferenceExpression>
              <primitiveExpression value="New"/>
            </assignStatement>
            <assignStatement>
              <propertyReferenceExpression name="CommandName">
                <variableReferenceExpression name="args"/>
              </propertyReferenceExpression>
              <primitiveExpression value="Insert"/>
            </assignStatement>
            <variableDeclarationStatement type="List" name="values">
              <typeArguments>
                <typeReference type="FieldValue"/>
              </typeArguments>
              <init>
                <objectCreateExpression type="List">
                  <typeArguments>
                    <typeReference type="FieldValue"/>
                  </typeArguments>
                </objectCreateExpression>
              </init>
            </variableDeclarationStatement>
            <variableDeclarationStatement type="SortedDictionary" name="valueDictionary">
              <typeArguments>
                <typeReference type="System.String"/>
                <typeReference type="System.String"/>
              </typeArguments>
              <init>
                <objectCreateExpression type="SortedDictionary">
                  <typeArguments>
                    <typeReference type="System.String"/>
                    <typeReference type="System.String"/>
                  </typeArguments>
                </objectCreateExpression>
              </init>
            </variableDeclarationStatement>
            <foreachStatement>
              <variable type="System.Int32" name="index"/>
              <target>
                <propertyReferenceExpression name="Keys">
                  <variableReferenceExpression name="map"/>
                </propertyReferenceExpression>
              </target>
              <statements>
                <variableDeclarationStatement type="DataField" name="field">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <argumentReferenceExpression name="map"/>
                      </target>
                      <indices>
                        <variableReferenceExpression name="index"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Object" name="v">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <variableReferenceExpression name="reader"/>
                      </target>
                      <indices>
                        <variableReferenceExpression name="index"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Equals">
                      <target>
                        <stringEmptyExpression/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="v"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="v"/>
                      <propertyReferenceExpression name="Value">
                        <typeReferenceExpression type="DBNull"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Equals">
                      <target>
                        <propertyReferenceExpression name="Value">
                          <typeReferenceExpression type="DBNull"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="v"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="v"/>
                      <arrayIndexerExpression>
                        <target>
                          <variableReferenceExpression name="defaultValues"/>
                        </target>
                        <indices>
                          <propertyReferenceExpression name="Name">
                            <variableReferenceExpression name="field"/>
                          </propertyReferenceExpression>
                        </indices>
                      </arrayIndexerExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <binaryOperatorExpression operator="ValueInequality">
                            <propertyReferenceExpression name="Type">
                              <variableReferenceExpression name="field"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="String"/>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="IsTypeOf">
                            <variableReferenceExpression name="v"/>
                            <typeReferenceExpression type="System.String"/>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="System.String" name="s">
                          <init>
                            <castExpression targetType="System.String">
                              <variableReferenceExpression name="v"/>
                            </castExpression>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="Type">
                                <variableReferenceExpression name="field"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="Boolean"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="v"/>
                              <methodInvokeExpression methodName="ToLower">
                                <target>
                                  <variableReferenceExpression name="s"/>
                                </target>
                              </methodInvokeExpression>
                            </assignStatement>
                          </trueStatements>
                          <falseStatements>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanAnd">
                                  <unaryOperatorExpression operator="Not">
                                    <methodInvokeExpression methodName="StartsWith">
                                      <target>
                                        <propertyReferenceExpression name="Type">
                                          <variableReferenceExpression name="field"/>
                                        </propertyReferenceExpression>
                                      </target>
                                      <parameters>
                                        <primitiveExpression value="Date"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </unaryOperatorExpression>
                                  <binaryOperatorExpression operator="ValueInequality">
                                    <propertyReferenceExpression name="Type">
                                      <variableReferenceExpression name="field"/>
                                    </propertyReferenceExpression>
                                    <primitiveExpression value="Time"/>
                                  </binaryOperatorExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <variableReferenceExpression name="v"/>
                                  <methodInvokeExpression methodName="Replace">
                                    <target>
                                      <variableReferenceExpression name="numberCleanupRegex"/>
                                    </target>
                                    <parameters>
                                      <variableReferenceExpression name="s"/>
                                      <propertyReferenceExpression name="Empty">
                                        <typeReferenceExpression type="String"/>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </assignStatement>
                              </trueStatements>
                            </conditionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <variableReferenceExpression name="v"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="DataField" name="lookupField">
                      <init>
                        <primitiveExpression value="null"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="TryGetValue">
                          <target>
                            <argumentReferenceExpression name="lookups"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Name">
                              <variableReferenceExpression name="field"/>
                            </propertyReferenceExpression>
                            <directionExpression direction="Out">
                              <variableReferenceExpression name="lookupField"/>
                            </directionExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="GreaterThan">
                              <propertyReferenceExpression name="Count">
                                <propertyReferenceExpression name="Items">
                                  <variableReferenceExpression name="lookupField"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                              <primitiveExpression value="0"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <comment>copy static values</comment>
                            <foreachStatement>
                              <variable type="System.Object[]" name="item"/>
                              <target>
                                <propertyReferenceExpression name="Items">
                                  <variableReferenceExpression name="lookupField"/>
                                </propertyReferenceExpression>
                              </target>
                              <statements>
                                <conditionStatement>
                                  <condition>
                                    <methodInvokeExpression methodName="Equals">
                                      <target>
                                        <methodInvokeExpression methodName="ToString">
                                          <target>
                                            <typeReferenceExpression type="Convert"/>
                                          </target>
                                          <parameters>
                                            <arrayIndexerExpression>
                                              <target>
                                                <variableReferenceExpression name="item"/>
                                              </target>
                                              <indices>
                                                <primitiveExpression value="1"/>
                                              </indices>
                                            </arrayIndexerExpression>
                                          </parameters>
                                        </methodInvokeExpression>
                                      </target>
                                      <parameters>
                                        <methodInvokeExpression methodName="ToString">
                                          <target>
                                            <typeReferenceExpression type="Convert"/>
                                          </target>
                                          <parameters>
                                            <variableReferenceExpression name="v"/>
                                          </parameters>
                                        </methodInvokeExpression>
                                        <propertyReferenceExpression name="CurrentCultureIgnoreCase">
                                          <typeReferenceExpression type="StringComparison"/>
                                        </propertyReferenceExpression>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </condition>
                                  <trueStatements>
                                    <methodInvokeExpression methodName="Add">
                                      <target>
                                        <variableReferenceExpression name="values"/>
                                      </target>
                                      <parameters>
                                        <objectCreateExpression type="FieldValue">
                                          <parameters>
                                            <propertyReferenceExpression name="Name">
                                              <variableReferenceExpression name="lookupField"/>
                                            </propertyReferenceExpression>
                                            <arrayIndexerExpression>
                                              <target>
                                                <variableReferenceExpression name="item"/>
                                              </target>
                                              <indices>
                                                <primitiveExpression value="0"/>
                                              </indices>
                                            </arrayIndexerExpression>
                                          </parameters>
                                        </objectCreateExpression>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </trueStatements>
                                </conditionStatement>
                              </statements>
                            </foreachStatement>
                          </trueStatements>
                          <falseStatements>
                            <variableDeclarationStatement type="PageRequest" name="lookupRequest">
                              <init>
                                <objectCreateExpression type="PageRequest"/>
                              </init>
                            </variableDeclarationStatement>
                            <assignStatement>
                              <propertyReferenceExpression name="Controller">
                                <variableReferenceExpression name="lookupRequest"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="ItemsDataController">
                                <variableReferenceExpression name="lookupField"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                            <assignStatement>
                              <propertyReferenceExpression name="View">
                                <variableReferenceExpression name="lookupRequest"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="ItemsDataView">
                                <variableReferenceExpression name="lookupField"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                            <assignStatement>
                              <propertyReferenceExpression name="RequiresMetaData">
                                <variableReferenceExpression name="lookupRequest"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                            <assignStatement>
                              <propertyReferenceExpression name="PageSize">
                                <variableReferenceExpression name="lookupRequest"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="1"/>
                            </assignStatement>
                            <assignStatement>
                              <propertyReferenceExpression name="Filter">
                                <variableReferenceExpression name="lookupRequest"/>
                              </propertyReferenceExpression>
                              <arrayCreateExpression>
                                <createType type="System.String"/>
                                <initializers>
                                  <methodInvokeExpression methodName="Format">
                                    <target>
                                      <typeReferenceExpression type="String"/>
                                    </target>
                                    <parameters>
                                      <primitiveExpression>
                                        <xsl:attribute name="value"><![CDATA[{0}:={1}{2}]]></xsl:attribute>
                                      </primitiveExpression>
                                      <propertyReferenceExpression name="ItemsDataTextField">
                                        <variableReferenceExpression name="lookupField"/>
                                      </propertyReferenceExpression>
                                      <variableReferenceExpression name="v"/>
                                      <methodInvokeExpression methodName="ToChar">
                                        <target>
                                          <typeReferenceExpression type="Convert"/>
                                        </target>
                                        <parameters>
                                          <primitiveExpression value="0"/>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </initializers>
                              </arrayCreateExpression>
                            </assignStatement>
                            <variableDeclarationStatement type="ViewPage" name="vp">
                              <init>
                                <methodInvokeExpression methodName="GetPage">
                                  <target>
                                    <methodInvokeExpression methodName="CreateDataController">
                                      <target>
                                        <typeReferenceExpression type="ControllerFactory"/>
                                      </target>
                                    </methodInvokeExpression>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="Controller">
                                      <variableReferenceExpression name="lookupRequest"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="View">
                                      <variableReferenceExpression name="lookupRequest"/>
                                    </propertyReferenceExpression>
                                    <variableReferenceExpression name="lookupRequest"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </init>
                            </variableDeclarationStatement>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="GreaterThan">
                                  <propertyReferenceExpression name="Count">
                                    <propertyReferenceExpression name="Rows">
                                      <variableReferenceExpression name="vp"/>
                                    </propertyReferenceExpression>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="0"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="values"/>
                                  </target>
                                  <parameters>
                                    <objectCreateExpression type="FieldValue">
                                      <parameters>
                                        <propertyReferenceExpression name="Name">
                                          <variableReferenceExpression name="lookupField"/>
                                        </propertyReferenceExpression>
                                        <arrayIndexerExpression>
                                          <target>
                                            <arrayIndexerExpression>
                                              <target>
                                                <propertyReferenceExpression name="Rows">
                                                  <variableReferenceExpression name="vp"/>
                                                </propertyReferenceExpression>
                                              </target>
                                              <indices>
                                                <primitiveExpression value="0"/>
                                              </indices>
                                            </arrayIndexerExpression>
                                          </target>
                                          <indices>
                                            <methodInvokeExpression methodName="IndexOf">
                                              <target>
                                                <propertyReferenceExpression name="Fields">
                                                  <variableReferenceExpression name="vp"/>
                                                </propertyReferenceExpression>
                                              </target>
                                              <parameters>
                                                <methodInvokeExpression methodName="FindField">
                                                  <target>
                                                    <variableReferenceExpression name="vp"/>
                                                  </target>
                                                  <parameters>
                                                    <propertyReferenceExpression name="ItemsDataValueField">
                                                      <variableReferenceExpression name="lookupField"/>
                                                    </propertyReferenceExpression>
                                                  </parameters>
                                                </methodInvokeExpression>
                                              </parameters>
                                            </methodInvokeExpression>
                                          </indices>
                                        </arrayIndexerExpression>
                                      </parameters>
                                    </objectCreateExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                      <falseStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <variableReferenceExpression name="values"/>
                          </target>
                          <parameters>
                            <objectCreateExpression type="FieldValue">
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                                <variableReferenceExpression name="v"/>
                              </parameters>
                            </objectCreateExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </falseStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="GreaterThan">
                          <propertyReferenceExpression name="Count">
                            <variableReferenceExpression name="values"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="FieldValue" name="lastValue">
                          <init>
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="values"/>
                              </target>
                              <indices>
                                <binaryOperatorExpression operator="Subtract">
                                  <propertyReferenceExpression name="Count">
                                    <variableReferenceExpression name="values"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="1"/>
                                </binaryOperatorExpression>
                              </indices>
                            </arrayIndexerExpression>
                          </init>
                        </variableDeclarationStatement>
                        <assignStatement>
                          <arrayIndexerExpression>
                            <target>
                              <variableReferenceExpression name="valueDictionary"/>
                            </target>
                            <indices>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="lastValue"/>
                              </propertyReferenceExpression>
                            </indices>
                          </arrayIndexerExpression>
                          <propertyReferenceExpression name="Empty">
                            <typeReferenceExpression type="String"/>
                          </propertyReferenceExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </foreachStatement>
            <assignStatement>
              <variableReferenceExpression name="recordCount"/>
              <binaryOperatorExpression operator="Add">
                <variableReferenceExpression name="recordCount"/>
                <primitiveExpression value="1"/>
              </binaryOperatorExpression>
            </assignStatement>
            <conditionStatement>
              <condition>
                <binaryOperatorExpression operator="GreaterThan">
                  <propertyReferenceExpression name="Count">
                    <variableReferenceExpression name="values"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="0"/>
                </binaryOperatorExpression>
              </condition>
              <trueStatements>
                <foreachStatement>
                  <variable type="DataField" name="field"/>
                  <target>
                    <propertyReferenceExpression name="Fields">
                      <variableReferenceExpression name="page"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="ContainsKey">
                            <target>
                              <variableReferenceExpression name="valueDictionary"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="field"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="FieldValue" name="missingField">
                          <init>
                            <objectCreateExpression type="FieldValue">
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </init>
                        </variableDeclarationStatement>
                        <variableDeclarationStatement type="System.Object" name="missingValue">
                          <init>
                            <primitiveExpression value="null"/>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="TryGetValue">
                              <target>
                                <variableReferenceExpression name="externalFilterValues"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="missingField"/>
                                </propertyReferenceExpression>
                                <directionExpression direction="Out">
                                  <variableReferenceExpression name="missingValue"/>
                                </directionExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <propertyReferenceExpression name="NewValue">
                                <variableReferenceExpression name="missingField"/>
                              </propertyReferenceExpression>
                              <variableReferenceExpression name="missingValue"/>
                            </assignStatement>
                            <assignStatement>
                              <propertyReferenceExpression name="Modified">
                                <variableReferenceExpression name="missingField"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <variableReferenceExpression name="values"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="missingField"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Values">
                    <variableReferenceExpression name="args"/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="ToArray">
                    <target>
                      <variableReferenceExpression name="values"/>
                    </target>
                  </methodInvokeExpression>
                </assignStatement>
                <variableDeclarationStatement type="ActionResult" name="r">
                  <init>
                    <methodInvokeExpression methodName="Execute">
                      <target>
                        <methodInvokeExpression methodName="CreateDataController">
                          <target>
                            <typeReferenceExpression type="ControllerFactory"/>
                          </target>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="controller"/>
                        <argumentReferenceExpression name="view"/>
                        <variableReferenceExpression name="args"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="GreaterThan">
                      <propertyReferenceExpression name="Count">
                        <propertyReferenceExpression name="Errors">
                          <variableReferenceExpression name="r"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="HandleError">
                            <parameters>
                              <variableReferenceExpression name="r"/>
                              <variableReferenceExpression name="args"/>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="WriteLine">
                          <target>
                            <variableReferenceExpression name="log"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="{{0:s}} Error importing record #{{1}}."/>
                            <propertyReferenceExpression name="Now">
                              <typeReferenceExpression type="DateTime"/>
                            </propertyReferenceExpression>
                            <variableReferenceExpression name="recordCount"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="WriteLine">
                          <target>
                            <variableReferenceExpression name="log"/>
                          </target>
                        </methodInvokeExpression>
                        <foreachStatement>
                          <variable type="System.String" name="s"/>
                          <target>
                            <propertyReferenceExpression name="Errors">
                              <variableReferenceExpression name="r"/>
                            </propertyReferenceExpression>
                          </target>
                          <statements>
                            <methodInvokeExpression methodName="WriteLine">
                              <target>
                                <variableReferenceExpression name="log"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="s"/>
                              </parameters>
                            </methodInvokeExpression>
                          </statements>
                        </foreachStatement>
                        <foreachStatement>
                          <variable type="FieldValue" name="v"/>
                          <target>
                            <variableReferenceExpression name="values"/>
                          </target>
                          <statements>
                            <conditionStatement>
                              <condition>
                                <propertyReferenceExpression name="Modified">
                                  <variableReferenceExpression name="v"/>
                                </propertyReferenceExpression>
                              </condition>
                              <trueStatements>
                                <methodInvokeExpression methodName="WriteLine">
                                  <target>
                                    <variableReferenceExpression name="log"/>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="{{0}}={{1}};"/>
                                    <propertyReferenceExpression name="Name">
                                      <variableReferenceExpression name="v"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="Value">
                                      <variableReferenceExpression name="v"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                          </statements>
                        </foreachStatement>
                        <methodInvokeExpression methodName="WriteLine">
                          <target>
                            <variableReferenceExpression name="log"/>
                          </target>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="errorCount"/>
                          <binaryOperatorExpression operator="Add">
                            <variableReferenceExpression name="errorCount"/>
                            <primitiveExpression value="1"/>
                          </binaryOperatorExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
              </trueStatements>
              <falseStatements>
                <methodInvokeExpression methodName="WriteLine">
                  <target>
                    <variableReferenceExpression name="log"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="{{0:s}} Record #{1} has been ignored."/>
                    <propertyReferenceExpression name="Now">
                      <typeReferenceExpression type="DateTime"/>
                    </propertyReferenceExpression>
                    <variableReferenceExpression name="recordCount"/>
                  </parameters>
                </methodInvokeExpression>
                <assignStatement>
                  <variableReferenceExpression name="errorCount"/>
                  <binaryOperatorExpression operator="Add">
                    <variableReferenceExpression name="errorCount"/>
                    <primitiveExpression value="1"/>
                  </binaryOperatorExpression>
                </assignStatement>
              </falseStatements>
            </conditionStatement>
          </statements>
        </whileStatement>
        <methodInvokeExpression methodName="Close">
          <target>
            <variableReferenceExpression name="reader"/>
          </target>
        </methodInvokeExpression>
        <methodInvokeExpression methodName="WriteLine">
          <target>
            <variableReferenceExpression name="log"/>
          </target>
          <parameters>
            <primitiveExpression value="{{0:s}} Processed {{1}} records. Detected {{2}} errors."/>
            <propertyReferenceExpression name="Now">
              <typeReferenceExpression type="DateTime"/>
            </propertyReferenceExpression>
            <variableReferenceExpression name="recordCount"/>
            <variableReferenceExpression name="errorCount"/>
          </parameters>
        </methodInvokeExpression>
        <methodInvokeExpression methodName="Close">
          <target>
            <variableReferenceExpression name="log"/>
          </target>
        </methodInvokeExpression>
        <conditionStatement>
          <condition>
            <unaryOperatorExpression operator="Not">
              <methodInvokeExpression methodName="IsNullOrEmpty">
                <target>
                  <typeReferenceExpression type="String"/>
                </target>
                <parameters>
                  <argumentReferenceExpression name="notify"/>
                </parameters>
              </methodInvokeExpression>
            </unaryOperatorExpression>
          </condition>
          <trueStatements>
            <methodInvokeExpression methodName="ReportErrors">
              <parameters>
                <argumentReferenceExpression name="controller"/>
                <argumentReferenceExpression name="notify"/>
                <variableReferenceExpression name="logFileName"/>
              </parameters>
            </methodInvokeExpression>
          </trueStatements>
        </conditionStatement>
        <methodInvokeExpression methodName="Delete">
          <target>
            <typeReferenceExpression type="File"/>
          </target>
          <parameters>
            <variableReferenceExpression name="logFileName"/>
          </parameters>
        </methodInvokeExpression>
        <methodInvokeExpression methodName="AfterProcess">
          <parameters>
            <argumentReferenceExpression name="fileName"/>
            <argumentReferenceExpression name="controller"/>
            <argumentReferenceExpression name="view"/>
            <argumentReferenceExpression name="notify"/>
            <argumentReferenceExpression name="userMapping"/>
          </parameters>
        </methodInvokeExpression>
      </statements>
    </memberMethod>
    <!-- method ReportErrors(string, string, string)-->
    <memberMethod name="ReportErrors">
      <attributes family="true"/>
      <parameters>
        <parameter type="System.String" name="controller"/>
        <parameter type="System.String" name="recipients"/>
        <parameter type="System.String" name="logFileName"/>
      </parameters>
      <statements>
        <variableDeclarationStatement type="System.String[]" name="recipientsList">
          <init>
            <methodInvokeExpression methodName="Split">
              <target>
                <variableReferenceExpression name="recipients"/>
              </target>
              <parameters>
                <primitiveExpression value="," convertTo="Char"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="SmtpClient" name="client">
          <init>
            <objectCreateExpression type="SmtpClient"/>
          </init>
        </variableDeclarationStatement>
        <foreachStatement>
          <variable type="System.String" name="s"/>
          <target>
            <variableReferenceExpression name="recipientsList"/>
          </target>
          <statements>
            <variableDeclarationStatement type="System.String" name="address">
              <init>
                <methodInvokeExpression methodName="Trim">
                  <target>
                    <variableReferenceExpression name="s"/>
                  </target>
                </methodInvokeExpression>
              </init>
            </variableDeclarationStatement>
            <conditionStatement>
              <condition>
                <unaryOperatorExpression operator="Not">
                  <methodInvokeExpression methodName="IsNullOrEmpty">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <variableReferenceExpression name="address"/>
                    </parameters>
                  </methodInvokeExpression>
                </unaryOperatorExpression>
              </condition>
              <trueStatements>
                <variableDeclarationStatement type="MailMessage" name="message">
                  <init>
                    <objectCreateExpression type="MailMessage"/>
                  </init>
                </variableDeclarationStatement>
                <tryStatement>
                  <statements>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <propertyReferenceExpression name="To">
                          <variableReferenceExpression name="message"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <objectCreateExpression type="MailAddress">
                          <parameters>
                            <variableReferenceExpression name="address"/>
                          </parameters>
                        </objectCreateExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <propertyReferenceExpression name="Subject">
                        <variableReferenceExpression name="message"/>
                      </propertyReferenceExpression>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="Import of {{0}} has been completed"/>
                          <argumentReferenceExpression name="controller"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                    <assignStatement>
                      <propertyReferenceExpression name="Body">
                        <variableReferenceExpression name="message"/>
                      </propertyReferenceExpression>
                      <methodInvokeExpression methodName="ReadAllText">
                        <target>
                          <typeReferenceExpression type="File"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="logFileName"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                    <methodInvokeExpression methodName="Send">
                      <target>
                        <variableReferenceExpression name="client"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="message"/>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                  <catch exceptionType="Exception"></catch>
                </tryStatement>
              </trueStatements>
            </conditionStatement>
          </statements>
        </foreachStatement>
      </statements>
    </memberMethod>
    <!-- method HandleError(ActionResult, ActionArgs)-->
    <memberMethod returnType="System.Boolean" name="HandleError">
      <attributes family="true"/>
      <parameters>
        <parameter type="ActionResult" name="r"/>
        <parameter type="ActionArgs" name="args"/>
      </parameters>
      <statements>
        <methodReturnStatement>
          <primitiveExpression value="false"/>
        </methodReturnStatement>
      </statements>
    </memberMethod>
    <!-- method CountRecords(string) -->
    <memberMethod returnType="System.Int32" name="CountRecords">
      <attributes public="true"/>
      <parameters>
        <parameter type="System.String" name="fileName"/>
      </parameters>
      <statements>
        <variableDeclarationStatement type="IDataReader" name="reader">
          <init>
            <methodInvokeExpression methodName="OpenRead">
              <parameters>
                <argumentReferenceExpression name="fileName"/>
                <primitiveExpression value="count(*)"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <tryStatement>
          <statements>
            <methodInvokeExpression methodName="Read">
              <target>
                <variableReferenceExpression name="reader"/>
              </target>
            </methodInvokeExpression>
            <methodReturnStatement>
              <methodInvokeExpression methodName="ToInt32">
                <target>
                  <typeReferenceExpression type="Convert"/>
                </target>
                <parameters>
                  <arrayIndexerExpression>
                    <target>
                      <variableReferenceExpression name="reader"/>
                    </target>
                    <indices>
                      <primitiveExpression value="0"/>
                    </indices>
                  </arrayIndexerExpression>
                </parameters>
              </methodInvokeExpression>
            </methodReturnStatement>
          </statements>
          <finally>
            <methodInvokeExpression methodName="Close">
              <target>
                <variableReferenceExpression name="reader"/>
              </target>
            </methodInvokeExpression>
          </finally>
        </tryStatement>
      </statements>
    </memberMethod>
    <!-- method MapFieldName(DataField)  -->
    <memberMethod returnType="System.String" name="MapFieldName">
      <attributes public="true" />
      <parameters>
        <parameter type="DataField" name="field"/>
      </parameters>
      <statements>
        <variableDeclarationStatement type="System.String" name="s">
          <init>
            <propertyReferenceExpression name="HeaderText">
              <argumentReferenceExpression name="field"/>
            </propertyReferenceExpression>
          </init>
        </variableDeclarationStatement>
        <conditionStatement>
          <condition>
            <methodInvokeExpression methodName="IsNullOrEmpty">
              <target>
                <typeReferenceExpression type="String"/>
              </target>
              <parameters>
                <variableReferenceExpression name="s"/>
              </parameters>
            </methodInvokeExpression>
          </condition>
          <trueStatements>
            <assignStatement>
              <variableReferenceExpression name="s"/>
              <propertyReferenceExpression name="Label">
                <argumentReferenceExpression name="field"/>
              </propertyReferenceExpression>
            </assignStatement>
          </trueStatements>
        </conditionStatement>
        <conditionStatement>
          <condition>
            <methodInvokeExpression methodName="IsNullOrEmpty">
              <target>
                <typeReferenceExpression type="String"/>
              </target>
              <parameters>
                <variableReferenceExpression name="s"/>
              </parameters>
            </methodInvokeExpression>
          </condition>
          <trueStatements>
            <assignStatement>
              <variableReferenceExpression name="s"/>
              <propertyReferenceExpression name="Name">
                <argumentReferenceExpression name="field"/>
              </propertyReferenceExpression>
            </assignStatement>
          </trueStatements>
        </conditionStatement>
        <methodReturnStatement>
          <variableReferenceExpression name="s"/>
        </methodReturnStatement>
      </statements>
    </memberMethod>
    <!-- method CreateListOfAvailableFields(string, string) -->
    <memberMethod returnType="System.String" name="CreateListOfAvailableFields">
      <attributes public="true" final="true"/>
      <parameters>
        <parameter type="System.String" name="controller"/>
        <parameter type="System.String" name="view"/>
      </parameters>
      <statements>
        <variableDeclarationStatement type="PageRequest" name="request">
          <init>
            <objectCreateExpression type="PageRequest"/>
          </init>
        </variableDeclarationStatement>
        <assignStatement>
          <propertyReferenceExpression name="Controller">
            <variableReferenceExpression name="request"/>
          </propertyReferenceExpression>
          <argumentReferenceExpression name="controller"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="View">
            <variableReferenceExpression name="request"/>
          </propertyReferenceExpression>
          <argumentReferenceExpression name="view"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="RequiresMetaData">
            <variableReferenceExpression name="request"/>
          </propertyReferenceExpression>
          <primitiveExpression value="true"/>
        </assignStatement>
        <variableDeclarationStatement type="ViewPage" name="page">
          <init>
            <methodInvokeExpression methodName="GetPage">
              <target>
                <methodInvokeExpression methodName="CreateDataController">
                  <target>
                    <typeReferenceExpression type="ControllerFactory"/>
                  </target>
                </methodInvokeExpression>
              </target>
              <parameters>
                <argumentReferenceExpression name="controller"/>
                <argumentReferenceExpression name="view"/>
                <variableReferenceExpression name="request"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="StringBuilder" name="sb">
          <init>
            <objectCreateExpression type="StringBuilder"/>
          </init>
        </variableDeclarationStatement>
        <foreachStatement>
          <variable type="DataField" name="f"/>
          <target>
            <propertyReferenceExpression name="Fields">
              <variableReferenceExpression name="page"/>
            </propertyReferenceExpression>
          </target>
          <statements>
            <conditionStatement>
              <condition>
                <binaryOperatorExpression operator="BooleanAnd">
                  <unaryOperatorExpression operator="Not">
                    <propertyReferenceExpression name="Hidden">
                      <variableReferenceExpression name="f"/>
                    </propertyReferenceExpression>
                  </unaryOperatorExpression>
                  <unaryOperatorExpression operator="Not">
                    <propertyReferenceExpression name="ReadOnly">
                      <variableReferenceExpression name="f"/>
                    </propertyReferenceExpression>
                  </unaryOperatorExpression>
                </binaryOperatorExpression>
              </condition>
              <trueStatements>
                <methodInvokeExpression methodName="AppendFormat">
                  <target>
                    <variableReferenceExpression name="sb"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="{{0}}="/>
                    <propertyReferenceExpression name="Name">
                      <variableReferenceExpression name="f"/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="DataField" name="field">
                  <init>
                    <variableReferenceExpression name="f"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="AliasName">
                            <variableReferenceExpression name="f"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="field"/>
                      <methodInvokeExpression methodName="FindField">
                        <target>
                          <variableReferenceExpression name="page"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="AliasName">
                            <variableReferenceExpression name="f"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="AppendLine">
                  <target>
                    <variableReferenceExpression name="sb"/>
                  </target>
                  <parameters>
                    <methodInvokeExpression methodName="MapFieldName">
                      <parameters>
                        <variableReferenceExpression name="field"/>
                      </parameters>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
              </trueStatements>
            </conditionStatement>
          </statements>
        </foreachStatement>
        <methodReturnStatement>
          <methodInvokeExpression methodName="ToString">
            <target>
              <variableReferenceExpression name="sb"/>
            </target>
          </methodInvokeExpression>
        </methodReturnStatement>
      </statements>
    </memberMethod>
    <!-- method CreateInitialFieldMap(string, string, string) -->
    <memberMethod returnType="System.String" name="CreateInitialFieldMap">
      <attributes public="true" final="true"/>
      <parameters>
        <parameter type="System.String" name="fileName"/>
        <parameter type="System.String" name="controller"/>
        <parameter type="System.String" name="view"/>
      </parameters>
      <statements>
        <comment>retreive metadata</comment>
        <variableDeclarationStatement type="PageRequest" name="request">
          <init>
            <objectCreateExpression type="PageRequest"/>
          </init>
        </variableDeclarationStatement>
        <assignStatement>
          <propertyReferenceExpression name="Controller">
            <variableReferenceExpression name="request"/>
          </propertyReferenceExpression>
          <argumentReferenceExpression name="controller"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="View">
            <variableReferenceExpression name="request"/>
          </propertyReferenceExpression>
          <argumentReferenceExpression name="view"/>
        </assignStatement>
        <assignStatement>
          <propertyReferenceExpression name="RequiresMetaData">
            <variableReferenceExpression name="request"/>
          </propertyReferenceExpression>
          <primitiveExpression value="true"/>
        </assignStatement>
        <variableDeclarationStatement type="ViewPage" name="page">
          <init>
            <methodInvokeExpression methodName="GetPage">
              <target>
                <methodInvokeExpression methodName="CreateDataController">
                  <target>
                    <typeReferenceExpression type="ControllerFactory"/>
                  </target>
                </methodInvokeExpression>
              </target>
              <parameters>
                <argumentReferenceExpression name="controller"/>
                <argumentReferenceExpression name="view"/>
                <variableReferenceExpression name="request"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <comment>create initial map</comment>
        <variableDeclarationStatement type="StringBuilder" name="sb">
          <init>
            <objectCreateExpression type="StringBuilder"/>
          </init>
        </variableDeclarationStatement>
        <variableDeclarationStatement type="IDataReader" name="reader">
          <init>
            <methodInvokeExpression methodName="OpenRead">
              <parameters>
                <argumentReferenceExpression name="fileName"/>
                <primitiveExpression value="*"/>
              </parameters>
            </methodInvokeExpression>
          </init>
        </variableDeclarationStatement>
        <tryStatement>
          <statements>
            <variableDeclarationStatement type="ImportMapDictionary" name="map">
              <init>
                <objectCreateExpression type="ImportMapDictionary"/>
              </init>
            </variableDeclarationStatement>
            <variableDeclarationStatement type="ImportLookupDictionary" name="lookups">
              <init>
                <objectCreateExpression type="ImportLookupDictionary"/>
              </init>
            </variableDeclarationStatement>
            <methodInvokeExpression methodName="EnumerateFields">
              <parameters>
                <variableReferenceExpression name="reader"/>
                <variableReferenceExpression name="page"/>
                <variableReferenceExpression name="map"/>
                <variableReferenceExpression name="lookups"/>
                <primitiveExpression value="null"/>
              </parameters>
            </methodInvokeExpression>
            <forStatement>
              <variable type="System.Int32" name="i">
                <init>
                  <primitiveExpression value="0"/>
                </init>
              </variable>
              <test>
                <binaryOperatorExpression operator="LessThan">
                  <variableReferenceExpression name="i"/>
                  <propertyReferenceExpression name="FieldCount">
                    <variableReferenceExpression name="reader"/>
                  </propertyReferenceExpression>
                </binaryOperatorExpression>
              </test>
              <increment>
                <variableReferenceExpression name="i"/>
              </increment>
              <statements>
                <methodInvokeExpression methodName="AppendFormat">
                  <target>
                    <variableReferenceExpression name="sb"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="{{0}}="/>
                    <methodInvokeExpression methodName="GetName">
                      <target>
                        <variableReferenceExpression name="reader"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="i"/>
                      </parameters>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="DataField" name="field">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="TryGetValue">
                      <target>
                        <variableReferenceExpression name="map"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="i"/>
                        <directionExpression direction="Out">
                          <variableReferenceExpression name="field"/>
                        </directionExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.String" name="fieldName">
                      <init>
                        <propertyReferenceExpression name="Name">
                          <variableReferenceExpression name="field"/>
                        </propertyReferenceExpression>
                      </init>
                    </variableDeclarationStatement>
                    <foreachStatement>
                      <variable type="DataField" name="lookupField"/>
                      <target>
                        <propertyReferenceExpression name="Values">
                          <variableReferenceExpression name="lookups"/>
                        </propertyReferenceExpression>
                      </target>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="AliasName">
                                <variableReferenceExpression name="lookupField"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="field"/>
                              </propertyReferenceExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="fieldName"/>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="lookupField"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                            <breakStatement/>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                    <methodInvokeExpression methodName="Append">
                      <target>
                        <variableReferenceExpression name="sb"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="fieldName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="AppendLine">
                  <target>
                    <variableReferenceExpression name="sb"/>
                  </target>
                </methodInvokeExpression>
              </statements>
            </forStatement>
          </statements>
          <finally>
            <methodInvokeExpression methodName="Close">
              <target>
                <variableReferenceExpression name="reader"/>
              </target>
            </methodInvokeExpression>
          </finally>
        </tryStatement>
        <methodReturnStatement>
          <methodInvokeExpression methodName="ToString">
            <target>
              <variableReferenceExpression name="sb"/>
            </target>
          </methodInvokeExpression>
        </methodReturnStatement>
      </statements>
    </memberMethod>
  </xsl:template>
</xsl:stylesheet>
