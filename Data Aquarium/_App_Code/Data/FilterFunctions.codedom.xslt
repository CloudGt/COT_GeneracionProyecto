<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template name="RegisterFunction">
    <xsl:param name="Key"/>
    <xsl:param name="Type" select="'DateRangeFilterFunction'"/>
    <xsl:param name="Arg"/>
    <methodInvokeExpression methodName="Add">
      <target>
        <propertyReferenceExpression name="All"/>
      </target>
      <parameters>
        <primitiveExpression value="{$Key}" convertTo="String"/>
        <objectCreateExpression type="{$Type}">
          <parameters>
            <xsl:if test="$Arg!=''">
              <primitiveExpression value="{$Arg}" />
            </xsl:if>
          </parameters>
        </objectCreateExpression>
      </parameters>
    </methodInvokeExpression>
  </xsl:template>


  <xsl:template match="/">
    <compileUnit namespace="{a:project/a:namespace}.Data">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Data.Common"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Caching"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Globalization"/>
      </imports>
      <types>
        <!-- class FilterFunctions -->
        <typeDeclaration name="FilterFunctions">
          <members>
            <!-- field All -->
            <memberField type="SortedDictionary" name="All">
              <typeArguments>
                <typeReference type="System.String"/>
                <typeReference type="FilterFunctionBase"/>
              </typeArguments>
              <attributes public="true" static="true"/>
              <init>
                <objectCreateExpression type="SortedDictionary">
                  <typeArguments>
                    <typeReference type="System.String"/>
                    <typeReference type="FilterFunctionBase"/>
                  </typeArguments>
                </objectCreateExpression>
              </init>
            </memberField>
            <!-- field command -->
            <memberField type="DbCommand" name="command"/>
            <!-- field filter -->
            <memberField type="System.String" name="filter"/>
            <!-- field expressions -->
            <memberField type="SelectClauseDictionary" name="expressions"/>
            <!--  type constructor() -->
            <typeConstructor>
              <statements>
                <!-- username-->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="username"/>
                    <objectCreateExpression type="UserNameFilterFunction"/>
                  </parameters>
                </methodInvokeExpression>
                <!-- userid -->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="userid"/>
                    <objectCreateExpression type="UserIdFilterFunction"/>
                  </parameters>
                </methodInvokeExpression>
                <!-- external -->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="external"/>
                    <objectCreateExpression type="ExternalFilterFunction"/>
                  </parameters>
                </methodInvokeExpression>
                <!-- beginswith-->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="beginswith"/>
                    <objectCreateExpression type="TextMatchingFilterFunction">
                      <parameters>
                        <primitiveExpression value="{{0}}%"/>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <!-- doesnotbeginwith-->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="doesnotbeginwith"/>
                    <objectCreateExpression type="NegativeTextMatchingFilterFunction">
                      <parameters>
                        <primitiveExpression value="{{0}}%"/>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <!-- contains-->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="contains"/>
                    <objectCreateExpression type="TextMatchingFilterFunction">
                      <parameters>
                        <primitiveExpression value="%{{0}}%"/>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <!-- doesnotcontain-->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="doesnotcontain"/>
                    <objectCreateExpression type="NegativeTextMatchingFilterFunction">
                      <parameters>
                        <primitiveExpression value="%{{0}}%"/>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <!-- endswith-->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="endswith"/>
                    <objectCreateExpression type="TextMatchingFilterFunction">
                      <parameters>
                        <primitiveExpression value="%{{0}}"/>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <!-- doesnotendwith-->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'doesnotendwith'"/>
                  <xsl:with-param name="Type" select="'NegativeTextMatchingFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'%{0}'"/>
                </xsl:call-template>
                <!-- between -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'between'"/>
                  <xsl:with-param name="Type" select="'BetweenFilterFunction'"/>
                </xsl:call-template>
                <!-- in -->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="in"/>
                    <objectCreateExpression type="InFilterFunction"/>
                  </parameters>
                </methodInvokeExpression>
                <!-- notin -->
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="All"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="notin"/>
                    <objectCreateExpression type="NotInFilterFunction"/>
                  </parameters>
                </methodInvokeExpression>
                <!-- month N -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month1'"/>
                  <xsl:with-param name="Arg" select="1"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month2'"/>
                  <xsl:with-param name="Arg" select="2"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month3'"/>
                  <xsl:with-param name="Arg" select="3"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month4'"/>
                  <xsl:with-param name="Arg" select="4"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month5'"/>
                  <xsl:with-param name="Arg" select="5"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month6'"/>
                  <xsl:with-param name="Arg" select="6"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month7'"/>
                  <xsl:with-param name="Arg" select="7"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month8'"/>
                  <xsl:with-param name="Arg" select="8"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month9'"/>
                  <xsl:with-param name="Arg" select="9"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month10'"/>
                  <xsl:with-param name="Arg" select="10"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month11'"/>
                  <xsl:with-param name="Arg" select="11"/>
                </xsl:call-template>
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'month12'"/>
                  <xsl:with-param name="Arg" select="12"/>
                </xsl:call-template>
                <!-- thismonth -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'thismonth'"/>
                  <xsl:with-param name="Type" select="'ThisMonthFilterFunction'"/>
                  <xsl:with-param name="Arg" select="0"/>
                </xsl:call-template>
                <!-- nextmonth -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'nextmonth'"/>
                  <xsl:with-param name="Type" select="'ThisMonthFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'+1'"/>
                </xsl:call-template>
                <!-- lastmonth -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'lastmonth'"/>
                  <xsl:with-param name="Type" select="'ThisMonthFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'-1'"/>
                </xsl:call-template>
                <!-- quarter1 -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'quarter1'"/>
                  <xsl:with-param name="Type" select="'QuarterFilterFunction'"/>
                  <xsl:with-param name="Arg" select="1"/>
                </xsl:call-template>
                <!-- quarter2 -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'quarter2'"/>
                  <xsl:with-param name="Type" select="'QuarterFilterFunction'"/>
                  <xsl:with-param name="Arg" select="2"/>
                </xsl:call-template>
                <!-- quarter3 -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'quarter3'"/>
                  <xsl:with-param name="Type" select="'QuarterFilterFunction'"/>
                  <xsl:with-param name="Arg" select="3"/>
                </xsl:call-template>
                <!-- quarter4 -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'quarter4'"/>
                  <xsl:with-param name="Type" select="'QuarterFilterFunction'"/>
                  <xsl:with-param name="Arg" select="4"/>
                </xsl:call-template>
                <!-- thisquarter -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'thisquarter'"/>
                  <xsl:with-param name="Type" select="'ThisQuarterFilterFunction'"/>
                  <xsl:with-param name="Arg" select="0"/>
                </xsl:call-template>
                <!-- lastquarter -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'lastquarter'"/>
                  <xsl:with-param name="Type" select="'ThisQuarterFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'-1'"/>
                </xsl:call-template>
                <!-- nextquarter -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'nextquarter'"/>
                  <xsl:with-param name="Type" select="'ThisQuarterFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'+1'"/>
                </xsl:call-template>
                <!-- thisyear -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'thisyear'"/>
                  <xsl:with-param name="Type" select="'ThisYearFilterFunction'"/>
                  <xsl:with-param name="Arg" select="0"/>
                </xsl:call-template>
                <!-- lastyear -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'lastyear'"/>
                  <xsl:with-param name="Type" select="'ThisYearFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'-1'"/>
                </xsl:call-template>
                <!-- nextyear -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'nextyear'"/>
                  <xsl:with-param name="Type" select="'ThisYearFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'+1'"/>
                </xsl:call-template>
                <!-- yeartodate -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'yeartodate'"/>
                  <xsl:with-param name="Type" select="'YearToDateFilterFunction'"/>
                </xsl:call-template>
                <!-- thisweek -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'thisweek'"/>
                  <xsl:with-param name="Type" select="'ThisWeekFilterFunction'"/>
                  <xsl:with-param name="Arg" select="0"/>
                </xsl:call-template>
                <!-- lastweek -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'lastweek'"/>
                  <xsl:with-param name="Type" select="'ThisWeekFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'-1'"/>
                </xsl:call-template>
                <!-- nextweek -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'nextweek'"/>
                  <xsl:with-param name="Type" select="'ThisWeekFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'+1'"/>
                </xsl:call-template>
                <!-- today -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'today'"/>
                  <xsl:with-param name="Type" select="'TodayFilterFunction'"/>
                  <xsl:with-param name="Arg" select="0"/>
                </xsl:call-template>
                <!-- yesterday -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'yesterday'"/>
                  <xsl:with-param name="Type" select="'TodayFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'-1'"/>
                </xsl:call-template>
                <!-- tomorrow -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'tomorrow'"/>
                  <xsl:with-param name="Type" select="'TodayFilterFunction'"/>
                  <xsl:with-param name="Arg" select="'+1'"/>
                </xsl:call-template>
                <!-- past -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'past'"/>
                  <xsl:with-param name="Type" select="'PastFilterFunction'"/>
                </xsl:call-template>
                <!-- future -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'future'"/>
                  <xsl:with-param name="Type" select="'FutureFilterFunction'"/>
                </xsl:call-template>
                <!-- true -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'true'"/>
                  <xsl:with-param name="Type" select="'TrueFilterFunction'"/>
                </xsl:call-template>
                <!-- false -->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'false'"/>
                  <xsl:with-param name="Type" select="'FalseFilterFunction'"/>
                </xsl:call-template>
                <!-- isempty-->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'isempty'"/>
                  <xsl:with-param name="Type" select="'IsEmptyFilterFunction'"/>
                </xsl:call-template>
                <!-- isnotempty-->
                <xsl:call-template name="RegisterFunction">
                  <xsl:with-param name="Key" select="'isnotempty'"/>
                  <xsl:with-param name="Type" select="'IsNotEmptyFilterFunction'"/>
                </xsl:call-template>
              </statements>
            </typeConstructor>
            <!-- constructor(DbCommand, SelectClauseDictionary, string) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="filter"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="command">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="command"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="filter">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="filter"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="expressions">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="expressions"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- method Replace(DbCommand, expressions, string) -->
            <memberMethod returnType="System.String" name="Replace">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="filter"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="FilterFunctions" name="functions">
                  <init>
                    <objectCreateExpression type="FilterFunctions">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                        <argumentReferenceExpression name="expressions"/>
                        <argumentReferenceExpression name="filter"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ToString">
                    <target>
                      <variableReferenceExpression name="functions"/>
                    </target>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ToString() -->
            <memberMethod returnType="System.String" name="ToString">
              <attributes public="true" override="true"/>
              <statements>
                <variableDeclarationStatement type="System.String" name="filter">
                  <init>
                    <methodInvokeExpression methodName="Replace">
                      <target>
                        <typeReferenceExpression type="Regex"/>
                      </target>
                      <parameters>
                        <fieldReferenceExpression name="filter">
                          <thisReferenceExpression/>
                        </fieldReferenceExpression>
                        <primitiveExpression>
                          <xsl:attribute name="value"><![CDATA[\$((?'Name'\w+)\s*\((?'Arguments'[\s\S]*?)\)\s*)]]></xsl:attribute>
                        </primitiveExpression>
                        <addressOfExpression>
                          <methodReferenceExpression methodName="DoReplaceFunctions"/>
                        </addressOfExpression>
                        <!--<propertyReferenceExpression name="Compiled">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>-->
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="filter"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method DoReplaceFunctions(Match) -->
            <memberMethod returnType="System.String" name="DoReplaceFunctions">
              <attributes private="true"/>
              <parameters>
                <parameter type="Match" name="m"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="({{0}})"/>
                      <methodInvokeExpression methodName="ExpandWith">
                        <target>
                          <arrayIndexerExpression>
                            <target>
                              <propertyReferenceExpression name="All"/>
                            </target>
                            <indices>
                              <methodInvokeExpression methodName="ToLower">
                                <target>
                                  <propertyReferenceExpression name="Value">
                                    <arrayIndexerExpression>
                                      <target>
                                        <propertyReferenceExpression name="Groups">
                                          <argumentReferenceExpression name="m"/>
                                        </propertyReferenceExpression>
                                      </target>
                                      <indices>
                                        <primitiveExpression value="Name"/>
                                      </indices>
                                    </arrayIndexerExpression>
                                  </propertyReferenceExpression>
                                </target>
                              </methodInvokeExpression>
                            </indices>
                          </arrayIndexerExpression>
                        </target>
                        <parameters>
                          <fieldReferenceExpression name="command"/>
                          <fieldReferenceExpression name="expressions"/>
                          <propertyReferenceExpression name="Value">
                            <arrayIndexerExpression>
                              <target>
                                <propertyReferenceExpression name="Groups">
                                  <argumentReferenceExpression name="m"/>
                                </propertyReferenceExpression>
                              </target>
                              <indices>
                                <primitiveExpression value="Arguments"/>
                              </indices>
                            </arrayIndexerExpression>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class FilterFunctionBase -->
        <typeDeclaration name="FilterFunctionBase">
          <members>
            <!-- constructor -->
            <constructor>
              <attributes public="true"/>
            </constructor>
            <!-- property YearsBack -->
            <memberProperty type="System.Int32" name="YearsBack">
              <attributes public="true"/>
              <getStatements>
                <methodReturnStatement>
                  <xsl:choose>
                    <xsl:when test="contains(/a:project/a:connectionString, 'Initial Catalog=Northwind') or contains(/a:project/a:connectionString, 'Initial Catalog=northwind')">
                      <primitiveExpression value="16"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <primitiveExpression value="5"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property YearsForward -->
            <memberProperty type="System.Int32" name="YearsForward">
              <attributes public="true"/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="1"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- mehtod ExpandWith(DbCommand, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <propertyReferenceExpression name="Empty">
                    <typeReferenceExpression type="String"/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateParameter(DbCommand command) -->
            <memberMethod returnType="DbParameter" name="CreateParameter">
              <attributes family="true" final="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <target>
                        <variableReferenceExpression name="command"/>
                      </target>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <!-- 
            string marker = "@";
            if (p.GetType().FullName.Contains("Oracle"))
                marker = ":";                -->
                <variableDeclarationStatement type="System.String" name="marker">
                  <init>
                    <!--<primitiveExpression value="@"/>-->
                    <methodInvokeExpression methodName="ConvertTypeToParameterMarker">
                      <target>
                        <typeReferenceExpression type="SqlStatement"/>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="GetType">
                          <target>
                            <variableReferenceExpression name="p"/>
                          </target>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <!--<conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Contains">
                      <target>
                        <propertyReferenceExpression name="FullName">
                          <methodInvokeExpression methodName="GetType">
                            <target>
                              <variableReferenceExpression name="p"/>
                            </target>
                          </methodInvokeExpression>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="Oracle"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="marker"/>
                      <primitiveExpression value=":"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>-->
                <assignStatement>
                  <propertyReferenceExpression name="ParameterName">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <binaryOperatorExpression operator="Add">
                    <binaryOperatorExpression operator="Add">
                      <variableReferenceExpression name="marker"/>
                      <primitiveExpression value="p"/>
                    </binaryOperatorExpression>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <propertyReferenceExpression name="Count">
                          <propertyReferenceExpression name="Parameters">
                            <argumentReferenceExpression name="command"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                      </target>
                    </methodInvokeExpression>
                  </binaryOperatorExpression>
                </assignStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Parameters">
                      <argumentReferenceExpression name="command"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="p"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <variableReferenceExpression name="p"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- string FirstArgument(string) -->
            <memberMethod returnType="System.String" name="FirstArgument">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="Match" name="m">
                  <init>
                    <methodInvokeExpression methodName="Match">
                      <target>
                        <typeReferenceExpression type="Regex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="arguments"/>
                        <primitiveExpression>
                          <xsl:attribute name="value"><![CDATA[^\s*(\w+)\s*(,|\$comma\$)?]]></xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <methodReturnStatement>
                  <propertyReferenceExpression name="Value">
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Groups">
                          <variableReferenceExpression name="m"/>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="1"/>
                      </indices>
                    </arrayIndexerExpression>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ExtractArgument(string, int) -->
            <memberMethod returnType="System.String" name="ExtractArgument">
              <attributes family="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="arguments"/>
                <parameter type="System.Int32" name="index"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="Match" name="m">
                  <init>
                    <methodInvokeExpression methodName="Match">
                      <target>
                        <typeReferenceExpression type="Regex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="arguments"/>
                        <primitiveExpression>
                          <xsl:attribute name="value"><![CDATA[^\s*(\w+)\s*(,|\$comma\$)\s*([\s\S]*?)\s*$]]></xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="s">
                  <init>
                    <propertyReferenceExpression name="Value">
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Groups">
                            <variableReferenceExpression name="m"/>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="3"/>
                        </indices>
                      </arrayIndexerExpression>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Value">
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Groups">
                              <variableReferenceExpression name="m"/>
                            </propertyReferenceExpression>
                          </target>
                          <indices>
                            <primitiveExpression value="2"/>
                          </indices>
                        </arrayIndexerExpression>
                      </propertyReferenceExpression>
                      <primitiveExpression value="$comma$"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="s"/>
                      <methodInvokeExpression methodName="GetString">
                        <target>
                          <propertyReferenceExpression name="UTF8">
                            <typeReferenceExpression type="Encoding"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <methodInvokeExpression methodName="FromBase64String">
                            <target>
                              <typeReferenceExpression type="Convert"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="s"/>
                            </parameters>
                          </methodInvokeExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <assignStatement>
                  <variableReferenceExpression name="m"/>
                  <methodInvokeExpression methodName="Match">
                    <target>
                      <typeReferenceExpression type="Regex"/>
                    </target>
                    <parameters>
                      <variableReferenceExpression name="s"/>
                      <primitiveExpression>
                        <xsl:attribute name="value"><![CDATA[^([\s\S]*?)\$and\$([\s\S]*?)$]]></xsl:attribute>
                      </primitiveExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="Success">
                      <variableReferenceExpression name="m"/>
                    </propertyReferenceExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <propertyReferenceExpression name="Value">
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Groups">
                              <variableReferenceExpression name="m"/>
                            </propertyReferenceExpression>
                          </target>
                          <indices>
                            <argumentReferenceExpression name="index"/>
                          </indices>
                        </arrayIndexerExpression>
                      </propertyReferenceExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="s"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- string SecondArgument(string) -->
            <memberMethod returnType="System.String" name="SecondArgument">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ExtractArgument">
                    <parameters>
                      <argumentReferenceExpression name="arguments"/>
                      <primitiveExpression value="1"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- string ThirdArgument(string) -->
            <memberMethod returnType="System.String" name="ThirdArgument">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ExtractArgument">
                    <parameters>
                      <argumentReferenceExpression name="arguments"/>
                      <primitiveExpression value="2"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class UserNameFilterFunction -->
        <typeDeclaration name="UserNameFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- method ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="Name">
                    <propertyReferenceExpression name="Identity">
                      <propertyReferenceExpression name="User">
                        <propertyReferenceExpression name="Current">
                          <typeReferenceExpression type="HttpContext"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                    </propertyReferenceExpression>
                  </propertyReferenceExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="arguments"/>
										</unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <propertyReferenceExpression name="ParameterName">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="{{0}}={{1}}"/>
                      <argumentReferenceExpression name="arguments"/>
                      <propertyReferenceExpression name="ParameterName">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class UserIdFilterFunction -->
        <typeDeclaration name="UserIdFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- method ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="ProviderUserKey">
                    <methodInvokeExpression methodName="GetUser">
                      <target>
                        <typeReferenceExpression type="Membership"/>
                      </target>
                    </methodInvokeExpression>
                  </propertyReferenceExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="arguments"/>
										</unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <propertyReferenceExpression name="ParameterName">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="{{0}}={{1}}"/>
                      <argumentReferenceExpression name="arguments"/>
                      <propertyReferenceExpression name="ParameterName">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- TextMatchingFilterFunction -->
        <typeDeclaration name="TextMatchingFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <memberField type="System.String" name="pattern"/>
            <!-- constructor(string)-->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="pattern"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="pattern">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="pattern"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- ExpandWith -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <fieldReferenceExpression name="pattern"/>
                      <methodInvokeExpression methodName="EscapePattern">
                        <target>
                          <typeReferenceExpression type="SqlStatement"/>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="command"/>
                          <methodInvokeExpression methodName="ToString">
                            <target>
                              <typeReferenceExpression type="Convert"/>
                            </target>
                            <parameters>
                              <methodInvokeExpression methodName="StringToValue">
                                <target>
                                  <typeReferenceExpression type="Controller"/>
                                </target>
                                <parameters>
                                  <methodInvokeExpression methodName="SecondArgument">
                                    <parameters>
                                      <argumentReferenceExpression name="arguments"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="{{0}} like {{1}}"/>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="expressions"/>
                        </target>
                        <indices>
                          <methodInvokeExpression methodName="FirstArgument">
                            <parameters>
                              <argumentReferenceExpression name="arguments"/>
                            </parameters>
                          </methodInvokeExpression>
                        </indices>
                      </arrayIndexerExpression>
                      <propertyReferenceExpression name="ParameterName">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class NegativeTextMatchingFilterFunction -->
        <typeDeclaration name="NegativeTextMatchingFilterFunction">
          <baseTypes>
            <typeReference type="TextMatchingFilterFunction"/>
          </baseTypes>
          <members>
            <!-- constructor (string) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="pattern"/>
              </parameters>
              <baseConstructorArgs>
                <argumentReferenceExpression name="pattern"/>
              </baseConstructorArgs>
            </constructor>
            <!-- string ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="not({{0}})"/>
                      <methodInvokeExpression methodName="ExpandWith">
                        <target>
                          <baseReferenceExpression/>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="command"/>
                          <argumentReferenceExpression name="expressions"/>
                          <argumentReferenceExpression name="arguments"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class BetweenFilterFunction -->
        <typeDeclaration name="BetweenFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- string ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="StringToValue">
                    <target>
                      <typeReferenceExpression type="Controller"/>
                    </target>
                    <parameters>
                      <methodInvokeExpression methodName="SecondArgument">
                        <parameters>
                          <argumentReferenceExpression name="arguments"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <variableDeclarationStatement type="DbParameter" name="p2">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p2"/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="StringToValue">
                    <target>
                      <typeReferenceExpression type="Controller"/>
                    </target>
                    <parameters>
                      <methodInvokeExpression methodName="ThirdArgument">
                        <parameters>
                          <argumentReferenceExpression name="arguments"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="ContainsKey">
                      <target>
                        <argumentReferenceExpression name="expressions"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="_DataView_RowFilter_"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="{{0}} >= {{1}} and {{0}} &lt;= {{2}}"/>
                          <arrayIndexerExpression>
                            <target>
                              <argumentReferenceExpression name="expressions"/>
                            </target>
                            <indices>
                              <methodInvokeExpression methodName="FirstArgument">
                                <parameters>
                                  <argumentReferenceExpression name="arguments"/>
                                </parameters>
                              </methodInvokeExpression>
                            </indices>
                          </arrayIndexerExpression>
                          <propertyReferenceExpression name="ParameterName">
                            <variableReferenceExpression name="p"/>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="ParameterName">
                            <variableReferenceExpression name="p2"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="{{0}} between {{1}} and {{2}}"/>
                          <arrayIndexerExpression>
                            <target>
                              <argumentReferenceExpression name="expressions"/>
                            </target>
                            <indices>
                              <methodInvokeExpression methodName="FirstArgument">
                                <parameters>
                                  <argumentReferenceExpression name="arguments"/>
                                </parameters>
                              </methodInvokeExpression>
                            </indices>
                          </arrayIndexerExpression>
                          <propertyReferenceExpression name="ParameterName">
                            <variableReferenceExpression name="p"/>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="ParameterName">
                            <variableReferenceExpression name="p2"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class InFilterFunction -->
        <typeDeclaration name="InFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="fieldExpression">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <argumentReferenceExpression name="expressions"/>
                      </target>
                      <indices>
                        <methodInvokeExpression methodName="FirstArgument">
                          <parameters>
                            <argumentReferenceExpression name="arguments"/>
                          </parameters>
                        </methodInvokeExpression>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="StringBuilder" name="sb">
                  <init>
                    <objectCreateExpression type="StringBuilder">
                      <parameters>
                        <variableReferenceExpression name="fieldExpression"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Append">
                  <target>
                    <variableReferenceExpression name="sb"/>
                  </target>
                  <parameters>
                    <primitiveExpression value=" in ("/>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="System.String[]" name="list">
                  <init>
                    <methodInvokeExpression methodName="Split">
                      <target>
                        <methodInvokeExpression methodName="SecondArgument">
                          <parameters>
                            <argumentReferenceExpression name="arguments"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <arrayCreateExpression>
                          <createType type="System.String"/>
                          <initializers>
                            <primitiveExpression value="$or$"/>
                          </initializers>
                        </arrayCreateExpression>
                        <propertyReferenceExpression name="RemoveEmptyEntries">
                          <typeReferenceExpression type="StringSplitOptions"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasNull">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasValues">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="System.String" name="v"/>
                  <target>
                    <variableReferenceExpression name="list"/>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="StringIsNull">
                          <target>
                            <typeReferenceExpression type="Controller"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="v"/>
                          </parameters>
                        </methodInvokeExpression>
                        <!--<binaryOperatorExpression operator="ValueEquality">
                          <variableReferenceExpression name="v"/>
                          <primitiveExpression value="null" convertTo="String"/>
                        </binaryOperatorExpression>-->
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="hasNull"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <conditionStatement>
                          <condition>
                            <variableReferenceExpression name="hasValues"/>
                          </condition>
                          <trueStatements>
                            <methodInvokeExpression methodName="Append">
                              <target>
                                <variableReferenceExpression name="sb"/>
                              </target>
                              <parameters>
                                <primitiveExpression value=","/>
                              </parameters>
                            </methodInvokeExpression>
                          </trueStatements>
                          <falseStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasValues"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                          </falseStatements>
                        </conditionStatement>
                        <variableDeclarationStatement type="DbParameter" name="p">
                          <init>
                            <methodInvokeExpression methodName="CreateParameter">
                              <parameters>
                                <argumentReferenceExpression name="command"/>
                              </parameters>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <!--<variableDeclarationStatement type="System.Decimal" name="decimalValue"/>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="TryParse">
                              <target>
                                <typeReferenceExpression type="Decimal"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="v"/>
                                <directionExpression direction="Out">
                                  <variableReferenceExpression name="decimalValue"/>
                                </directionExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <propertyReferenceExpression name="Value">
                                <variableReferenceExpression name="p"/>
                              </propertyReferenceExpression>
                              <variableReferenceExpression name="decimalValue"/>
                            </assignStatement>
                          </trueStatements>
                          <falseStatements>
                            <assignStatement>
                              <propertyReferenceExpression name="Value">
                                <variableReferenceExpression name="p"/>
                              </propertyReferenceExpression>
                              <variableReferenceExpression name="v"/>
                            </assignStatement>
                          </falseStatements>
                        </conditionStatement>-->
                        <assignStatement>
                          <propertyReferenceExpression name="Value">
                            <variableReferenceExpression name="p"/>
                          </propertyReferenceExpression>
                          <methodInvokeExpression methodName="StringToValue">
                            <target>
                              <typeReferenceExpression type="Controller"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="v"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                        <methodInvokeExpression methodName="Append">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="ParameterName">
                              <variableReferenceExpression name="p"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodInvokeExpression methodName="Append">
                  <target>
                    <variableReferenceExpression name="sb"/>
                  </target>
                  <parameters>
                    <primitiveExpression value=")"/>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <variableReferenceExpression name="hasNull"/>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <variableReferenceExpression name="hasValues"/>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <methodInvokeExpression methodName="Format">
                            <target>
                              <typeReferenceExpression type="String"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="({{0}} is null) or ({{1}})"/>
                              <variableReferenceExpression name="fieldExpression"/>
                              <methodInvokeExpression methodName="ToString">
                                <target>
                                  <variableReferenceExpression name="sb"/>
                                </target>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </methodReturnStatement>
                      </trueStatements>
                      <falseStatements>
                        <methodReturnStatement>
                          <methodInvokeExpression methodName="Format">
                            <target>
                              <typeReferenceExpression type="String"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="{{0}} is null"/>
                              <variableReferenceExpression name="fieldExpression"/>
                            </parameters>
                          </methodInvokeExpression>
                        </methodReturnStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="ToString">
                        <target>
                          <variableReferenceExpression name="sb"/>
                        </target>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class NotInFilterFunction -->
        <typeDeclaration name="NotInFilterFunction">
          <baseTypes>
            <typeReference type="InFilterFunction"/>
          </baseTypes>
          <members>
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String[]" name="list">
                  <init>
                    <methodInvokeExpression methodName="Split">
                      <target>
                        <methodInvokeExpression methodName="SecondArgument">
                          <parameters>
                            <argumentReferenceExpression name="arguments"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <arrayCreateExpression>
                          <createType type="System.String"/>
                          <initializers>
                            <primitiveExpression value="$or$"/>
                          </initializers>
                        </arrayCreateExpression>
                        <propertyReferenceExpression name="RemoveEmptyEntries">
                          <typeReferenceExpression type="StringSplitOptions"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="filter">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="not({{0}})"/>
                        <methodInvokeExpression methodName="ExpandWith">
                          <target>
                            <baseReferenceExpression/>
                          </target>
                          <parameters>
                            <argumentReferenceExpression name="command"/>
                            <argumentReferenceExpression name="expressions"/>
                            <argumentReferenceExpression name="arguments"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <methodInvokeExpression methodName="IndexOf">
                        <target>
                          <typeReferenceExpression type="Array"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="list"/>
                          <primitiveExpression value="null" convertTo="String"/>
                        </parameters>
                      </methodInvokeExpression>
                      <primitiveExpression value="-1"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="filter"/>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="({{0}}) or {{1}} is null"/>
                          <variableReferenceExpression name="filter"/>
                          <arrayIndexerExpression>
                            <target>
                              <argumentReferenceExpression name="expressions"/>
                            </target>
                            <indices>
                              <methodInvokeExpression methodName="FirstArgument">
                                <parameters>
                                  <argumentReferenceExpression name="arguments"/>
                                </parameters>
                              </methodInvokeExpression>
                            </indices>
                          </arrayIndexerExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="filter"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class DateRangeFilterFunction -->
        <typeDeclaration name="DateRangeFilterFunction" isPartial="true">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- property Month -->
            <memberField type="System.Int32" name="month"/>
            <memberProperty type="System.Int32" name="Month">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="month"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- field startYear-->
            <memberField type="System.Int32" name="startYear"/>
            <!-- field endYear -->
            <memberField type="System.Int32" name="endYear"/>
            <!-- constructor(int) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.Int32" name="month"/>
              </parameters>
              <chainedConstructorArgs>
                <argumentReferenceExpression name="month"/>
                <primitiveExpression value="-1"/>
                <primitiveExpression value="-1"/>
              </chainedConstructorArgs>
            </constructor>
            <!-- constructor -->
            <constructor>
              <attributes public="true"/>
              <chainedConstructorArgs>
                <primitiveExpression value="0"/>
                <primitiveExpression value="0"/>
                <primitiveExpression value="0"/>
              </chainedConstructorArgs>
            </constructor>
            <!-- constructor (int, int, int) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.Int32" name="month"/>
                <parameter type="System.Int32" name="startYear"/>
                <parameter type="System.Int32" name="endYear"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="month">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="month"/>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <argumentReferenceExpression name="startYear"/>
                      <primitiveExpression value="-1"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <argumentReferenceExpression name="startYear"/>
                      <propertyReferenceExpression name="YearsBack"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <assignStatement>
                  <fieldReferenceExpression name="startYear">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="startYear"/>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <argumentReferenceExpression name="endYear"/>
                      <primitiveExpression value="-1"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <argumentReferenceExpression name="endYear"/>
                      <propertyReferenceExpression name="YearsForward"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <assignStatement>
                  <fieldReferenceExpression name="endYear">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="endYear"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- string ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="StringBuilder" name="sb">
                  <init>
                    <objectCreateExpression type="StringBuilder"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Int32" name="currentYear">
                  <init>
                    <propertyReferenceExpression name="Year">
                      <propertyReferenceExpression name="Today">
                        <typeReferenceExpression type="DateTime"/>
                      </propertyReferenceExpression>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <forStatement>
                  <variable type="System.Int32" name="i">
                    <init>
                      <binaryOperatorExpression operator="Subtract">
                        <argumentReferenceExpression name="currentYear"/>
                        <fieldReferenceExpression name="startYear"/>
                      </binaryOperatorExpression>
                    </init>
                  </variable>
                  <test>
                    <binaryOperatorExpression operator="LessThanOrEqual">
                      <variableReferenceExpression name="i"/>
                      <binaryOperatorExpression operator="Add">
                        <argumentReferenceExpression name="currentYear"/>
                        <fieldReferenceExpression  name="endYear"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </test>
                  <increment>
                    <variableReferenceExpression name="i"/>
                  </increment>
                  <statements>
                    <variableDeclarationStatement type="DbParameter" name="p">
                      <init>
                        <methodInvokeExpression methodName="CreateParameter">
                          <parameters>
                            <argumentReferenceExpression name="command"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="DbParameter" name="p2">
                      <init>
                        <methodInvokeExpression methodName="CreateParameter">
                          <parameters>
                            <argumentReferenceExpression name="command"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="DateTime" name="startDate"/>
                    <variableDeclarationStatement type="DateTime" name="endDate"/>
                    <methodInvokeExpression methodName="AssignRange">
                      <parameters>
                        <variableReferenceExpression name="i"/>
                        <directionExpression direction="Out">
                          <variableReferenceExpression name="startDate"/>
                        </directionExpression>
                        <directionExpression direction="Out">
                          <variableReferenceExpression name="endDate"/>
                        </directionExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <propertyReferenceExpression name="Value">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                      <variableReferenceExpression name="startDate"/>
                    </assignStatement>
                    <assignStatement>
                      <propertyReferenceExpression name="Value">
                        <variableReferenceExpression name="p2"/>
                      </propertyReferenceExpression>
                      <variableReferenceExpression name="endDate"/>
                    </assignStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="GreaterThan">
                          <propertyReferenceExpression name="Length">
                            <variableReferenceExpression name="sb"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Append">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="or"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="ContainsKey">
                          <target>
                            <argumentReferenceExpression name="expressions"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="_DataView_RowFilter_"/>
                          </parameters>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AppendFormat">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="({{0}} >= {{1}} and {{0}} &lt;= {{2}})"/>
                            <arrayIndexerExpression>
                              <target>
                                <argumentReferenceExpression name="expressions"/>
                              </target>
                              <indices>
                                <methodInvokeExpression methodName="FirstArgument">
                                  <parameters>
                                    <argumentReferenceExpression name="arguments"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </indices>
                            </arrayIndexerExpression>
                            <propertyReferenceExpression name="ParameterName">
                              <variableReferenceExpression name="p"/>
                            </propertyReferenceExpression>
                            <propertyReferenceExpression name="ParameterName">
                              <variableReferenceExpression name="p2"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                      <falseStatements>
                        <methodInvokeExpression methodName="AppendFormat">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="({{0}} between {{1}} and {{2}})"/>
                            <arrayIndexerExpression>
                              <target>
                                <argumentReferenceExpression name="expressions"/>
                              </target>
                              <indices>
                                <methodInvokeExpression methodName="FirstArgument">
                                  <parameters>
                                    <argumentReferenceExpression name="arguments"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </indices>
                            </arrayIndexerExpression>
                            <propertyReferenceExpression name="ParameterName">
                              <variableReferenceExpression name="p"/>
                            </propertyReferenceExpression>
                            <propertyReferenceExpression name="ParameterName">
                              <variableReferenceExpression name="p2"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </forStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ToString">
                    <target>
                      <variableReferenceExpression name="sb"/>
                    </target>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- void AssignRange(int, DateTime, DateTime) -->
            <memberMethod name="AssignRange">
              <attributes family="true"/>
              <parameters>
                <parameter type="System.Int32" name="year"/>
                <parameter type="DateTime" name="startDate" direction="Out"/>
                <parameter type="DateTime" name="endDate" direction="Out"/>
              </parameters>
              <statements>
                <assignStatement>
                  <argumentReferenceExpression name="startDate"/>
                  <objectCreateExpression type="DateTime">
                    <parameters>
                      <argumentReferenceExpression name="year"/>
                      <propertyReferenceExpression name="Month"/>
                      <primitiveExpression value="1"/>
                    </parameters>
                  </objectCreateExpression>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="endDate"/>
                  <methodInvokeExpression methodName="AddSeconds">
                    <target>
                      <methodInvokeExpression methodName="AddMonths">
                        <target>
                          <argumentReferenceExpression name="startDate"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="1"/>
                        </parameters>
                      </methodInvokeExpression>
                    </target>
                    <parameters>
                      <primitiveExpression value="-1"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class ThisMonthFilterFunction -->
        <typeDeclaration name="ThisMonthFilterFunction">
          <baseTypes>
            <typeReference type="DateRangeFilterFunction"/>
          </baseTypes>
          <members>
            <memberField type="System.Int32" name="deltaMonth"/>
            <!-- costructor(int) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.Int32" name="deltaMonth"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="deltaMonth">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="deltaMonth"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- void AssignRange(int, DateTime, DateTime) -->
            <memberMethod name="AssignRange">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="System.Int32" name="year"/>
                <parameter type="DateTime" name="startDate" direction="Out"/>
                <parameter type="DateTime" name="endDate" direction="Out"/>
              </parameters>
              <statements>
                <assignStatement>
                  <argumentReferenceExpression name="startDate"/>
                  <methodInvokeExpression methodName="AddMonths">
                    <target>
                      <objectCreateExpression type="DateTime">
                        <parameters>
                          <argumentReferenceExpression name="year"/>
                          <propertyReferenceExpression name="Month">
                            <propertyReferenceExpression name="Today">
                              <typeReferenceExpression type="DateTime"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <primitiveExpression value="1"/>
                        </parameters>
                      </objectCreateExpression>
                    </target>
                    <parameters>
                      <fieldReferenceExpression name="deltaMonth"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="endDate"/>
                  <methodInvokeExpression methodName="AddSeconds">
                    <target>
                      <methodInvokeExpression methodName="AddMonths">
                        <target>
                          <argumentReferenceExpression name="startDate"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="1"/>
                        </parameters>
                      </methodInvokeExpression>
                    </target>
                    <parameters>
                      <primitiveExpression value="-1"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class QuarterFilterFunction -->
        <typeDeclaration name="QuarterFilterFunction">
          <baseTypes>
            <typeReference type="DateRangeFilterFunction"/>
          </baseTypes>
          <members>
            <!-- constructor(int) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.Int32" name="quarter"/>
              </parameters>
              <baseConstructorArgs>
                <binaryOperatorExpression operator="Add">
                  <binaryOperatorExpression operator="Multiply">
                    <binaryOperatorExpression operator="Subtract">
                      <argumentReferenceExpression name="quarter"/>
                      <primitiveExpression value="1"/>
                    </binaryOperatorExpression>
                    <primitiveExpression value="3"/>
                  </binaryOperatorExpression>
                  <primitiveExpression value="1"/>
                </binaryOperatorExpression>
              </baseConstructorArgs>
            </constructor>
            <!-- void AssignRange(int, DateTime, DateTime) -->
            <memberMethod name="AssignRange">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="System.Int32" name="year"/>
                <parameter type="DateTime" name="startDate" direction="Out"/>
                <parameter type="DateTime" name="endDate" direction="Out"/>
              </parameters>
              <statements>
                <assignStatement>
                  <argumentReferenceExpression name="startDate"/>
                  <objectCreateExpression type="DateTime">
                    <parameters>
                      <argumentReferenceExpression name="year"/>
                      <propertyReferenceExpression name="Month"/>
                      <primitiveExpression value="1"/>
                    </parameters>
                  </objectCreateExpression>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="endDate"/>
                  <methodInvokeExpression methodName="AddSeconds">
                    <target>
                      <methodInvokeExpression methodName="AddMonths">
                        <target>
                          <argumentReferenceExpression name="startDate"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="3"/>
                        </parameters>
                      </methodInvokeExpression>
                    </target>
                    <parameters>
                      <primitiveExpression value="-1"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class ThisQuarterFitlerFunction -->
        <typeDeclaration name="ThisQuarterFilterFunction">
          <baseTypes>
            <typeReference type="DateRangeFilterFunction"/>
          </baseTypes>
          <members>
            <memberField type="System.Int32" name="deltaQuarter"/>
            <!-- constructor(int) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.Int32" name="deltaQuarter"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="deltaQuarter">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="deltaQuarter"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- void AssignRange(int, DateTime, DateTime) -->
            <memberMethod name="AssignRange">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="System.Int32" name="year"/>
                <parameter type="DateTime" name="startDate" direction="Out"/>
                <parameter type="DateTime" name="endDate" direction="Out"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.Int32" name="month">
                  <init>
                    <propertyReferenceExpression name="Month">
                      <propertyReferenceExpression name="Today">
                        <typeReferenceExpression type="DateTime"/>
                      </propertyReferenceExpression>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <whileStatement>
                  <test>
                    <binaryOperatorExpression operator="ValueInequality">
                      <binaryOperatorExpression operator="Modulus">
                        <variableReferenceExpression name="month"/>
                        <primitiveExpression value="3"/>
                      </binaryOperatorExpression>
                      <primitiveExpression value="1"/>
                    </binaryOperatorExpression>
                  </test>
                  <statements>
                    <assignStatement>
                      <variableReferenceExpression name="month"/>
                      <binaryOperatorExpression operator="Subtract">
                        <variableReferenceExpression name="month"/>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </assignStatement>
                  </statements>
                </whileStatement>
                <assignStatement>
                  <argumentReferenceExpression name="startDate"/>
                  <methodInvokeExpression methodName="AddMonths">
                    <target>
                      <objectCreateExpression type="DateTime">
                        <parameters>
                          <argumentReferenceExpression name="year"/>
                          <variableReferenceExpression name="month"/>
                          <primitiveExpression value="1"/>
                        </parameters>
                      </objectCreateExpression>
                    </target>
                    <parameters>
                      <binaryOperatorExpression operator="Multiply">
                        <fieldReferenceExpression name="deltaQuarter"/>
                        <primitiveExpression value="3"/>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="endDate"/>
                  <methodInvokeExpression methodName="AddSeconds">
                    <target>
                      <methodInvokeExpression methodName="AddMonths">
                        <target>
                          <argumentReferenceExpression name="startDate"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="3"/>
                        </parameters>
                      </methodInvokeExpression>
                    </target>
                    <parameters>
                      <primitiveExpression value="-1"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class ThisYearFilterFunction -->
        <typeDeclaration name="ThisYearFilterFunction">
          <baseTypes>
            <typeReference type="DateRangeFilterFunction"/>
          </baseTypes>
          <members>
            <memberField type="System.Int32" name="deltaYear"/>
            <!-- constructor (int) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.Int32" name="deltaYear"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="deltaYear">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="deltaYear"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- void AssignRange(int, DateTime, DateTime) -->
            <memberMethod name="AssignRange">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="System.Int32" name="year"/>
                <parameter type="DateTime" name="startDate" direction="Out"/>
                <parameter type="DateTime" name="endDate" direction="Out"/>
              </parameters>
              <statements>
                <assignStatement>
                  <argumentReferenceExpression name="startDate"/>
                  <methodInvokeExpression methodName="AddYears">
                    <target>
                      <objectCreateExpression type="DateTime">
                        <parameters>
                          <propertyReferenceExpression name="Year">
                            <propertyReferenceExpression name="Today">
                              <typeReferenceExpression type="DateTime"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <primitiveExpression value="1"/>
                          <primitiveExpression value="1"/>
                        </parameters>
                      </objectCreateExpression>
                    </target>
                    <parameters>
                      <fieldReferenceExpression name="deltaYear"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="endDate"/>
                  <methodInvokeExpression methodName="AddSeconds">
                    <target>
                      <methodInvokeExpression methodName="AddMonths">
                        <target>
                          <argumentReferenceExpression name="startDate"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="12"/>
                        </parameters>
                      </methodInvokeExpression>
                    </target>
                    <parameters>
                      <primitiveExpression value="-1"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class YearToDateFilterFunction -->
        <typeDeclaration name="YearToDateFilterFunction">
          <baseTypes>
            <typeReference type="DateRangeFilterFunction"/>
          </baseTypes>
          <members>
            <!-- void AssignRange(int, DateTime, DateTime) -->
            <memberMethod name="AssignRange">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="System.Int32" name="year"/>
                <parameter type="DateTime" name="startDate" direction="Out"/>
                <parameter type="DateTime" name="endDate" direction="Out"/>
              </parameters>
              <statements>
                <assignStatement>
                  <argumentReferenceExpression name="startDate"/>
                  <objectCreateExpression type="DateTime">
                    <parameters>
                      <propertyReferenceExpression name="Year">
                        <propertyReferenceExpression name="Today">
                          <typeReferenceExpression type="DateTime"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                      <primitiveExpression value="1"/>
                      <primitiveExpression value="1"/>
                    </parameters>
                  </objectCreateExpression>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="endDate"/>
                  <methodInvokeExpression methodName="AddSeconds">
                    <target>
                      <methodInvokeExpression methodName="AddDays">
                        <target>
                          <propertyReferenceExpression name="Today">
                            <typeReferenceExpression type="DateTime"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <primitiveExpression value="1"/>
                        </parameters>
                      </methodInvokeExpression>
                    </target>
                    <parameters>
                      <primitiveExpression value="-1"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class ThisWeekFilterFunction -->
        <typeDeclaration name="ThisWeekFilterFunction">
          <baseTypes>
            <typeReference type="DateRangeFilterFunction"/>
          </baseTypes>
          <members>
            <memberField type="System.Int32" name="deltaWeek"/>
            <!-- constructor (int) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.Int32" name="deltaWeek"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="deltaWeek">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="deltaWeek"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- void AssignRange(int, DateTime, DateTime) -->
            <memberMethod name="AssignRange">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="System.Int32" name="year"/>
                <parameter type="DateTime" name="startDate" direction="Out"/>
                <parameter type="DateTime" name="endDate" direction="Out"/>
              </parameters>
              <statements>
                <assignStatement>
                  <argumentReferenceExpression name="startDate"/>
                  <propertyReferenceExpression name="Today">
                    <typeReferenceExpression type="DateTime"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <whileStatement>
                  <test>
                    <binaryOperatorExpression operator="ValueInequality">
                      <propertyReferenceExpression name="DayOfWeek">
                        <argumentReferenceExpression name="startDate"/>
                      </propertyReferenceExpression>
                      <propertyReferenceExpression name="FirstDayOfWeek">
                        <propertyReferenceExpression name="DateTimeFormat">
                          <propertyReferenceExpression name="CurrentUICulture">
                            <typeReferenceExpression type="CultureInfo"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </test>
                  <statements>
                    <assignStatement>
                      <argumentReferenceExpression name="startDate"/>
                      <methodInvokeExpression methodName="AddDays">
                        <target>
                          <argumentReferenceExpression name="startDate"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="-1"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </statements>
                </whileStatement>
                <assignStatement>
                  <argumentReferenceExpression name="startDate"/>
                  <methodInvokeExpression methodName="AddDays">
                    <target>
                      <argumentReferenceExpression name="startDate"/>
                    </target>
                    <parameters>
                      <binaryOperatorExpression operator="Multiply">
                        <primitiveExpression value="7"/>
                        <fieldReferenceExpression name="deltaWeek"/>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="endDate"/>
                  <methodInvokeExpression methodName="AddSeconds">
                    <target>
                      <methodInvokeExpression methodName="AddDays">
                        <target>
                          <argumentReferenceExpression name="startDate"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="7"/>
                        </parameters>
                      </methodInvokeExpression>
                    </target>
                    <parameters>
                      <primitiveExpression value="-1"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class TodayFilterFunction -->
        <typeDeclaration name="TodayFilterFunction">
          <baseTypes>
            <typeReference type="DateRangeFilterFunction"/>
          </baseTypes>
          <members>
            <memberField type="System.Int32" name="deltaDays"/>
            <!-- constructor (int) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.Int32" name="deltaDays"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="deltaDays">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="deltaDays"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- void AssignRange(int, DateTime, DateTime) -->
            <memberMethod name="AssignRange">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="System.Int32" name="year"/>
                <parameter type="DateTime" name="startDate" direction="Out"/>
                <parameter type="DateTime" name="endDate" direction="Out"/>
              </parameters>
              <statements>
                <assignStatement>
                  <argumentReferenceExpression name="startDate"/>
                  <methodInvokeExpression methodName="AddDays">
                    <target>
                      <propertyReferenceExpression name="Today">
                        <typeReferenceExpression type="DateTime"/>
                      </propertyReferenceExpression>
                    </target>
                    <parameters>
                      <fieldReferenceExpression name="deltaDays"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="endDate"/>
                  <methodInvokeExpression methodName="AddSeconds">
                    <target>
                      <methodInvokeExpression methodName="AddDays">
                        <target>
                          <argumentReferenceExpression name="startDate"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="1"/>
                        </parameters>
                      </methodInvokeExpression>
                    </target>
                    <parameters>
                      <primitiveExpression value="-1"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class PastFilterFunction -->
        <typeDeclaration name="PastFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- string ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="Now">
                    <typeReferenceExpression type="DateTime"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="{{0}}&lt;{{1}}"/>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="expressions"/>
                        </target>
                        <indices>
                          <methodInvokeExpression methodName="FirstArgument">
                            <parameters>
                              <argumentReferenceExpression name="arguments"/>
                            </parameters>
                          </methodInvokeExpression>
                        </indices>
                      </arrayIndexerExpression>
                      <propertyReferenceExpression name="ParameterName">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class FutureFilterFunction -->
        <typeDeclaration name="FutureFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- string ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="Now">
                    <typeReferenceExpression type="DateTime"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="{{0}}&lt;{{1}}"/>
                      <propertyReferenceExpression name="ParameterName">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="expressions"/>
                        </target>
                        <indices>
                          <methodInvokeExpression methodName="FirstArgument">
                            <parameters>
                              <argumentReferenceExpression name="arguments"/>
                            </parameters>
                          </methodInvokeExpression>
                        </indices>
                      </arrayIndexerExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class TrueFilterFunction -->
        <typeDeclaration name="TrueFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- string ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="true"/>
                </assignStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="{{0}}={{1}}"/>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="expressions"/>
                        </target>
                        <indices>
                          <methodInvokeExpression methodName="FirstArgument">
                            <parameters>
                              <argumentReferenceExpression name="arguments"/>
                            </parameters>
                          </methodInvokeExpression>
                        </indices>
                      </arrayIndexerExpression>
                      <propertyReferenceExpression name="ParameterName">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class FalseFilterFunction -->
        <typeDeclaration name="FalseFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- string ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="false"/>
                </assignStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="{{0}}={{1}}"/>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="expressions"/>
                        </target>
                        <indices>
                          <methodInvokeExpression methodName="FirstArgument">
                            <parameters>
                              <argumentReferenceExpression name="arguments"/>
                            </parameters>
                          </methodInvokeExpression>
                        </indices>
                      </arrayIndexerExpression>
                      <propertyReferenceExpression name="ParameterName">
                        <variableReferenceExpression name="p"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class IsEmptyFilterFunction -->
        <typeDeclaration name="IsEmptyFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- string ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <!--<variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="true"/>
                </assignStatement>-->
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="{{0}} is null"/>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="expressions"/>
                        </target>
                        <indices>
                          <methodInvokeExpression methodName="FirstArgument">
                            <parameters>
                              <argumentReferenceExpression name="arguments"/>
                            </parameters>
                          </methodInvokeExpression>
                        </indices>
                      </arrayIndexerExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class IsNotEmptyFilterFunction -->
        <typeDeclaration name="IsNotEmptyFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <!-- string ExpandWith(DbCommand, SelectClauseDictionary, string) -->
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <!--<variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="true"/>
                </assignStatement>-->
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Format">
                    <target>
                      <typeReferenceExpression type="String"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="{{0}} is not null"/>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="expressions"/>
                        </target>
                        <indices>
                          <methodInvokeExpression methodName="FirstArgument">
                            <parameters>
                              <argumentReferenceExpression name="arguments"/>
                            </parameters>
                          </methodInvokeExpression>
                        </indices>
                      </arrayIndexerExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class ExternalFilterFunction -->
        <typeDeclaration name="ExternalFilterFunction">
          <baseTypes>
            <typeReference type="FilterFunctionBase"/>
          </baseTypes>
          <members>
            <memberMethod returnType="System.String" name="ExpandWith">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="DbCommand" name="command"/>
                <parameter type="SelectClauseDictionary" name="expressions"/>
                <parameter type="System.String" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="DbParameter" name="p">
                  <init>
                    <methodInvokeExpression methodName="CreateParameter">
                      <parameters>
                        <argumentReferenceExpression name="command"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="Value">
                    <typeReferenceExpression type="DBNull"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <propertyReferenceExpression name="Current">
                        <typeReferenceExpression type="PageRequest"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.String" name="parameterName">
                      <init>
                        <propertyReferenceExpression name="Value">
                          <methodInvokeExpression methodName="Match">
                            <target>
                              <typeReferenceExpression type="Regex"/>
                            </target>
                            <parameters>
                              <argumentReferenceExpression name="arguments"/>
                              <primitiveExpression value="\w+"/>
                            </parameters>
                          </methodInvokeExpression>
                        </propertyReferenceExpression>
                      </init>
                    </variableDeclarationStatement>
                    <foreachStatement>
                      <variable type="FieldValue" name="v"/>
                      <target>
                        <propertyReferenceExpression name="ExternalFilter">
                          <propertyReferenceExpression name="Current">
                            <typeReferenceExpression type="PageRequest"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                      </target>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="Equals">
                              <target>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="v"/>
                                </propertyReferenceExpression>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="parameterName"/>
                                <propertyReferenceExpression name="InvariantCultureIgnoreCase">
                                  <typeReferenceExpression type="StringComparison"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <propertyReferenceExpression name="Value">
                                <variableReferenceExpression name="p"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="Value">
                                <variableReferenceExpression name="v"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                            <breakStatement/>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <propertyReferenceExpression name="ParameterName">
                    <variableReferenceExpression name="p"/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
