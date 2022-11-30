<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium"
    exclude-result-prefixes="app msxsl c asp aquarium codedom"
>
  <xsl:output method="html" indent="yes" encoding="utf-8" />
  <xsl:param name="Namespace"/>
  <xsl:param name="Name"/>
  <xsl:param name="IsPremium"/>
  <xsl:param name="LibraryRoot"/>
  <xsl:param name="UserInterface"/>

  <msxsl:script language="C#" implements-prefix="app">
    <![CDATA[
    public string ReadPageTemplate(string libraryRoot, string template) {
          if (template == "(blank)")
              return String.Empty;
          string fileName = System.IO.Path.Combine(libraryRoot, @"_Content\Bootstrap\" + template + ".htm");
          if (System.IO.File.Exists(fileName))
            return Regex.Replace( System.IO.File.ReadAllText(fileName), @"data-activator="".+?""\s*", String.Empty);
          else
              return fileName;
    }
    
    public string ReplaceTags(string s){
       return Regex.Replace( Regex.Replace(s, @"<\/?\w+([\S\s]*?)>", String.Empty), @"(\r?\n)+", " ");
    }
    
	]]>
  </msxsl:script>


  <xsl:template match="app:page">
    <xsl:param name="SpecialUserControls" select="app:controls/app:control[@container='page']"/>
    <xsl:variable name="PageHeaderControl" select="$SpecialUserControls[@id='header']"/>
    <xsl:variable name="PageTitleControl" select="$SpecialUserControls[@id='title']"/>
    <xsl:variable name="PageSideBarControl" select="$SpecialUserControls[@id='sidebar']"/>
    <xsl:variable name="PageFooterControl" select="$SpecialUserControls[@id='footer']"/>
    <xsl:variable name="BodyClasses">
      <xsl:value-of select="@style"/>
      <xsl:if test="@customStyle!=''">
        <xsl:if test="@style!=''">
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="@customStyle"/>
      </xsl:if>
      <xsl:if test="not(contains(@path,'|')) and (@style='Generic' or @style='')">
        <xsl:text> HomePage</xsl:text>
      </xsl:if>
    </xsl:variable>
    <html>
      <head>
        <title>
          <xsl:choose>
            <xsl:when test="@title!=''">
              <xsl:value-of select="@title"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@name"/>
            </xsl:otherwise>
          </xsl:choose>
        </title>
        <xsl:if test="app:about!=''">
          <meta name="description" content="{app:ReplaceTags(app:about)}" />
        </xsl:if>
      </head>
      <body>
        <!-- class attribute-->
        <xsl:if test="$BodyClasses!=''">
          <xsl:attribute name="class">
            <xsl:value-of select="$BodyClasses"/>
          </xsl:attribute>
        </xsl:if>
        <!-- data-device attribute -->
        <xsl:if test="@device!=''">
          <xsl:attribute name="data-device">
            <xsl:choose>
              <xsl:when test="@device='Desktop'">
                <xsl:text>desktop</xsl:text>
              </xsl:when>
              <xsl:otherwise>touch</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:if>
        <!-- data-authorize-roles attribute -->
        <xsl:if test="@roles!=''">
          <xsl:attribute name="data-authorize-roles">
            <xsl:value-of select="@roles"/>
          </xsl:attribute>
        </xsl:if>
        <!-- offline attribute-->
        <xsl:if test="@offline='true'">
          <xsl:attribute name="data-offline">
            <xsl:text>true</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <!-- kiosk attribute-->
        <xsl:if test="@kiosk='true'">
          <xsl:attribute name="data-kiosk">
            <xsl:text>true</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@generate='Always'">
          <xsl:text><![CDATA[
    ]]></xsl:text>
          <xsl:comment>The contents of this page will be overwritten by app generator. Set page property "Generate" to "First Time Only" to preserve changes.</xsl:comment>
          <xsl:text><![CDATA[
    ]]></xsl:text>
        </xsl:if>
        <xsl:if test="$PageHeaderControl">
          <div data-role="placeholder" data-placeholder="page-header">
            <xsl:for-each select="$PageHeaderControl">
              <xsl:call-template name="RenderControl">
                <xsl:with-param name="UserControl" select="/app:application/app:userControls/app:userControl[@name=current()/@name]"/>
              </xsl:call-template>
              <xsl:text> </xsl:text>
            </xsl:for-each>
          </div>
        </xsl:if>
        <xsl:if test="$PageTitleControl">
          <div data-role="placeholder" data-placeholder="page-title">
            <xsl:for-each select="$PageTitleControl">
              <xsl:call-template name="RenderControl">
                <xsl:with-param name="UserControl" select="/app:application/app:userControls/app:userControl[@name=current()/@name]"/>
              </xsl:call-template>
            </xsl:for-each>
          </div>
        </xsl:if>
        <xsl:call-template name="RenderPage"/>
        <xsl:if test="$PageSideBarControl">
          <div data-role="placeholder" data-placeholder="page-side-bar">
            <xsl:if test="$PageSideBarControl">
              <xsl:for-each select="$PageSideBarControl">
                <xsl:call-template name="RenderControl">
                  <xsl:with-param name="UserControl" select="/app:application/app:userControls/app:userControl[@name=current()/@name]"/>
                </xsl:call-template>
              </xsl:for-each>
            </xsl:if>
          </div>
        </xsl:if>
        <xsl:if test="$PageFooterControl">
          <div data-role="placeholder">
            <xsl:for-each select="$PageFooterControl">
              <xsl:call-template name="RenderControl">
                <xsl:with-param name="UserControl" select="/app:application/app:userControls/app:userControl[@name=current()/@name]"/>
              </xsl:call-template>
            </xsl:for-each>
          </div>
        </xsl:if>
        <xsl:text><![CDATA[
  ]]></xsl:text>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="RenderPage">
    <xsl:choose>
      <xsl:when test="@template!=''">
        <xsl:variable name="Template" select="app:ReadPageTemplate($LibraryRoot, @template)"/>
        <xsl:choose>
          <xsl:when test="$Template=''">
            <div data-app-role="page" data-activator="Button|{@title}">
              This is the content of <i>
                <xsl:value-of select="@name"/>
              </i> page.
            </div>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$Template" disable-output-escaping="yes"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="PageContainers" select="app:containers/app:container[not(@id='page')]"/>
        <xsl:if test="not($PageContainers)">
          <div data-role="placeholder" data-placeholder="site-map" data-start-from-current-node="true">
            <xsl:text> </xsl:text>
          </div>
          <!--<asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" ShowStartingNode="false"
      StartFromCurrentNode="true" />
      <asp:TreeView ID="TreeView1" runat="server" DataSourceID="SiteMapDataSource1" CssClass="TreeView"
          ImageSet="Simple">
      </asp:TreeView>-->
        </xsl:if>
        <xsl:for-each select="$PageContainers">
          <xsl:variable name="Views" select="ancestor::app:page/app:dataViews/app:dataView[@container=current()/@id]"/>
          <xsl:variable name="Controls" select="ancestor::app:page/app:controls/app:control[@container=current()/@id]"/>
          <div>
            <xsl:attribute name="data-flow">
              <xsl:choose>
                <xsl:when test="@flow='NewRow'">
                  <xsl:text>row</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>column</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:if test="@className">
              <xsl:attribute name="class">
                <xsl:value-of select="@className"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@style">
              <xsl:attribute name="style">
                <xsl:value-of select="@style"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@width!=''">
              <xsl:attribute name="data-width">
                <xsl:value-of select="@width"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:for-each select="$Views | $Controls">
              <xsl:sort select="@sequence" data-type="number" order="ascending"/>
              <xsl:choose>
                <xsl:when test="self::app:dataView">
                  <xsl:choose>
                    <xsl:when test="@activator!='None'">
                      <div data-activator="{@activator}|{@text}">
                        <xsl:call-template name="RenderDataView"/>
                      </div>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:call-template name="RenderDataView"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <xsl:when test="self::app:control">
                  <xsl:variable name="UserControl" select="//app:userControl[@name=current()/@name]"/>
                  <xsl:choose>
                    <xsl:when test="@activator!='None'">
                      <div data-activator="{@activator}|{@text}">
                        <xsl:call-template name="RenderControl">
                          <xsl:with-param name="UserControl" select="$UserControl"/>
                        </xsl:call-template>
                      </div>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:call-template name="RenderControl">
                        <xsl:with-param name="UserControl" select="$UserControl"/>
                      </xsl:call-template>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
              </xsl:choose>
            </xsl:for-each>
          </div>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="RenderControl">
    <xsl:param name="UserControl"/>
    <div data-user-control="~/Controls/{@name}">
      <xsl:text> </xsl:text>
    </div>
    <!--<xsl:element name="{$UserControl/@prefix}_namespace_{@name}">
      <xsl:attribute name="ID">
        <xsl:choose>
          <xsl:when test="@id='header'">
            <xsl:text>CustomPageHeader</xsl:text>
          </xsl:when>
          <xsl:when test="@id='title'">
            <xsl:text>CustomPageTitle</xsl:text>
          </xsl:when>
          <xsl:when test="@id='sidebar'">
            <xsl:text>CustomPageSideBar</xsl:text>
          </xsl:when>
          <xsl:when test="@id='footer'">
            <xsl:text>CustomPageFooter</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@id"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="runat">
        <xsl:text>server</xsl:text>
      </xsl:attribute>
    </xsl:element>-->
  </xsl:template>

  <xsl:template name="RenderDataView">
    <xsl:if test="string-length(@activator)=0 and string-length(@text)>0">
      <div class="DataViewHeader">
        <xsl:value-of select="@text"/>
      </div>
    </xsl:if>

    <div id="{@id}" data-controller="{@controller}" >
      <xsl:if test="@view!=''">
        <xsl:attribute name="data-view">
          <xsl:value-of select="@view"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showInSummary='true'">
        <xsl:attribute name="data-show-in-summary">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@filterSource">
        <xsl:attribute name="data-filter-source">
          <xsl:value-of select="@filterSource"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@filterFields">
        <xsl:attribute name="data-filter-fields">
          <xsl:value-of select="@filterFields"/>
          <xsl:if test="@filterField2!=''">
            <xsl:text>,</xsl:text>
            <xsl:value-of select="@filterField2"/>
          </xsl:if>
          <xsl:if test="@filterField3!=''">
            <xsl:text>,</xsl:text>
            <xsl:value-of select="@filterField3"/>
          </xsl:if>
          <xsl:if test="@filterField4!=''">
            <xsl:text>,</xsl:text>
            <xsl:value-of select="@filterField4"/>
          </xsl:if>
          <xsl:if test="@filterField5!=''">
            <xsl:text>,</xsl:text>
            <xsl:value-of select="@filterField5"/>
          </xsl:if>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@pageSize!=''">
        <xsl:attribute name="data-page-size">
          <xsl:value-of select="@pageSize"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@refreshInterval!=''">
        <xsl:attribute name="data-refresh-interval">
          <xsl:value-of select="@refreshInterval"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@multiSelect='true'">
        <xsl:attribute name="data-selection-mode">
          <xsl:text>multiple</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@tag!=''">
        <xsl:attribute name="data-tag">
          <xsl:value-of select="@tag"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showActionBar='false'">
        <xsl:attribute name="data-show-action-bar">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showActionButtons!=''">
        <xsl:attribute name="data-show-action-buttons">
          <xsl:choose>
            <xsl:when test="@showActionButtons='None'">
              <xsl:text>none</xsl:text>
            </xsl:when>
            <xsl:when test="@showActionButtons='Top'">
              <xsl:text>top</xsl:text>
            </xsl:when>
            <xsl:when test="@showActionButtons='Bottom'">
              <xsl:text>bottom</xsl:text>
            </xsl:when>
            <xsl:when test="@showActionButtons='TopAndBottom'">
              <xsl:text>top-and-bottom</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showDescription='false'">
        <xsl:attribute name="data-show-description">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showViewSelector='false'">
        <xsl:attribute name="data-show-view-selector">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@startCommandName!=''">
        <xsl:attribute name="data-start-command-name">
          <xsl:value-of select="@startCommandName"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@startCommandArgument!=''">
        <xsl:attribute name="data-start-command-argument">
          <xsl:value-of select="@startCommandArgument"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@autoHide!='' and @autoHide!='Nothing'">
        <xsl:attribute name="data-auto-hide">
          <xsl:choose>
            <xsl:when test="@autoHide = 'Self'">
              <xsl:text>self</xsl:text>
            </xsl:when>
            <xsl:when test="@autoHide = 'Container'">
              <xsl:text>container</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <!--<xsl:if test="@transaction!='Supported'">
        <xsl:attribute name="data-transaction">
          <xsl:value-of select="@transaction"/>
        </xsl:attribute>
      </xsl:if>-->
      <xsl:if test="$IsPremium='true' and $UserInterface != 'TouchUI'">
        <xsl:if test="@showModalForms='true'">
          <xsl:attribute name="data-show-modal-forms">
            <xsl:text>true</xsl:text>
          </xsl:attribute>
        </xsl:if>
      </xsl:if>
      <xsl:if test="@searchOnStart='true'">
        <xsl:attribute name="data-search-on-start">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showDetailsInListMode='false'">
        <xsl:attribute name="data-show-details-in-list-mode">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showPager!='true'">
        <xsl:attribute name="data-show-pager">
          <xsl:choose>
            <xsl:when test="@showPager='None'">
              <xsl:text>none</xsl:text>
            </xsl:when>
            <xsl:when test="@showPager='Top'">
              <xsl:text>top</xsl:text>
            </xsl:when>
            <xsl:when test="@showPager='Bottom'">
              <xsl:text>bottom</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>top-and-bottom</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showPageSize='false'">
        <xsl:attribute name="data-show-page-size">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showQuickFind='false'">
        <xsl:attribute name="data-show-quick-find">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@searchByFirstLetter='true'">
        <xsl:attribute name="data-search-by-first-letter">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@autoSelectFirstRow='true'">
        <xsl:attribute name="data-auto-select-first-row">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@autoHighlightFirstRow='true'">
        <xsl:attribute name="data-auto-highlight-first-row">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@showRowNumber='true'">
        <xsl:attribute name="data-show-row-number">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@visibleWhen!=''">
        <xsl:attribute name="data-visible-when">
          <xsl:value-of select="@visibleWhen"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@roles!=''">
        <xsl:attribute name="data-roles">
          <xsl:value-of select="@roles"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$IsPremium='true' and @showSearchBar='false'">
        <xsl:attribute name="data-show-search-bar">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:text> </xsl:text>
    </div>
  </xsl:template>

</xsl:stylesheet>
