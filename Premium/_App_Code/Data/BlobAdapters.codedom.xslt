<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ontime="urn:schemas-codeontime-com:extensions"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a ontime"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:param name="Namespace" select="a:project/a:namespace"/>
  <xsl:param name="IsPremium"/>
  <xsl:param name="ProviderName"/>
  <xsl:param name="Host"/>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Data">
      <xsl:if test="$Host='SharePoint'">
        <xsl:attribute name="namespace">
          <xsl:value-of select="$Namespace"/>
          <xsl:text>.WebParts.Handlers</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.IO"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Security.Cryptography"/>
        <namespaceImport name="System.Globalization"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.Data.Common"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Net"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="{$Namespace}.Data"/>
        <namespaceImport name="{$Namespace}.Handlers"/>
      </imports>
      <types>
        <!-- partial class FileSystemBlobAdapter-->
        <typeDeclaration isPartial="true" name="FileSystemBlobAdapter">
          <baseTypes>
            <typeReference type="FileSystemBlobAdapterBase"/>
          </baseTypes>
          <members>
          <constructor>
            <attributes public="true"/>
            <parameters>
              <parameter type="System.String" name="controller"/>
              <parameter type="BlobAdapterArguments" name="arguments"/>
            </parameters>
            <baseConstructorArgs>
              <propertyReferenceExpression name="controller"/>
              <propertyReferenceExpression name="arguments"/>
            </baseConstructorArgs>
          </constructor>
          </members>
        </typeDeclaration>
        <!-- class FileSystemBlobAdapterBase-->
        <typeDeclaration name="FileSystemBlobAdapterBase">
          <attributes public="true"/>
          <baseTypes>
            <typeReference type="BlobAdapter"/>
          </baseTypes>
          <members>
            <!-- constructor FileSystemBlobAdapter(string, BlobAdapterArguments)-->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="controller"/>
                <parameter type="BlobAdapterArguments" name="arguments"/>
              </parameters>
              <baseConstructorArgs>
                <propertyReferenceExpression name="controller"/>
                <propertyReferenceExpression name="arguments"/>
              </baseConstructorArgs>
            </constructor>
            <!-- ReadBlob(string)-->
            <memberMethod returnType="Stream" name="ReadBlob">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="keyValue"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="fileName">
                  <init>
                    <methodInvokeExpression methodName="ExtendPathTemplate">
                      <parameters>
                        <variableReferenceExpression name="keyValue"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="OpenRead">
                    <target>
                      <propertyReferenceExpression name="File"/>
                    </target>
                    <parameters>
                      <variableReferenceExpression name="fileName"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- WriteBlob(HttpPostedFileBase, string)-->
            <memberMethod returnType="System.Boolean" name="WriteBlob">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="HttpPostedFileBase" name="file"/>
                <parameter type="System.String" name="keyValue"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="fileName">
                  <init>
                    <methodInvokeExpression methodName="ExtendPathTemplate">
                      <parameters>
                        <variableReferenceExpression name="keyValue"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="directoryName">
                  <init>
                    <methodInvokeExpression methodName="GetDirectoryName">
                      <target>
                        <propertyReferenceExpression name="Path"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="fileName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="Exists">
                        <target>
                          <propertyReferenceExpression name="Directory"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="directoryName"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="CreateDirectory">
                      <target>
                        <propertyReferenceExpression name="Directory"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="directoryName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="Stream" name="stream">
                  <init>
                    <propertyReferenceExpression name="InputStream">
                      <argumentReferenceExpression name="file"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="SaveAs">
                  <target>
                    <argumentReferenceExpression name="file"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="fileName"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- ValidateFieldValue(FieldValue)-->
            <memberMethod name="ValidateFieldValue">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="FieldValue" name="fv"/>
              </parameters>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- partial class AzureBlobAdapter-->
        <typeDeclaration isPartial="true" name="AzureBlobAdapter">
          <baseTypes>
            <typeReference type="AzureBlobAdapterBase"/>
          </baseTypes>
          <members>
            <!-- constructor-->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="controller"/>
                <parameter type="BlobAdapterArguments" name="arguments"/>
              </parameters>
              <baseConstructorArgs>
                <variableReferenceExpression name="controller"/>
                <variableReferenceExpression name="arguments"/>
              </baseConstructorArgs>
            </constructor>
          </members>
        </typeDeclaration>
        <!-- class AzureBlobAdapterBase-->
        <typeDeclaration name="AzureBlobAdapterBase">
          <baseTypes>
            <typeReference type="BlobAdapter"/>
          </baseTypes>
          <members>
            <!-- property Account-->
            <memberProperty type="System.String" name="Account">
              <attributes public="true"/>
            </memberProperty>
            <!-- property Key-->
            <memberProperty type="System.String" name="Key">
              <attributes public="true"/>
            </memberProperty>
            <!-- property Container-->
            <memberProperty type="System.String" name="Container">
              <attributes public="true"/>
            </memberProperty>
            <!-- constructor-->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="controller"/>
                <parameter type="BlobAdapterArguments" name="arguments"/>
              </parameters>
              <baseConstructorArgs>
                <variableReferenceExpression name="controller"/>
                <variableReferenceExpression name="arguments"/>
              </baseConstructorArgs>
            </constructor>
            <!-- method Initialize-->
            <memberMethod name="Initialize">
              <attributes override="true" family="true"/>
              <statements>
                <methodInvokeExpression methodName="Initialize">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="ContainsKey">
                      <target>
                        <propertyReferenceExpression name="Arguments"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="account"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="Account"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Arguments"/>
                        </target>
                        <indices>
                          <primitiveExpression value="account"/>
                        </indices>
                      </arrayIndexerExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="ContainsKey">
                      <target>
                        <propertyReferenceExpression name="Arguments"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="key"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="Key"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Arguments"/>
                        </target>
                        <indices>
                          <primitiveExpression value="key"/>
                        </indices>
                      </arrayIndexerExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="ContainsKey">
                      <target>
                        <propertyReferenceExpression name="Arguments"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="container"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="Container"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Arguments"/>
                        </target>
                        <indices>
                          <primitiveExpression value="container"/>
                        </indices>
                      </arrayIndexerExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method ReadBlob(string)-->
            <memberMethod returnType="Stream" name="ReadBlob">
              <attributes override="true" public="true"/>
              <parameters>
                <parameter type="System.String" name="keyValue"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="urlPath">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <propertyReferenceExpression name="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="{{0}}/{{1}}"/>
                        <propertyReferenceExpression name="Container">
                          <thisReferenceExpression/>
                        </propertyReferenceExpression>
                        <methodInvokeExpression methodName="KeyValueToPath">
                          <parameters>
                            <argumentReferenceExpression name="keyValue"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="requestMethod">
                  <init>
                    <primitiveExpression value="GET"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="storageServiceVersion">
                  <init>
                    <primitiveExpression value="2015-12-11"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="blobType">
                  <init>
                    <primitiveExpression value="BlockBlob"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="dateInRfc1123Format">
                  <init>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <propertyReferenceExpression name="UtcNow">
                          <propertyReferenceExpression name="DateTime"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="R"/>
                        <propertyReferenceExpression name="InvariantCulture">
                          <propertyReferenceExpression name="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="canonicalizedHeaders">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <propertyReferenceExpression name="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="x-ms-blob-type:{{0}}&#xA;x-ms-date:{{1}}&#xA;x-ms-version:{{2}}"/>
                        <variableReferenceExpression name="blobType"/>
                        <variableReferenceExpression name="dateInRfc1123Format"/>
                        <variableReferenceExpression name="storageServiceVersion"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="canonicalizedResource">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <propertyReferenceExpression name="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="/{{0}}/{{1}}"/>
                        <propertyReferenceExpression name="Account">
                          <thisReferenceExpression/>
                        </propertyReferenceExpression>
                        <variableReferenceExpression name="urlPath"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="blobLength">
                  <init>
                    <primitiveExpression value=""/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="stringToSign">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <propertyReferenceExpression name="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="{{0}}&#xA;&#xA;&#xA;{{1}}&#xA;&#xA;&#xA;&#xA;&#xA;&#xA;&#xA;&#xA;&#xA;{{2}}&#xA;{{3}}"/>
                        <variableReferenceExpression name="requestMethod"/>
                        <variableReferenceExpression name="blobLength"/>
                        <variableReferenceExpression name="canonicalizedHeaders"/>
                        <variableReferenceExpression name="canonicalizedResource"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="authorizationHeader">
                  <init>
                    <methodInvokeExpression methodName="CreateAuthorizationHeaderForAzure">
                      <parameters>
                        <variableReferenceExpression name="stringToSign"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="Uri" name="uri">
                  <init>
                    <objectCreateExpression type="Uri">
                      <parameters>
                        <binaryOperatorExpression operator="Add">
                          <binaryOperatorExpression operator="Add">
                            <primitiveExpression value="https://"/>
                            <propertyReferenceExpression name="Account">
                              <thisReferenceExpression/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="Add">
                            <primitiveExpression value=".blob.core.windows.net/"/>
                            <variableReferenceExpression name="urlPath"/>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="HttpWebRequest" name="request">
                  <init>
                    <castExpression targetType="HttpWebRequest">
                      <methodInvokeExpression methodName="Create">
                        <target>
                          <propertyReferenceExpression name="WebRequest"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="uri"/>
                        </parameters>
                      </methodInvokeExpression>
                    </castExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Method">
                    <variableReferenceExpression name="request"/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="requestMethod"/>
                </assignStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="x-ms-blob-type"/>
                    <variableReferenceExpression name="blobType"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="x-ms-date"/>
                    <variableReferenceExpression name="dateInRfc1123Format"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="x-ms-version"/>
                    <variableReferenceExpression name="storageServiceVersion"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="Authorization"/>
                    <variableReferenceExpression name="authorizationHeader"/>
                  </parameters>
                </methodInvokeExpression>
                <tryStatement>
                  <statements>
                    <variableDeclarationStatement type="Stream" name="stream">
                      <init>
                        <objectCreateExpression type="TemporaryFileStream"/>
                      </init>
                    </variableDeclarationStatement>
                    <usingStatement>
                      <variable type="HttpWebResponse" name="response">
                        <init>
                          <castExpression targetType="HttpWebResponse">
                            <methodInvokeExpression methodName="GetResponse">
                              <target>
                                <variableReferenceExpression name="request"/>
                              </target>
                            </methodInvokeExpression>
                          </castExpression>
                        </init>
                      </variable>
                      <statements>
                        <usingStatement>
                          <variable type="Stream" name="dataStream">
                            <init>
                              <methodInvokeExpression methodName="GetResponseStream">
                                <target>
                                  <variableReferenceExpression name="response"/>
                                </target>
                              </methodInvokeExpression>
                            </init>
                          </variable>
                          <statements>
                            <methodInvokeExpression methodName="CopyData">
                              <parameters>
                                <variableReferenceExpression name="dataStream"/>
                                <variableReferenceExpression name="stream"/>
                              </parameters>
                            </methodInvokeExpression>
                          </statements>
                        </usingStatement>
                      </statements>
                    </usingStatement>
                    <methodReturnStatement>
                      <variableReferenceExpression name="stream"/>
                    </methodReturnStatement>
                  </statements>
                  <catch exceptionType="Exception" localName="e">
                    <variableDeclarationStatement type="System.String" name="message">
                      <init>
                        <propertyReferenceExpression name="Message">
                          <variableReferenceExpression name="e"/>
                        </propertyReferenceExpression>
                      </init>
                    </variableDeclarationStatement>
                    <methodReturnStatement>
                      <primitiveExpression value="null"/>
                    </methodReturnStatement>
                  </catch>
                </tryStatement>
              </statements>
            </memberMethod>
            <!-- method WriteBlob(HttpPostedFileBase, string)-->
            <memberMethod returnType="System.Boolean" name="WriteBlob">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="HttpPostedFileBase" name="file"/>
                <parameter type="System.String" name="keyValue"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="requestMethod">
                  <init>
                    <primitiveExpression value="PUT"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="urlPath">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <propertyReferenceExpression name="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="{{0}}/{{1}}"/>
                        <propertyReferenceExpression name="Container">
                          <thisReferenceExpression/>
                        </propertyReferenceExpression>
                        <methodInvokeExpression methodName="KeyValueToPath">
                          <parameters>
                            <argumentReferenceExpression name="keyValue"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="storageServiceVersion">
                  <init>
                    <primitiveExpression value="2015-12-11"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="dateInRfc1123Format">
                  <init>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <propertyReferenceExpression name="UtcNow">
                          <propertyReferenceExpression name="DateTime"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="R"/>
                        <propertyReferenceExpression name="InvariantCulture">
                          <propertyReferenceExpression name="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="Stream" name="stream">
                  <init>
                    <propertyReferenceExpression name="InputStream">
                      <argumentReferenceExpression name="file"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="UTF8Encoding" name="utf8Encoding">
                  <init>
                    <objectCreateExpression type="UTF8Encoding"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Int32" name="blobLength">
                  <init>
                    <castExpression targetType="System.Int32">
                      <propertyReferenceExpression name="Length">
                        <variableReferenceExpression name="stream"/>
                      </propertyReferenceExpression>
                    </castExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Byte[]" name="blobContent">
                  <init>
                    <arrayCreateExpression>
                      <createType type="System.Byte"/>
                      <sizeExpression>
                        <variableReferenceExpression name="blobLength"/>
                      </sizeExpression>
                    </arrayCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Read">
                  <target>
                    <variableReferenceExpression name="stream"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="blobContent"/>
                    <primitiveExpression value="0"/>
                    <variableReferenceExpression name="blobLength"/>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="System.String" name="blobType">
                  <init>
                    <primitiveExpression value="BlockBlob"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="canonicalizedHeaders">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <propertyReferenceExpression name="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="x-ms-blob-type:{{0}}&#xA;x-ms-date:{{1}}&#xA;x-ms-version:{{2}}"/>
                        <variableReferenceExpression name="blobType"/>
                        <variableReferenceExpression name="dateInRfc1123Format"/>
                        <variableReferenceExpression name="storageServiceVersion"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="canonicalizedResource">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <propertyReferenceExpression name="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="/{{0}}/{{1}}"/>
                        <propertyReferenceExpression name="Account">
                          <thisReferenceExpression/>
                        </propertyReferenceExpression>
                        <variableReferenceExpression name="urlPath"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="stringToSign">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <propertyReferenceExpression name="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="{{0}}&#xA;&#xA;&#xA;{{1}}&#xA;&#xA;{{4}}&#xA;&#xA;&#xA;&#xA;&#xA;&#xA;&#xA;{{2}}&#xA;{{3}}"/>
                        <variableReferenceExpression name="requestMethod"/>
                        <variableReferenceExpression name="blobLength"/>
                        <variableReferenceExpression name="canonicalizedHeaders"/>
                        <variableReferenceExpression name="canonicalizedResource"/>
                        <propertyReferenceExpression name="ContentType">
                          <argumentReferenceExpression name="file"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="authorizationHeader">
                  <init>
                    <methodInvokeExpression methodName="CreateAuthorizationHeaderForAzure">
                      <parameters>
                        <variableReferenceExpression name="stringToSign"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="Uri" name="uri">
                  <init>
                    <objectCreateExpression type="Uri">
                      <parameters>
                        <binaryOperatorExpression operator="Add">
                          <binaryOperatorExpression operator="Add">
                            <primitiveExpression value="https://"/>
                            <propertyReferenceExpression name="Account">
                              <thisReferenceExpression/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="Add">
                            <primitiveExpression value=".blob.core.windows.net/"/>
                            <variableReferenceExpression name="urlPath"/>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="HttpWebRequest" name="request">
                  <init>
                    <castExpression targetType="HttpWebRequest">
                      <methodInvokeExpression methodName="Create">
                        <target>
                          <propertyReferenceExpression name="WebRequest"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="uri"/>
                        </parameters>
                      </methodInvokeExpression>
                    </castExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Method">
                    <variableReferenceExpression name="request"/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="requestMethod"/>
                </assignStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="x-ms-blob-type"/>
                    <variableReferenceExpression name="blobType"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="x-ms-date"/>
                    <variableReferenceExpression name="dateInRfc1123Format"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="x-ms-version"/>
                    <variableReferenceExpression name="storageServiceVersion"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="Authorization"/>
                    <variableReferenceExpression name="authorizationHeader"/>
                  </parameters>
                </methodInvokeExpression>
                <assignStatement>
                  <propertyReferenceExpression name="ContentLength">
                    <variableReferenceExpression name="request"/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="blobLength"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="ContentType">
                    <variableReferenceExpression name="request"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="ContentType">
                    <variableReferenceExpression name="file"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <tryStatement>
                  <statements>
                    <variableDeclarationStatement type="System.Int32" name="bufferSize">
                      <init>
                        <binaryOperatorExpression operator="Multiply">
                          <primitiveExpression value="1024"/>
                          <primitiveExpression value="64"/>
                        </binaryOperatorExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Int32" name="offset">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variableDeclarationStatement>
                    <usingStatement>
                      <variable type="Stream" name="requestStream">
                        <init>
                          <methodInvokeExpression methodName="GetRequestStream">
                            <target>
                              <variableReferenceExpression name="request"/>
                            </target>
                          </methodInvokeExpression>
                        </init>
                      </variable>
                      <statements>
                        <whileStatement>
                          <test>
                            <binaryOperatorExpression operator="LessThan">
                              <variableReferenceExpression name="offset"/>
                              <variableReferenceExpression name="blobLength"/>
                            </binaryOperatorExpression>
                          </test>
                          <statements>
                            <variableDeclarationStatement type="System.Int32" name="bytesToWrite">
                              <init>
                                <binaryOperatorExpression operator="Subtract">
                                  <variableReferenceExpression name="blobLength"/>
                                  <variableReferenceExpression name="offset"/>
                                </binaryOperatorExpression>
                              </init>
                            </variableDeclarationStatement>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="LessThan">
                                  <binaryOperatorExpression operator="Add">
                                    <variableReferenceExpression name="offset"/>
                                    <variableReferenceExpression name="bufferSize"/>
                                  </binaryOperatorExpression>
                                  <variableReferenceExpression name="blobLength"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <variableReferenceExpression name="bytesToWrite"/>
                                  <variableReferenceExpression name="bufferSize"/>
                                </assignStatement>
                              </trueStatements>

                            </conditionStatement>
                            <methodInvokeExpression methodName="Write">
                              <target>
                                <variableReferenceExpression name="requestStream"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="blobContent"/>
                                <variableReferenceExpression name="offset"/>
                                <variableReferenceExpression name="bytesToWrite"/>
                              </parameters>
                            </methodInvokeExpression>
                            <assignStatement>
                              <variableReferenceExpression name="offset"/>
                              <binaryOperatorExpression operator="Add">
                                <variableReferenceExpression name="offset"/>
                                <variableReferenceExpression name="bytesToWrite"/>
                              </binaryOperatorExpression>
                            </assignStatement>
                          </statements>
                        </whileStatement>
                      </statements>
                    </usingStatement>
                    <usingStatement>
                      <variable type="HttpWebResponse" name="response">
                        <init>
                          <castExpression targetType="HttpWebResponse">
                            <methodInvokeExpression methodName="GetResponse">
                              <target>
                                <variableReferenceExpression name="request"/>
                              </target>
                            </methodInvokeExpression>
                          </castExpression>
                        </init>
                      </variable>
                      <statements>
                        <variableDeclarationStatement type="System.String" name="ETag">
                          <init>
                            <arrayIndexerExpression>
                              <target>
                                <propertyReferenceExpression name="Headers">
                                  <variableReferenceExpression name="response"/>
                                </propertyReferenceExpression>
                              </target>
                              <indices>
                                <primitiveExpression value="ETag"/>
                              </indices>
                            </arrayIndexerExpression>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanOr">
                              <binaryOperatorExpression operator="BooleanOr">
                                <binaryOperatorExpression operator="ValueEquality">
                                  <propertyReferenceExpression name="StatusCode">
                                    <variableReferenceExpression name="response"/>
                                  </propertyReferenceExpression>
                                  <propertyReferenceExpression name="OK">
                                    <propertyReferenceExpression name="HttpStatusCode"/>
                                  </propertyReferenceExpression>
                                </binaryOperatorExpression>
                                <binaryOperatorExpression operator="ValueEquality">
                                  <propertyReferenceExpression name="StatusCode">
                                    <variableReferenceExpression name="response"/>
                                  </propertyReferenceExpression>
                                  <propertyReferenceExpression name="Accepted">
                                    <propertyReferenceExpression name="HttpStatusCode"/>
                                  </propertyReferenceExpression>
                                </binaryOperatorExpression>
                              </binaryOperatorExpression>
                              <binaryOperatorExpression operator="ValueEquality">
                                <propertyReferenceExpression name="StatusCode">
                                  <variableReferenceExpression name="response"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="Created">
                                  <propertyReferenceExpression name="HttpStatusCode"/>
                                </propertyReferenceExpression>
                              </binaryOperatorExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodReturnStatement>
                              <primitiveExpression value="true"/>
                            </methodReturnStatement>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </usingStatement>
                  </statements>
                  <catch exceptionType="WebException" localName="webEx">
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="webEx"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="WebResponse" name="resp">
                          <init>
                            <propertyReferenceExpression name="Response">
                              <variableReferenceExpression name="webEx"/>
                            </propertyReferenceExpression>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="IdentityInequality">
                              <variableReferenceExpression name="resp"/>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <usingStatement>
                              <variable type="StreamReader" name="sr">
                                <init>
                                  <objectCreateExpression type="StreamReader">
                                    <parameters>
                                      <methodInvokeExpression methodName="GetResponseStream">
                                        <target>
                                          <variableReferenceExpression name="resp"/>
                                        </target>
                                      </methodInvokeExpression>
                                      <primitiveExpression value="true"/>
                                    </parameters>
                                  </objectCreateExpression>
                                </init>
                              </variable>
                              <statements>
                                <throwExceptionStatement>
                                  <objectCreateExpression type="Exception">
                                    <parameters>
                                      <methodInvokeExpression methodName="ReadToEnd">
                                        <target>
                                          <variableReferenceExpression name="sr"/>
                                        </target>
                                      </methodInvokeExpression>
                                    </parameters>
                                  </objectCreateExpression>
                                </throwExceptionStatement>
                              </statements>
                            </usingStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </catch>
                </tryStatement>
                <methodReturnStatement>
                  <primitiveExpression value="false"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateAuthorizationHeaderForAzure(string)-->
            <memberMethod returnType="System.String" name="CreateAuthorizationHeaderForAzure">
              <attributes family="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="canonicalizedString"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="signature">
                  <init>
                    <stringEmptyExpression/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Byte[]" name="storageKey">
                  <init>
                    <methodInvokeExpression methodName="FromBase64String">
                      <target>
                        <propertyReferenceExpression name="Convert"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Key">
                          <thisReferenceExpression/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="HMACSHA256" name="hmacSha256">
                    <init>
                      <objectCreateExpression type="HMACSHA256">
                        <parameters>
                          <variableReferenceExpression name="storageKey"/>
                        </parameters>
                      </objectCreateExpression>
                    </init>
                  </variable>
                  <statements>
                    <variableDeclarationStatement type="System.Byte[]" name="dataToHmac">
                      <init>
                        <methodInvokeExpression methodName="GetBytes">
                          <target>
                            <propertyReferenceExpression name="UTF8">
                              <propertyReferenceExpression name="Encoding">
                                <propertyReferenceExpression name="Text">
                                  <propertyReferenceExpression name="System"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <argumentReferenceExpression name="canonicalizedString"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <assignStatement>
                      <variableReferenceExpression name="signature"/>
                      <methodInvokeExpression methodName="ToBase64String">
                        <target>
                          <propertyReferenceExpression name="Convert"/>
                        </target>
                        <parameters>
                          <methodInvokeExpression methodName="ComputeHash">
                            <target>
                              <variableReferenceExpression name="hmacSha256"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="dataToHmac"/>
                            </parameters>
                          </methodInvokeExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </statements>
                </usingStatement>
                <variableDeclarationStatement type="System.String" name="authorizationHeader">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <propertyReferenceExpression name="String"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="InvariantCulture">
                          <propertyReferenceExpression name="CultureInfo"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="{{0}} {{1}}:{{2}}"/>
                        <primitiveExpression value="SharedKey"/>
                        <propertyReferenceExpression name="Account">
                          <thisReferenceExpression/>
                        </propertyReferenceExpression>
                        <variableReferenceExpression name="signature"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="authorizationHeader"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
