<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <compileUnit namespace="{a:project/a:namespace}.Data">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Web"/>
      </imports>
      <types>
        <!-- class DistinctValueRequest -->
        <typeDeclaration name="DistinctValueRequest" isPartial="true">
          <baseTypes>
            <typeReference type="DistinctValueRequestBase"/>
          </baseTypes>
        </typeDeclaration>
        <!-- class DistinctValueRequestBase -->
        <typeDeclaration name="DistinctValueRequestBase">
          <members>
            <!-- property Tag -->
            <memberProperty type="System.String" name="Tag">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property FieldName-->
            <memberField type="System.String" name="fieldName"/>
            <memberProperty type="System.String" name="FieldName">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="fieldName"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="fieldName"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Filter -->
            <memberProperty type="System.String[]" name="Filter">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property ExternalFilter -->
            <memberProperty type="FieldValue[]" name="ExternalFilter">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property LookupContextController -->
            <memberField type="System.String" name="lookupContextController"/>
            <memberProperty type="System.String" name="LookupContextController">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="lookupContextController"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="lookupContextController"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property LookupContextView -->
            <memberField type="System.String" name="lookupContextView"/>
            <memberProperty type="System.String" name="LookupContextView">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="lookupContextView"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="lookupContextView"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property LookupContextFieldName -->
            <memberField type="System.String" name="lookupContextFieldName"/>
            <memberProperty type="System.String" name="LookupContextFieldName">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="lookupContextFieldName"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="lookupContextFieldName"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Controller -->
            <memberField type="System.String" name="controller"/>
            <memberProperty type="System.String" name="Controller">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="controller"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="controller"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property View -->
            <memberField type="System.String" name="view"/>
            <memberProperty type="System.String" name="View">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="view"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="view"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Current -->
            <memberProperty type="DistinctValueRequest" name="Current">
              <attributes public="true" static="true"/>
              <getStatements>
                <methodReturnStatement>
                  <castExpression targetType="DistinctValueRequest">
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Items">
                          <propertyReferenceExpression name="Current">
                            <typeReferenceExpression type="HttpContext"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="DistinctValueRequest_Current"/>
                      </indices>
                    </arrayIndexerExpression>
                  </castExpression>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- constructor DistinctValueRequestBase -->
            <constructor>
              <attributes public="true"/>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <propertyReferenceExpression name="Current"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Items">
                            <propertyReferenceExpression name="Current">
                              <typeReferenceExpression type="HttpContext"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="DistinctValueRequest_Current"/>
                        </indices>
                      </arrayIndexerExpression>
                      <thisReferenceExpression/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </constructor>
            <!-- property MaximumValueCount -->
            <memberField type="System.Int32" name="maximumValueCount"/>
            <memberProperty type="System.Int32" name="MaximumValueCount">
              <attributes public="true" />
              <getStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="LessThanOrEqual">
                      <fieldReferenceExpression name="maximumValueCount"/>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <propertyReferenceExpression name="MaximumDistinctValues">
                        <typeReferenceExpression type="DataControllerBase"/>
                      </propertyReferenceExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <fieldReferenceExpression name="maximumValueCount"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="maximumValueCount"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- AllowFieldInFilter -->
            <memberField type="System.Boolean" name="allowFieldInFilter"/>
            <memberProperty type="System.Boolean" name="AllowFieldInFilter">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="allowFieldInFilter"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="allowFieldInFilter"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property QuickFindHint -->
            <memberProperty type="System.String" name="QuickFindHint">
              <attributes public="true" final="true"/>
            </memberProperty>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
