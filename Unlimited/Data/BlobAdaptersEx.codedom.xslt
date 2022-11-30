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
        <!-- class S3BlobAdapter-->
        <typeDeclaration isPartial="true" name="S3BlobAdapter">
          <attributes public="true"/>
          <baseTypes>
            <typeReference type="S3BlobAdapterBase"/>
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
        <!-- clas S3BlobAdapterBase-->
        <typeDeclaration name="S3BlobAdapterBase">
          <baseTypes>
            <typeReference type="BlobAdapter"/>
          </baseTypes>
          <members>
            <!-- property AccessKeyID -->
            <memberProperty type="System.String" name="AccessKeyID">
              <attributes public="true"/>
            </memberProperty>
            <!-- property SecretAccessKey-->
            <memberProperty type="System.String" name="SecretAccessKey">
              <attributes public="true"/>
            </memberProperty>
            <!-- property Bucket -->
            <memberProperty type="System.String" name="Bucket">
              <attributes public="true"/>
            </memberProperty>
            <!-- constructor S3BlobAdapterBase-->
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
            <!-- method Initialize -->
            <memberMethod name="Initialize">
              <attributes family="true" override="true"/>
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
                        <primitiveExpression value="access-key-id"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="AccessKeyID"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Arguments"/>
                        </target>
                        <indices>
                          <primitiveExpression value="access-key-id"/>
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
                        <primitiveExpression value="secret-access-key"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="SecretAccessKey"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Arguments"/>
                        </target>
                        <indices>
                          <primitiveExpression value="secret-access-key"/>
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
                        <primitiveExpression value="bucket"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="Bucket"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Arguments"/>
                        </target>
                        <indices>
                          <primitiveExpression value="bucket"/>
                        </indices>
                      </arrayIndexerExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method ReadBlob(string) -->
            <memberMethod returnType="Stream" name="ReadBlob">
              <attributes override="true" public="true"/>
              <parameters>
                <parameter type="System.String" name="keyValue"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="extendedPath">
                  <init>
                    <methodInvokeExpression methodName="KeyValueToPath">
                      <parameters>
                        <argumentReferenceExpression name="keyValue"/>
                      </parameters>
                    </methodInvokeExpression>=
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="httpVerb">
                  <init>
                    <primitiveExpression value="GET"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.DateTime" name="d">
                  <init>
                    <propertyReferenceExpression name="UtcNow">
                      <typeReferenceExpression type="DateTime"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="canonicalizedAmzHeaders">
                  <init>
                    <binaryOperatorExpression operator="Add">
                      <primitiveExpression value="x-amz-date:"/>
                      <methodInvokeExpression methodName="ToString">
                        <target>
                          <variableReferenceExpression name="d"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="R"/>
                          <propertyReferenceExpression name="InvariantCulture">
                            <typeReferenceExpression type="CultureInfo"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </binaryOperatorExpression>
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
                        <propertyReferenceExpression name="Bucket">
                          <thisReferenceExpression/>
                        </propertyReferenceExpression>
                        <variableReferenceExpression name="extendedPath"/>
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
                        <primitiveExpression value="{{0}}&#xA;&#xA;&#xA;&#xA;{{1}}&#xA;{{2}}"/>
                        <variableReferenceExpression name="httpVerb"/>
                        <variableReferenceExpression name="canonicalizedAmzHeaders"/>
                        <variableReferenceExpression name="canonicalizedResource"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="authorization">
                  <init>
                    <methodInvokeExpression methodName="CreateAuthorizationHeaderForS3">
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
                            <primitiveExpression value="http://"/>
                            <propertyReferenceExpression name="Bucket">
                              <thisReferenceExpression/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="Add">
                            <primitiveExpression value=".s3.amazonaws.com/"/>
                            <variableReferenceExpression name="extendedPath"/>
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
                  <variableReferenceExpression name="httpVerb"/>
                </assignStatement>
                <!--<xsl:if test="$Host!='SharePoint'">
                  <assignStatement>
                  <propertyReferenceExpression name="Date">
                    <variableReferenceExpression name="request"/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="date"/>
                </assignStatement>
                </xsl:if>-->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="x-amz-date"/>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <variableReferenceExpression name="d"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="R"/>
                        <propertyReferenceExpression name="InvariantCulture">
                          <typeReferenceExpression type="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
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
                    <variableReferenceExpression name="authorization"/>
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
            <!-- method WriteBlob(HttpPostedFileBase, string) -->
            <memberMethod returnType="System.Boolean" name="WriteBlob">
              <attributes override="true" public="true"/>
              <parameters>
                <parameter type="HttpPostedFileBase" name="file"/>
                <parameter type="System.String" name="keyValue"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="extendedPath">
                  <init>
                    <methodInvokeExpression methodName="KeyValueToPath">
                      <parameters>
                        <argumentReferenceExpression name="keyValue"/>
                      </parameters>
                    </methodInvokeExpression>=
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="Stream" name="stream">
                  <init>
                    <propertyReferenceExpression name="InputStream">
                      <argumentReferenceExpression name="file"/>
                    </propertyReferenceExpression>
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
                <variableDeclarationStatement type="System.String" name="httpVerb">
                  <init>
                    <primitiveExpression value="PUT"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.DateTime" name="d">
                  <init>
                    <propertyReferenceExpression name="UtcNow">
                      <typeReferenceExpression type="DateTime"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="canonicalizedAmzHeaders">
                  <init>
                    <binaryOperatorExpression operator="Add">
                      <primitiveExpression value="x-amz-date:"/>
                      <methodInvokeExpression methodName="ToString">
                        <target>
                          <variableReferenceExpression name="d"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="R"/>
                          <propertyReferenceExpression name="InvariantCulture">
                            <typeReferenceExpression type="CultureInfo"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </binaryOperatorExpression>
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
                        <propertyReferenceExpression name="Bucket">
                          <thisReferenceExpression/>
                        </propertyReferenceExpression>
                        <variableReferenceExpression name="extendedPath"/>
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
                        <primitiveExpression value="{{0}}&#xA;&#xA;&#xA;&#xA;{{1}}&#xA;{{2}}"/>
                        <variableReferenceExpression name="httpVerb"/>
                        <variableReferenceExpression name="canonicalizedAmzHeaders"/>
                        <variableReferenceExpression name="canonicalizedResource"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="authorization">
                  <init>
                    <methodInvokeExpression methodName="CreateAuthorizationHeaderForS3">
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
                            <primitiveExpression value="http://"/>
                            <propertyReferenceExpression name="Bucket">
                              <thisReferenceExpression/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="Add">
                            <primitiveExpression value=".s3.amazonaws.com/"/>
                            <variableReferenceExpression name="extendedPath"/>
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
                  <variableReferenceExpression name="httpVerb"/>
                </assignStatement>
                <!--<xsl:if test="$Host!='SharePoint'">
                  <assignStatement>
                    <propertyReferenceExpression name="Date">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                    <variableReferenceExpression name="date"/>
                  </assignStatement>
                </xsl:if>-->
                <assignStatement>
                  <propertyReferenceExpression name="ContentLength">
                    <variableReferenceExpression name="request"/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="blobLength"/>
                </assignStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Headers">
                      <variableReferenceExpression name="request"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="x-amz-date"/>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <variableReferenceExpression name="d"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="R"/>
                        <propertyReferenceExpression name="InvariantCulture">
                          <typeReferenceExpression type="CultureInfo"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
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
                    <variableReferenceExpression name="authorization"/>
                  </parameters>
                </methodInvokeExpression>
                <tryStatement>
                  <statements>
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
            <!-- method CreateAuthorizationHeaderForS3(string) -->
            <memberMethod returnType="System.String" name="CreateAuthorizationHeaderForS3">
              <attributes family="true"/>
              <parameters>
                <parameter type="System.String" name="canonicalizedString"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="Encoding" name="ae">
                  <init>
                    <objectCreateExpression type="UTF8Encoding"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="HMACSHA1" name="signature">
                  <init>
                    <objectCreateExpression type="HMACSHA1"/>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Key">
                    <variableReferenceExpression name="signature"/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="GetBytes">
                    <target>
                      <variableReferenceExpression name="ae"/>
                    </target>
                    <parameters>
                      <propertyReferenceExpression name="SecretAccessKey">
                        <thisReferenceExpression/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <variableDeclarationStatement type="System.Byte[]" name="bytes">
                  <init>
                    <methodInvokeExpression methodName="GetBytes">
                      <target>
                        <variableReferenceExpression name="ae"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="canonicalizedString"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Byte[]" name="moreBytes">
                  <init>
                    <methodInvokeExpression methodName="ComputeHash">
                      <target>
                        <variableReferenceExpression name="signature"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="bytes"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="encodedCanonical">
                  <init>
                    <methodInvokeExpression methodName="ToBase64String">
                      <target>
                        <typeReferenceExpression type="Convert"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="moreBytes"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <propertyReferenceExpression name="InvariantCulture">
                        <typeReferenceExpression type="CultureInfo"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="{{0}} {{1}}:{{2}}"/>
                      <primitiveExpression value="AWS"/>
                      <propertyReferenceExpression name="AccessKeyID">
                        <thisReferenceExpression />
                      </propertyReferenceExpression>
                      <variableReferenceExpression name="encodedCanonical"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
