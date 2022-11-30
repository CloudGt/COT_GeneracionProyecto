<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium" xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium" xmlns:act="urn:ajax-control-toolkit" >
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="Namespace"/>
  <xsl:param name="ProjectName"/>

  <xsl:template match="node()">
    <script runat="server">
      <!-- method Application_Start(object, EventArgs) -->
      <memberMethod xmlns="http://www.codeontime.com/2008/codedom-compiler" name="Application_Start">
        <attributes final="true"/>
        <parameters>
          <parameter type="System.Object" name="sender"/>
          <parameter type="EventArgs" name="e"/>
        </parameters>
        <statements>
          <comment>*********************************************************************************************</comment>
          <comment>You may get a compilation error message if you change the namespace of the project.</comment>
          <comment>
            <xsl:text>This file will not be re-generated. Namespace "</xsl:text>
            <xsl:value-of select="$Namespace"/>
            <xsl:text>" must be changed manually.</xsl:text>
          </comment>
          <comment>*********************************************************************************************</comment>
          <comment>Fires on application startup</comment>
          <methodInvokeExpression methodName="Start">
            <target>
              <typeReferenceExpression type="{$Namespace}.Services.ApplicationServices"/>
            </target>
          </methodInvokeExpression>
        </statements>
      </memberMethod>
      <!-- method Application_End(object, EventArgs) -->
      <memberMethod xmlns="http://www.codeontime.com/2008/codedom-compiler" name="Application_End">
        <attributes final="true"/>
        <parameters>
          <parameter type="System.Object" name="sender"/>
          <parameter type="EventArgs" name="e"/>
        </parameters>
        <statements>
          <comment>Fires on application shutdown</comment>
          <methodInvokeExpression methodName="Stop">
            <target>
              <typeReferenceExpression type="{$Namespace}.Services.ApplicationServices"/>
            </target>
          </methodInvokeExpression>
        </statements>
      </memberMethod>
      <!-- method Application_Error(object, EventArgs) -->
      <memberMethod xmlns="http://www.codeontime.com/2008/codedom-compiler" name="Application_Error">
        <attributes final="true"/>
        <parameters>
          <parameter type="System.Object" name="sender"/>
          <parameter type="EventArgs" name="e"/>
        </parameters>
        <statements>
          <comment>Fires when an unhandled error occurs</comment>
          <methodInvokeExpression methodName="Error">
            <target>
              <typeReferenceExpression type="{$Namespace}.Services.ApplicationServices"/>
            </target>
          </methodInvokeExpression>
        </statements>
      </memberMethod>
      <!-- method Session_Start(object, EventArgs) -->
      <memberMethod xmlns="http://www.codeontime.com/2008/codedom-compiler" name="Session_Start">
        <attributes final="true"/>
        <parameters>
          <parameter type="System.Object" name="sender"/>
          <parameter type="EventArgs" name="e"/>
        </parameters>
        <statements>
          <comment>Fires when a new session is started</comment>
          <methodInvokeExpression methodName="SessionStart">
            <target>
              <typeReferenceExpression type="{$Namespace}.Services.ApplicationServices"/>
            </target>
          </methodInvokeExpression>
        </statements>
      </memberMethod>
      <!-- method Session_End(object, EventArgs) -->
      <memberMethod xmlns="http://www.codeontime.com/2008/codedom-compiler" name="Session_End">
        <attributes final="true"/>
        <parameters>
          <parameter type="System.Object" name="sender"/>
          <parameter type="EventArgs" name="e"/>
        </parameters>
        <statements>
          <comment>Fires when a session ends.</comment>
          <comment>Note: The Session_End event is raised only when the sessionstate mode</comment>
          <comment>is set to InProc in the Web.config file. If session mode is set to StateServer</comment>
          <comment>or SQLServer, the event is not raised.</comment>
          <methodInvokeExpression methodName="SessionStop">
            <target>
              <typeReferenceExpression type="{$Namespace}.Services.ApplicationServices"/>
            </target>
          </methodInvokeExpression>
        </statements>
      </memberMethod>
    </script>
  </xsl:template>

</xsl:stylesheet>
