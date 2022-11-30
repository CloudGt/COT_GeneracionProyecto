/// <reference path="../../_System/MicrosoftAjax.debug.js"/>
/// <reference path="../../_System/CodeOnTime.Client.js"/>
/// <reference path="../../Data Aquarium/Scripts/daf.js"/>

// style sheets
document.writeln('<link href="../../_AjaxControlToolkit/Calendar/Calendar.css" type="text/css" rel="Stylesheet" />');
document.writeln('<link href="../../_AjaxControlToolkit/Tabs/Tabs.css" type="text/css" rel="Stylesheet" />');
document.writeln('<link href="../../../_System/CodeOnTime.css" type="text/css" rel="Stylesheet" />');
document.writeln('<link href="../../../Data Aquarium/_App_Themes/_Shared/Core.css" type="text/css" rel="Stylesheet" />');
document.writeln('<link href="../../_System/CodeOnTime.Designer.css" type="text/css" rel="Stylesheet" />');
// scripts
document.writeln('<script type="text/javascript" language="javascript" src="../../../_System/MicrosoftAjax.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../../_System/MicrosoftAjaxTimer.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../../_System/MicrosoftAjaxWebForms.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/ExtenderBase/BaseScripts.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/Common/Common.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/DynamicPopulate/DynamicPopulateBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit//Compat/Timer/Timer.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/Animation/Animations.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/Animation/AnimationBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/PopupExtender/PopupBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/HoverExtender/HoverBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/Common/DateTime.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/Common/Threading.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/AlwaysVisibleControl/AlwaysVisibleControlBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/Calendar/CalendarBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/DragPanel/FloatingBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/DropDown/DropDownBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/DropShadow/DropShadowBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/MaskedEdit/MaskedEditBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/MaskedEdit/MaskedEditValidator.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/ModalPopup/ModalPopupBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/PopupControl/PopupControlBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/RoundedCorners/RoundedCornersBehavior.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_AjaxControlToolkit/Tabs/Tabs.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../_System/daf-resources.en-US.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../../Data Aquarium/Scripts/_System.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../../Data Aquarium/Scripts/daf-menu.js"></script>');
//document.writeln('<script type="text/javascript" language="javascript" src="../../../Standard/Scripts/daf-menu.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../../Data Aquarium/Scripts/daf.js"></script>');
//document.writeln('<script type="text/javascript" language="javascript" src="../../../Standard/Scripts/daf.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../../Data Aquarium/Scripts/classic.js"></script>');
//document.writeln('<script type="text/javascript" language="javascript" src="../../../Standard/Scripts/classic.js"></script>');
document.writeln('<script type="text/javascript" language="javascript" src="../../../_System/CodeOnTime.Client.js"></script>');

//    <!-- begin CodeMirror -->
document.writeln('<link href="../../../_System/codemirror.min.css" type="text/css" rel="Stylesheet" />');
document.writeln('<script type="text/javascript" language="javascript" src="../../../_System/codemirror.min.js"></script>');


var __designerMode = true;
var __tf = 4.1;

function createHistory(history, title) {
    var id = null;
    var text = title;
    if (String.isNullOrEmpty(history))
        history = [];
    else
        history = Sys.Serialization.JavaScriptSerializer.deserialize(history);
    var m = unescape(window.location.href).match(/(\w+=(.*?)(&|$))+_requestId=/);
    if (m) {
        id = m[2];
        if (text == 'Home') {
            var activeTab = location.href.match(/_activeTab=(.+?)(&|$)/);
            if (activeTab) {
                Array.clear(history);
                text = decodeURIComponent(activeTab[1]);
            }
        }
        else
            text += ': ' + id;

    }
    if (!window.location.href.match(/Details\.htm/)) {
        for (var i = 0; i < history.length; i++) {
            if (history[i].text == text)
                return history;
        }
    }
    if (window.location.href.match(/_explorerNode=/)) {
        for (i = 0; i < history.length; i++) {
            var hn = history[i];
            if (hn.url.match(/_explorerNode=/)) {
                while (i <= history.length - 1)
                    Array.removeAt(history, i);
                break;
            }
        }
    }
    Array.add(history, { 'title': title, 'id': id, 'text': text, 'url': window.location.href });
    return history;
}

var formButtonsInitialized = false;

function _invoke_Designer(methodName, params, onSuccess, userContext) {
    var p = Sys.Serialization.JavaScriptSerializer.serialize(params);
    try {
        var r = window.external.InvokeDataAquarium(methodName, p);
        r = Sys.Serialization.JavaScriptSerializer.deserialize(r);
        onSuccess.apply(this, [r, userContext]);
        if (!formButtonsInitialized && methodName == 'GetPage' && params.view.match(/editForm1|createForm1/))
            _designer_initializeFormButtons(params.controller, params.view);
    }
    catch (ex) {
        Web.DataView.showMessage(String.format('<pre style="word-wrap:break-word;margin:0px;overflow:auto;height:100px;">{0}</pre>', ex.message));
        //this._onMethodFailed(ex, null, userContext);
    }
}

function _init_Designer() {
    if (!this._state) {
        this._state = CodeOnTime.Client.get_property(window.location + '_PageState');
        if (this._state == null)
            this._state = {};
    }
}

function _save_Designer() {
    CodeOnTime.Client.set_property(window.location + '_PageState', this._state);
}

function _designer_setFocus(element) {
    Sys.UI.DomElement._setFocus(element);
    window.external.FocusExplorerWhenNeeded();
}

function initializeDesigner(title) {
    document.body.className = 'Designer';
    Web.DataViewResources.Pager.PageSizes = [10, 15, 20, 25, 50, 100];

    Web.DataView.prototype._invoke = _invoke_Designer;
    Web.PageState._init = _init_Designer;
    Web.PageState._save = _save_Designer;
    Sys.UI.DomElement._setFocus = Sys.UI.DomElement.setFocus;
    Sys.UI.DomElement.setFocus = _designer_setFocus;

    var elem = $get('Main');
    if (!elem) return;
    var firstChild = elem.childNodes[0];
    var fixedHeader = document.createElement('div');
    fixedHeader.className = 'FixedHeader';
    fixedHeader.id = 'FixedHeader';
    elem.parentNode.insertBefore(fixedHeader, elem);

    var description = document.createElement('div');
    fixedHeader.appendChild(description);
    description.className = 'Content';
    description.innerHTML = String.format(
        '<div class="DesignerToolBar">' +
        '<a href="#" id="ShowAppPreviewButton" style="display:{0}" onclick="CodeOnTime.Client.showAppPreview();return false;" title="Bring Preview in Front" class="Preview"><span class="Inner"><span class="Outer"><span class="Self">Preview</span></span></span></a>' +
        '<a href="#" onclick="CodeOnTime.Client.generate(true);return false;" title="Generate and Preview Output" class="Run" id="RunProjectButton"><span class="Inner"><span class="Outer"><span class="Self">Generate</span></span></span></a>' +
        '<a href="#" onclick="CodeOnTime.Client.generate(false);return false;" title="Generate and View in Browser" class="Browse" id="BrowseProjectButton"><span class="Outer"><span class="Inner"><span class="Self">Browse</span></span></span></a>' +
        '<a href="#" id="ShowSolutionButton" style="display:{1}" onclick="CodeOnTime.Client.showSolution();return false;" title="Open in Visual Studio" class="Develop"><span class="Inner"><span class="Outer"><span class="Self">Develop</span></span></span></a>' +
        '<a href="#" id="OpenButton" onclick="CodeOnTime.Client.openProjectFolder();return false;" title="Open in Windows Explorer" class="Open"><span class="Inner"><span class="Outer"><span class="Self">Open</span></span></span></a>' +
        '<a href="#" onclick="CodeOnTime.Client.cancel();return false;" title="Exit Designer" class="Exit"><span class="Outer"><span class="Inner"><span class="Self">Exit</span></span></span></a>' +
        '</div>', window.external.IsAppPreviewAvailable ? '' : 'none', window.external.isSolutionAvailable ? '' : 'none')
        //+ '<span>Review and modify properties of the project items.</span>'
        ;
    /* var heading = document.createElement('div');
    fixedHeader.appendChild(heading);
    heading.className = 'Heading';
    //heading.innerHTML = String.format('<a href="javascript:" onclick="CodeOnTime.Client.cancel();return false;" class="ExitDesigner" title="Exit Code OnTime Designer">Close</a><span>Project Designer<span>');
    heading.innerHTML = String.format('<span class="ProjectDesignerButtons" style="display:none">' +
    '<button class="Preview" onclick="CodeOnTime.Client.generate(true);return false;" title="Generate and Preview Output">Preview</button>' +
    '<button class="Browse" onclick="CodeOnTime.Client.generate(false);return false;" title="Generate and View in Browser">Browse</button>' +
    '<button onclick="CodeOnTime.Client.cancel();return false;" title="Exit Designer" class="Exit">Exit</button>' +
    '</span>');*/
    // hide generate/browse if necessary
    var previewConfig = CodeOnTime.Client.getPreviewConfig();
    Sys.UI.DomElement.setVisible($get('RunProjectButton'), previewConfig.generate || !previewConfig.browse);
    Sys.UI.DomElement.setVisible($get('BrowseProjectButton'), previewConfig.browse);
    if (previewConfig.preview != "Browser")
        $('#BrowseProjectButton .Self').text('Run');
    if (!previewConfig.browse)
        $get('RunProjectButton').title = 'Generate Project';
    // find the bread crumbs for this page
    var historyString = CodeOnTime.Client.get_property(window.location + '_navigationHistory');
    var history = null;
    if (String.isNullOrEmpty(historyString)) {
        history = createHistory(CodeOnTime.Client.get_property('_navigationHistory'), title);
        historyString = Sys.Serialization.JavaScriptSerializer.serialize(history);
        CodeOnTime.Client.set_property(window.location + '_navigationHistory', historyString);
    }
    else
        history = Sys.Serialization.JavaScriptSerializer.deserialize(historyString);
    CodeOnTime.Client.set_property('_navigationHistory', historyString);
    // render bread crumbs 
    var sb = new Sys.StringBuilder();
    sb.append('<div class="DesignerPathBar" id="DesignerPathBar">');
    for (var i = 0; i < history.length; i++) {
        var c = history[i];
        if (i == 0) {
            var canGoBack = i == 0 && history.length > 1;
            sb.appendFormat('<a href="javascript:" onclick="if({1}) goBackOneLevel(this);return false;" title="Back" class="Back"><img src="../../_System/NavBack{0}.png" style="border:0px;vertical-align:middle;" /></a><span class="Separator"></span>', canGoBack ? '' : 'Disabled', history.length > 1);
            if (!c.text.match(/^(Home|Pages|Controllers|User Controls)$/)) {
                sb.appendFormat('<a href="Start.htm?_explorerNode=" title="Navigate to Home">Home</a>');
                sb.append('<span class="Separator">&gt;</span>');
            }
        }
        if (i > 0) sb.append('<span class="Separator">&gt;</span>');
        if (i == history.length - 1) {
            var tm = c.text.match(/^(.+?\s*\:\s*)(.+?)$/);
            sb.appendFormat('<span class="Current">{0}</span>', tm ? Web.DataView.htmlEncode(tm[1]) + '<b style="color:black">' + Web.DataView.htmlEncode(tm[2].replace(/\^\w+\^/g, '')) + '</b>' : Web.DataView.htmlEncode(c.text));
        }
        else
            sb.appendFormat('<a href="{0}" title="Navigate to {2} {3}">{1}</a>', c.url, Web.DataView.htmlEncode(c.text.replace(/\^\w+\^/g, '')), String.isNullOrEmpty(c.id) ? c.title : c.title.toLowerCase(), Web.DataView.htmlAttributeEncode(c.id));
    }
    sb.append('</div>');
    var path = document.createElement('div');
    path.className = 'DesignerPath';
    fixedHeader.appendChild(path);
    path.innerHTML = sb.toString();
    sb.clear();
    document.title = history[history.length - 1].title;

    var disclaimer = document.createElement('div');
    elem.appendChild(disclaimer);
    disclaimer.innerHTML = '<div class="Task" style="margin-top: 8px; font-family: Tahoma; font-size: 8.5pt;">All customized project settings are stored in <b>*.Log.xml</b> files located in the root of your project folder.</div>';

    adjustFixedHeader();

    // replace the Web.DataVew details handler
    Web.DataViewResources.Lookup.ShowDetailsInPopup = false;
    Web.DataViewResources.Data.MaxReadOnlyStringLen = 200;
    //Web.DataView.DetailsHandler = 'Details.htm';
    setInterval(function () {
        var showAppPreviewButton = $get("ShowAppPreviewButton");
        var isVisible = Sys.UI.DomElement.getVisible(showAppPreviewButton);
        if (isVisible != window.external.IsAppPreviewAvailable) {
            Sys.UI.DomElement.setVisible(showAppPreviewButton, !isVisible);
            _designer_positionButtons();
        }
    }, 500);
    if (!Sys.UI.DomElement.getVisible($get('ShowSolutionButton')))
        window.setInterval('if(window.external.IsSolutionAvailable)Sys.UI.DomElement.setVisible($get("ShowSolutionButton"), true)', 10000);
    window.external.UpdateTree('Designer');
    $addHandler(document, 'keydown', function (e) {
        if (e.ctrlKey) {
            var doNavigateTo = e.keyCode == 188; // Ctrl+F or Ctrl+,
            var doSyncDesigner = e.keyCode == 190;
            switch (e.keyCode) {
                //case 70:  // F                                                                         
                case 188: // ,
                case 190: // .
                    //case 76:  // L
                    //case 78:  // N
                    //case 79:  // O
                    e.preventDefault();
                    e.stopPropagation();
                    break;
            }
            //            if (e.keyCode != 17) // 17 is CTRL key code
            //                alert(e.keyCode);
            if (doNavigateTo)
                window.external.NavigateTo();
            if (doSyncDesigner)
                window.external.SynchronizeWithDesigner();
        }
        else if (!e.ctrlKey && !e.shiftKey && !e.altKey && e.keyCode == 115) {
            // F4
            e.preventDefault();
            window.external.FocusExplorer();
        }
    }
        , true);
}

function adjustFixedHeader() {
    var fixedHeader = $get('FixedHeader');
    var fixedHeaderBounds = $common.getBounds(fixedHeader);
    var elem = $get('Main');
    elem.style.paddingTop = (fixedHeaderBounds.height - 2) + 'px';
    Sys.UI.DomElement.setVisible($get('PageHeaderRow'), false);
}

if (typeof CodeOnTime == 'undefined') CodeOnTime = {};

CodeOnTime.DesignerTab = function (text, controller, args) {
    this.text = text;
    this.controller = controller;
    this.args = args;
};

function $cookie() {
    var href = window.location.href;
    try {
        var match = href.match(/.+?([\w%]+\W\w+\W\w+.\.htm\?.*?)(\&|)_requestId=.+$/);
        return { 'name': 'cookie', 'value': match ? match[1] : null };
    }
    catch (ex) {
        alert('$cookie exception. href = "' + href + '", error = "' + ex + '".');
        return { name: 'cookie', value: null };
    }
}

$createDataView = function (placeholderId, controller, args) {
    var params = { 'id': controller + 'Extender', 'controller': controller, 'baseUrl': './', 'servicePath': 'Services/DataControllerService.asmx' };
    if (args) {
        for (var i = 0; i < args.length; i++)
            params[args[i].name] = args[i].value;
    }
    $create(Web.DataView, params, null, null, $get(placeholderId));
};

function createTabbedControllers(placeholderId, tabs) {
    // clear the last selected key values
    window.external.LastSelectedKeyValues = '';

    var tabContainerId = placeholderId + 'Tabs';
    var sb = new Sys.StringBuilder();
    sb.appendFormat('<div class="TabContainer" id="{0}">', tabContainerId);
    // tab captions
    sb.appendFormat('<div id="{0}Tabs_header" class="Tab_header">', placeholderId);
    //sb.appendFormat('<span id="__tab_{0}Tabs_UsersTab">[First Tab]</span><span id="__tab_{0}Tabs_RolesTab">[Second Tab]</span>', placeholderId);
    for (var i = 0; i < tabs.length; i++) {
        var t = tabs[i];
        sb.appendFormat('<span id="__tab_{0}Tabs_Tab{1}">{2}</span>', placeholderId, i, Web.DataView.htmlEncode(t.text));
    }
    sb.append('</div>');
    // tab bodies
    sb.appendFormat('<div id="{0}Tabs_body" class="Tab_body">', placeholderId);

    for (i = 0; i < tabs.length; i++) {
        t = tabs[i];
        sb.appendFormat('<div id="{0}Tabs_Tab{1}" style="display:none;visibility:hidden;">', placeholderId, i);
        sb.appendFormat('<div id="{0}Tabs_Tab{1}_Placeholder" class="designer-placeholder{2}"></div>', placeholderId, i, i == 0 ? ' first' : '');
        sb.append('</div>');
    }

    sb.append('</div>'); // end of body

    sb.append('</div>'); // end of tabs 

    // render tabbed layout
    var placeholder = $get(placeholderId);
    placeholder.innerHTML = sb.toString();
    sb.clear();

    var tabContainer = $create(AjaxControlToolkit.TabContainer, { 'activeTabIndex': 0, 'clientStateField': null }, null, null, $get(tabContainerId));
    for (i = 0; i < tabs.length; i++) {
        t = tabs[i];
        if (!t) t = new CodeOnTime.DesignerTab();
        var tabId = String.format('{0}Tabs_Tab{1}', placeholderId, i);
        $create(AjaxControlToolkit.TabPanel, { 'headerTab': $get('__tab_' + tabId) }, null, { 'owner': tabContainerId }, $get(tabId));
    }

    // override the AjaxControlToolkit.TabContainer.set_activeTabIndex method
    if (!AjaxControlToolkit.TabContainer.prototype.old_SetActiveTabIndex) {
        AjaxControlToolkit.TabContainer.prototype.old_SetActiveTabIndex = AjaxControlToolkit.TabContainer.prototype.set_activeTabIndex;
        AjaxControlToolkit.TabContainer.prototype.set_activeTabIndex = function (index) {
            if (!Web.DataView.LastSelectedKeyValues)
                Web.DataView.LastSelectedKeyValues = [];
            Web.DataView.LastSelectedKeyValues[this._activeTabIndex] = window.external.LastSelectedKeyValues;
            this.old_SetActiveTabIndex(index);
            CodeOnTime.Client.set_property($cookie().value + '_tabIndex', index);
            window.external.LastSelectedKeyValues = Web.DataView.LastSelectedKeyValues[index];
            if (buttons)
                if (index == 0)
                    buttons.show();
                else
                    buttons.hide();
            else
                okCancelButtonsHidden = index == 0;
            //alert(window.external.LastSelectedKeyValues);
        };
    }

    var tabIndex = CodeOnTime.Client.get_property($cookie().value + '_tabIndex');
    var activeTab = Web.DataView.get_commandLine().match(/\W_activeTab=(.+?)(\&|$)/);
    if (activeTab) {
        for (i = 0; i < tabs.length; i++)
            if (tabs[i].text == decodeURIComponent(activeTab[1])) {
                tabIndex = i;
                break;
            }
    }
    if (tabIndex == null) tabIndex = 0;
    tabContainer.set_activeTabIndex(tabIndex);
    for (i = 0; i < tabs.length; i++) {
        t = tabs[i];
        if (!t) t = new CodeOnTime.DesignerTab();
        var dataViewPlaceholder = String.format('{0}Tabs_Tab{1}_Placeholder', placeholderId, i);
        Array.add(t.args, { 'name': 'pageSize', 'value': 50 });
        Array.add(t.args, { 'name': 'viewId', 'value': 'grid1' });
        $createDataView(dataViewPlaceholder, t.controller, t.args);
    }
    Web.DataView._load();
}

function __designer_notifySelected(dataView) {
    var sb = new Sys.StringBuilder(String.format('ListController={0}&ListView={1}', dataView.get_controller(), dataView.get_viewId()));
    if (dataView._selectedKey && dataView._selectedKey.length > 0)
        for (var i = 0; i < dataView._keyFields.length; i++) {
            var f = dataView._keyFields[i];
            sb.appendFormat("&{0}={1}", f.Name, dataView._selectedKey[i]);
        }
    window.external.LastSelectedKeyValues = sb.toString();
    dataView._raiseSelectedDelayed = false;
}

function __syncDesigner(dataView) {
    if (dataView)
        __designer_notifySelected(dataView);
    window.setTimeout('window.external.SynchronizeWithDesigner()', 100);
}


function __syncAndEdit(action, argument) {
    window.setTimeout(String.format('window.external.SyncAndEdit(\'{0}\', \'{1}\')', action, argument), 100);
}

function goBackOneLevel(elem) {
    if (location.href.match(/_returnController/))
        window.history.back();
    else {
        var pathDiv = $get('DesignerPathBar');
        var links = pathDiv.getElementsByTagName('a');
        if (links.length > 1)
            location.href = links[links.length - 1].href;
    }
}

var toolBarTop = null;
var buttons = null;
var okCancelButtonsHidden = false;

function _designer_positionButtons() {
    if (!buttons) return;
    buttons.show();
    for (var i = buttons.length - 1; i >= 0; i--) {
        if (i == buttons.length - 1)
            $(buttons[i]).position({ my: 'right top', at: 'right-8 top', of: $('div.DesignerToolBar') });
        else
            $(buttons[i]).position({ my: 'right-8 top', at: 'left top', of: buttons[i + 1] });
    }
}

function _designer_initializeFormButtons(controller, view) {
    formButtonsInitialized = true;
    if (controller == 'Pages' && view == 'createForm1') {
        $('.designer-placeholder.first').removeClass('first');
        return;
    }
    $('table.ActionButtons:first').find('button').each(function (index) {
        $('<button>').text($(this).text()).data('index', index).appendTo($('div.DesignerToolBar')).click(function () {
            $('table.ActionButtons:first').find(String.format('button:eq({0})', $(this).data('index'))).click();
        });
    });
    buttons = $('div.DesignerToolBar button');
    _designer_positionButtons();
    if (!okCancelButtonsHidden)
        buttons.hide();
    $(window).resize(function () {
        if (buttons.is(':visible'))
            _designer_positionButtons();
    });
    //$('table.DataView tr.ActionButtonsRow').hide();

    //    if (AjaxControlToolkit.TabContainer && !AjaxControlToolkit.TabContainer.prototype.oldDesigner_set_activeTabIndex) {
    //        AjaxControlToolkit.TabContainer.prototype.oldDesigner_set_activeTabIndex = AjaxControlToolkit.TabContainer.prototype.set_activeTabIndex;
    //        AjaxControlToolkit.TabContainer.prototype.set_activeTabIndex = function (value) {
    //            this.oldDesigner_set_activeTabIndex(value);
    //            if (this._activeTabIndex == 0)
    //                buttons.show();
    //            else
    //                buttons.hide();

    //        }
    //    }

}

//setInterval(function () {

//    if (toolBarTop == null) {
//        var pos = $('div#DesignerPathBar').position();
//        var height = $('div#DesignerPathBar').outerHeight();
//        toolBarTop = pos.top + height;
//    }
//    if (!topActionButtons) {
//        topActionButtons = $('table.ActionButtons:first');
//        topActionButtons.find('button').each(function (index) {
//            $('<button>').text($(this).text()).data('index', index).appendTo($('div.DesignerToolBar')).click(function () {
//                topActionButtons.find(String.format('button:eq({0})', $(this).data('index'))).click();
//            });
//        });
//        buttons = $('div.DesignerToolBar button');
//        for (var i = buttons.length - 1; i >= 0; i--) {
//            if (i == buttons.length - 1)
//                $(buttons[i]).position({ my: 'right top', at: 'right-12 top', of: $('div.DesignerToolBar') });
//            else
//                $(buttons[i]).position({ my: 'right top', at: 'left top', of: buttons[i + 1] });
//        }
//        buttons.hide();

//    }
//    var actionBarPos = topActionButtons.position();
//    var scrollTop = $(window).scrollTop();
//    buttons.hide();
//    if (actionBarPos && actionBarPos.top > 0 && (toolBarTop > actionBarPos.top + topActionButtons.outerHeight() / 2 - scrollTop)) {
//        buttons.show();
//    }
//}, 750);

// Code Mirror editor

var codeMirrorResizeTimeout,
    codeMirrorMonitoring,
    codeMirrorSaveInterval;

function monitorCodeMirrors() {
    if (codeMirrorResizeTimeout)
        return;
    codeMirrorMonitoring = true;
    $(window).on('resize', function () {
        clearTimeout(codeMirrorResizeTimeout);
        codeMirrorResizeTimeout = setTimeout(function () {
            $('.CodeMirror').prev().each(function () {
                $(this).data('codeMirror').setSize($(window).width() - 60, null);
            });
        }, 200);
    });
    codeMirrorSaveInterval = setInterval(function () {
        $('.CodeMirror').prev().each(function () {
            $(this).data('codeMirror').save();
        });
    }, 1000);
}



// \Scripts\CodeMirror\mode\sql\index.html


Designer$Code = function () {
};

Designer$Code.prototype = {
    // This method is invoked for an input element of a data controller field
    // associated with the editor. Return 'true' if no other editors are allowed.
    attach: function (element, viewType) {
        var typeInput = $(element).closest('.DataView').find('.Item.Type :input'),
            scriptType = typeInput.val(),
            fieldContainer = $(element).closest('.Item');
        if (fieldContainer.is('.Text'))
            scriptType = 'Sql';
        else if (fieldContainer.is('.Body') || fieldContainer.is('.Layout'))
            scriptType = 'Html';

        if (scriptType != 'JavaScript' && scriptType != 'Sql' && scriptType != 'Text' && scriptType != 'Html')
            return false;

        monitorCodeMirrors();

        // auto-complete modes: http://q42jaap.github.io/xsd2codemirror/xsltautocomplete.htm

        $(element).addClass('Code');
        var options;
        if (scriptType == 'JavaScript')
            options = {
                mode: 'javascript',
                lineNumbers: true,
                matchBrackets: true,
                continueComments: "Enter",
                extraKeys: { "Ctrl-Q": "toggleComment", "Ctrl-Space": "autocomplete" }
            };
        else if (scriptType == 'Sql' || scriptType == 'Text')
            options = {
                mode: 'text/x-mssql',
                indentWithTabs: true,
                smartIndent: true,
                lineNumbers: true,
                matchBrackets: true,
                autofocus: false,
                extraKeys: { "Ctrl-Space": "autocomplete" }
            };
        else if (scriptType == 'Html')
            options = {
                mode: 'text/html',
                selectionPointer: true,
                indentWithTabs: true,
                smartIndent: true,
                lineNumbers: true,
                autofocus: false,
                extraKeys: { "Ctrl-Space": "autocomplete" }
            };
        var cm = CodeMirror.fromTextArea(element, options);
        cm.setSize($(window).width() - 60, null);
        $(element).data('codeMirror', cm).data('focus', function () {
            window.external.FocusWebBrowser();
            setTimeout(function () {
                cm.focus();
            }, 100);
        });


        //        var timeout;
        //        cm.on("keyup", function (cm, event) {
        //            var popupKeyCodes = {
        //                "9": "tab",
        //                "13": "enter",
        //                "27": "escape",
        //                "33": "pageup",
        //                "34": "pagedown",
        //                "35": "end",
        //                "36": "home",
        //                "38": "up",
        //                "40": "down"
        //            }
        //            if (!popupKeyCodes[(event.keyCode || event.which).toString()] && !cm.state.completionActive) {
        //                if (timeout) clearTimeout(timeout);
        //                timeout = setTimeout(function () {
        //                    CodeMirror.showHint(cm, CodeMirror.hint.htmlmixed, { completeSingle: false });
        //                }, 150);
        //            }
        //       });

        return true;
    },
    // This method is invoked by the client library before the input element
    // of the field is destroyed. Return 'true' if no other editors are allowed.
    detach: function (element, viewType) {
        $(element).data('codeMirror').toTextArea();
        return true;
    }
};