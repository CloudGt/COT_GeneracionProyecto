/// <reference path="MicrosoftAjax.js"/>
Type.registerNamespace("CodeOnTime");

CodeOnTime._ClientLibrary = function () {
    CodeOnTime._ClientLibrary.initializeBase(this);
    this.EmptyStringRegex = /^\s*$/;
    this.ValidProjectNameRegex = /^[\w]+$/;
    this._resetInstallation();
    this._connectionStringParameters = [];
    this.ConnectionStringRegex = /(;?\s*(password|pwd)\s*=\s*)(.+?)(\s*(;|$))/i;
}

CodeOnTime._ClientLibrary.prototype = {
    initialize: function () {
        if (document.body == null) return;
        CodeOnTime._ClientLibrary.callBaseMethod(this, 'initialize');
        this.initializePage();
        $addHandler(document, "dblclick", this._document_dblClick)
    },
    dispose: function () {
        this._resetInstallation();
        CodeOnTime._ClientLibrary.callBaseMethod(this, 'dispose');
        $removeHandler(document, "dblclick", this._document_dblClick)
    },
    updated: function () {
        CodeOnTime._ClientLibrary.callBaseMethod(this, 'updated');
        try {
            if (window.external.IsDevelopmentMode)
                CodeOnTime._ClientLibrary._libraryService = CodeOnTime._ClientLibrary._debugLibraryService;
        }
        catch (ex) {
        }
    },
    _document_dblClick: function () {
        if (document.activeElement)
            document.activeElement.focus();
    },
    writeProperty: function (document, xpath, value) {
        document.writeProperty(xpath, value);
        return;

        // this code never runs - legacy COM-based processing
        var iterator = /\/{0,1}(\w+:){0,1}(@{0,1})(\w+)/g;
        var current = document;
        var match = iterator.exec(xpath)
        while (match) {
            if (match[2] == '@') {
                current.setAttribute(match[3], value);
                break;
            }
            var node = current.selectSingleNode(match[1] + match[3]);
            if (node == null) {
                node = document.createNode(1, match[3], current.namespaceURI);
                current.appendChild(node);
            }
            if (match.lastIndex == xpath.length)
                node.text = value;
            current = node;
            match = iterator.exec(xpath)
        }
    },
    readProperty: function (document, xpath, defaultValue) {
        return document.readProperty(xpath, defaultValue);

        // this code never runs - legacy COM-based processing
        var node = document.selectSingleNode(xpath);
        return node == null ? defaultValue : node.text;
    },
    get_variable: function (name) {
        return window.external.ReadVariable(name);
    },
    get_isHostedFactory: function () {
        return this.get_variable('ProjectId').match(/(DotNetNuke|SharePoint) Factory/);
    },
    prepareFileToWrite: function (path) {
        window.external.PrepareFileToWrite(path);
    },
    restartIISExpress: function () {
        window.external.RestartIISExpress();
    },
    showDialog: function (dialogId) {
        var bodyRow = $get('PageBodyRow');
        if (!bodyRow) return;
        Sys.UI.DomElement.setVisible(bodyRow, false);
        Sys.UI.DomElement.setVisible($get('PageDialogRow'), true);
        var dialog = $get(dialogId);
        if (!dialog)
            alert(String.format("Dialog '{0}' is not found.", dialogId));
        else
            window.external.title = dialog._title;
        Sys.UI.DomElement.setVisible(dialog, true);
        this.resizeDialog();
    },
    resizeDialog: function () {
        if (Sys.Browser.version < 7) return;
        var divs = document.body.getElementsByTagName('div');
        for (var i = 0; i < divs.length; i++) {
            var div = divs[i];
            if (div.className == 'Buttons') {
                if (Sys.UI.DomElement.getVisible(div)) {
                    var b = Sys.UI.DomElement.getBounds(div);
                    //div.style.backgroundColor = 'yellow';
                    div.style.position = 'fixed';
                    div.style.left = '0px';
                    div.style.width = (window.external.BrowserWindowWidth - 16) + 'px';
                    div.style.top = (window.external.BrowserWindowHeight - b.height - 8) + 'px';
                    var ps = div.previousSibling;
                    while (ps && !ps.tagName)
                        ps = ps.previousSibling;
                    if (ps)
                        ps.style.marginBottom = (b.height - 8) + 'px';
                }
                else
                    div.style.backgroundColor = '';
            }
        }
    },
    hideDialog: function (dialogId) {
        Sys.UI.DomElement.setVisible($get('PageBodyRow'), true);
        Sys.UI.DomElement.setVisible($get('PageDialogRow'), false);
        if (dialogId)
            Sys.UI.DomElement.setVisible($get(dialogId), false);
        else {
            var pageDialogCell = $get('PageDialogCell');
            for (var i = 0; i < pageDialogCell.childNodes.length; i++)
                if (pageDialogCell.childNodes[i].tagName)
                    Sys.UI.DomElement.setVisible(pageDialogCell.childNodes[i], false);
        }
        this._showMainPanelTitle();
        this.resizeDialog();
    },
    _showMainPanelTitle: function () {
        var mainPanel = $get('PageBodyCell').childNodes[0];
        if (mainPanel && mainPanel._title)
            window.external.title = mainPanel._title;
    },
    convertToDate: function (sortableDate) {
        var m = sortableDate.match(/^(\d+)-(\d+)-(\d+)T(\d+)\:(\d+)\:(\d+)$/);
        return new Date(m[1], m[2] - 1, m[3], m[4], m[5], m[6]);
    },
    sendRequest: function (arguments) {
        window.external.CreateRequest(arguments.Name);
        if (arguments.Arguments)
            for (var i = 0; i < arguments.Arguments.length; i++) {
                var arg = arguments.Arguments[i];
                window.external.AddRequestArgument(arg.Name, arg.Value);
            }
        window.external.SendRequest();
    },
    get_computerName: function () {
        return window.external.ComputerName();
    },
    validateWebsite: function (type, url) {
        return window.external.validateWebsite(type, url);
    },
    proceed: function () {
        this.sendRequest({ Name: 'EndNavigate', Arguments: [] });
    },
    cancel: function () {
        window.external.UpdateTree(null);
        var designerReturnUrl = window.external.DesignerReturnUrl;
        if (designerReturnUrl != null) {
            window.external.DesignerReturnUrl = null;
            window.location.href = designerReturnUrl;
        }
        else {
            this.sendRequest({ Name: 'Cancel' });
        }
    },
    generate: function (preview) {
        window.external.Generate(preview);
    },
    showAppPreview: function () {
        window.external.ShowAppPreview();
    },
    get_isAppPreviewAvailable: function () {
        return window.external.IsAppPreviewAvailable;
    },
    get_isSolutionAvailable: function () {
        return window.external.IsSolutionAvailable;
    },
    showSolution: function () {
        window.external.ShowSolution(null);
    },
    openProjectFolder: function () {
        window.external.OpenProjectFolder();
    },
    LearnMoreSourceControl: function () {
        var sc = $get('SourceControl').value;
        switch (sc) {
            case 'tfs':
                $openUrl('http://codeontime.com/learn/development/source-control/tfs');
                break;
            case 'other':
                $openUrl('http://codeontime.com/learn/development/source-control/other');
                break;
            case 'git':
            default:
                $openUrl('http://codeontime.com/learn/development/source-control/git');
                break;
        }
        //$openUrl(
        //alert(sc);
    },
    InitSync: function () {
        window.external.InitSync();
    },
    initializePage: function () {
        var panels = [];
        for (var i = 0; i < document.body.childNodes.length; i++)
            Array.add(panels, document.body.childNodes[i]);
        var pageFrame = document.createElement('div');
        sb = new Sys.StringBuilder();
        sb.appendLine('<table class="Page">');
        sb.appendLine('    <tr id="PageHeaderRow">');
        sb.appendLine('        <td class="OnTimeHeader" valign="bottom" align="right"><div style="max-height:52px;line-height:52px;overflow:hidden">');
        sb.appendLine(
            '<span class="special-links">' +
            '<a href="javascript:" onclick="return $openUrl(\'https://codeontime.zendesk.com/hc/en-us/requests/new\')" title="Open a support ticket"><span>Open a Ticket</span></a>' +
            '<a href="javascript:" onclick="return $openUrl(\'http://my.codeontime.com\')" title="Discuss with community members" ><span>Discuss   </span></a>' +
            '<a href="javascript:" onclick="return $openUrl(\'https://codeontime.com/services\')" title="View available services" ><span>Services</span></a>' +
            '</span>' +
            '<span class="special-links" >' +
            '<a href="javascript:" onclick="return $openUrl(\'https://youtube.com/user/codeontime\')" title="Watch our tutorials"><span>Tutorials</span></a>' +
            '<a href="javascript:" onclick="return $openUrl(\'https://codeontime.com/blog\')" title="Read our blog" ><span>News</span></a>' +
            '<a href="javascript:" target="_blank" onclick="return $openUrl(\'https://codeontime.com/roadmap\')" title="View the product roadmap">Roadmap</a>' +
            '</span>' +
            '<span class="special-links" style="margin-right:8px">' +
            '<a href="javascript:" onclick="return $openUrl(\'https://codeontime.com/releases/application-generator\')" title="List of product releases"><span>Releases</span></a>' +
            '<a href="javascript:" target="_blank" onclick="return $openUrl(\'https://codeontime.com/LiveWebDemo\')" title="Request free live Webex presentation now!">Request Demo</a>' +
            '<a href="javascript:" onclick="return $openUrl(\'https://codeontime.com/buy\')" title="Buy a product edition" ><span>Buy</span></a>' +
            '</span>' +
            //'<a href="javascript:" onclick="return $openUrl(\'http://youtube.com/user/codeontime\')" title="Watch tutorials on our YouTube channel" style="font-weight:bold">YouTube</a><span class="Div">|</span>' +
            //'<a href="javascript:" onclick="return $openUrl(\'http://blog.codeontime.com\')" title="Read our Blog" style="font-weight:bold">Blog</a><span class="Div">|</span>' +
            //'<a href="javascript:" onclick="return $openUrl(\'http://community.codeontime.com\');" title="Ask Community" style="font-weight:bold">Community</a>' +
            '');
        //sb.appendLine('            <div style="margin-top:4px"><a href="javascript:" onclick="return $openUrl(\'http://www.codeontime.com\');" target="_blank" title="Visit our website">http://www.codeontime.com</a></div>');
        sb.appendLine('        </div></td>');
        sb.appendLine('    </tr>');
        sb.appendLine('    <tr id="PageBodyRow">');
        sb.appendLine('        <td class="Body" id="PageBodyCell">');
        sb.appendLine('        </td>');
        sb.appendLine('   </tr>');
        sb.appendLine('   <tr id="PageDialogRow" style="display: none;">');
        sb.appendLine('       <td class="PageDialog" id="PageDialogCell">');
        sb.appendLine('       </td>');
        sb.appendLine('    </tr>');
        sb.appendLine('</table>');
        pageFrame.innerHTML = sb.toString();
        document.body.appendChild(pageFrame.childNodes[0]);
        delete pageFrame;
        var pageBody = $get('PageBodyCell');
        var pageDialog = $get('PageDialogCell');
        for (i = 0; i < panels.length; i++) {
            var panel = panels[i];
            if (panel.title) {
                panel._title = panel.title;
                panel.title = '';
            }
            if (panel.id) {
                if (panel.id.endsWith('Dialog')) {
                    panel.className = 'Dialog';
                    pageDialog.appendChild(panel);
                }
                else
                    pageBody.appendChild(panel);
            }
        }
        $addHandler(document.body, 'contextmenu', Function.createDelegate(this, this._contextMenuEvent));
        this._showMainPanelTitle();
        //Sys.UI.DomElement.setVisible($get('LiveDemoLink'), CodeOnTime.Client.get_showDemoLink());
    },
    _contextMenuEvent: function (e) {
        if (e && e.target.tagName != null) {
            var tagName = e.target.tagName.toLowerCase();
            if (!(tagName == 'input' || tagName == 'textarea'))
                e.preventDefault();
        }
    },
    loadFrom: function (url) {
        return window.external.LoadFrom(url);
    },
    loadFromLibraryRoot: function () {
        return window.external.LoadFromLibraryRoot();
    },
    loadFromProjectsRoot: function () {
        return window.external.LoadFromProjectsRoot();
    },
    loadFromPublish: function (path) {
        return window.external.LoadFromPublish(path);
    },
    saveToProjectsRoot: function (path, doc) {
        //window.external.SaveToProjectsRoot(path, doc);
        doc.saveToProjectsRoot(path);
    },
    saveToPublishRoot: function (path, doc) {
        //window.external.SaveToProjectsRoot(path, doc);
        doc.saveToPublishRoot(path);
    },
    systemTransform: function (document, xsltPath) {
        //return window.external.SystemTransform(document, xsltPath);
        return document.systemTransform(xsltPath);
    },
    loadFromLibrary: function (path) {
        return window.external.LoadFromLibrary(path);
    },
    openProjectSource: function (path) {
        return window.external.OpenProjectSource(path);
    },
    loadFromProject: function (path) {
        return window.external.LoadFromProject(path);
    },
    addTransformArgument: function (name, value) {
        window.external.AddTransformArgument(name, value);
    },
    transform: function (document, xsltPath) {
        //return window.external.Transform(document, xsltPath);
        return document.transform(xsltPath);
    },
    systemTransformUrl: function (documentUrl, transformationName) {
        return window.external.SystemTransformUrl(documentUrl, transformationName);
    },
    fileExists: function (path) {
        return window.external.FileExists(path);
    },
    directoryExists: function (path) {
        return window.external.DirectoryExists(path);
    },
    fileExistsByPattern: function (pattern) {
        return window.external.FileExistsByPattern(pattern);
    },
    fileDelete: function (path) {
        return window.external.FileDelete(path);
    },
    _internalStartDesigner: function (designerUrl) {
        window.external.DesignerReturnUrl = window.location.href;
        window.location.href = designerUrl;
    },
    startDesigner: function () {
        if (this._waitingToStartDesigner)
            return;
        var designerUrl = window.external.DesignerHomeUrl;
        if (designerUrl == null) {
            if (confirm('You need to acquire a Code OnTime activation code.\nProceed?'))
                $openUrl('http://codeontime.com/buy');
        }
        else {
            CodeOnTime.Client._internalStartDesigner(designerUrl);
        }
    },
    displayName: function (projectName) {
        var path = String.format('{0}\\{1}\\DataAquarium.Project.xml', window.external.ProjectLocation, projectName),
            project = window.external.LoadFromProjectsRootWithPath(path);
        return project ? (CodeOnTime.Client.readProperty(project, 'p:project/@displayName') || projectName) : '';
    },
    getSyncSettings: function (projectID, projectName) {
        return window.external.GetSyncSettings(projectID, projectName);
    },
    configureHost: function (hostType, path) {
        if (hostType != 'DotNetNuke')
            return 'Invalid web application host';
        var success = true;
        if (path == null)
            path = window.external.SelectFolder('Select location of a DotNetNuke portal instance. Choose a folder that contains web.config file of the portal website.');
        if (path.length != 0) {
            var hostSettings = window.external.EnumerateDotNetNukeProperties(path);
            if (hostSettings.length != 0) {
                var m = hostSettings.match(/Path=(.+?);;;/);
                $get('DnnPath').value = m ? m[1] : '';
                m = hostSettings.match(/TargetFramework=(.+?);;;/);
                $get('TargetFramework').value = m ? m[1] : '4.0';
                if ($get('DatabaseConnectionDialog_ConnectionString').value == '') {
                    m = hostSettings.match(/connectionString=(.+?);;;/);
                    $get('DatabaseConnectionDialog_ConnectionString').value = m ? m[1] : '';
                    m = hostSettings.match(/providerName=(.+?);;;/);
                    if (m)
                        $get('DatabaseConnectionDialog_ProviderName').value = m[1];
                    $get('DatabaseConnectionDialog_HostDatabaseSharing').checked = true;
                }
            }
            else {
                alert(String.format('Folder "{0}" is not a valid DotNetNuke portal instance.', path));
                success = false;
            }
        }
        return success;
    },
    get_isAzureFactory: function () {
        return typeof (IsAzureFactory) != 'undefined' && IsAzureFactory();
    },
    get_isSharePointFactory: function () {
        return typeof (IsSharePointFactory) != 'undefined' && IsSharePointFactory();
    },
    get_isPremium: function () {
        return window.external.IsPremium; // && false;
    },
    get_isStandard: function () {
        return window.external.IsStandard; // && false;
    },
    get_isUnlimited: function () {
        return window.external.IsUnlimited; // && false;
    },
    get_subscriptionLevel: function () {
        window.external.SubscriptionLevel = null;
        return window.external.SubscriptionLevel;
    },
    get_codeDomProvider: function (providerName) {
        return window.external.GetCodeDomProvider(providerName);
    },
    updateSubscriptionLevel: function () {
        window.external.SubscriptionLevel = null;
    },
    get_sqlExpressStatus: function () {
        return window.external.GetSqlExpressStatus();
    },
    executeExcelAction: function (action) {
        var designerUrl = window.external.DesignerHomeUrl;
        if (!this.get_isPremium()) {
            if (confirm('You need to acquire a Code OnTime Premium activation code.\nProceed?'))
                $openUrl('http://codeontime.com/subscriptions.aspx');
        }
        else {
            return window.external.ExecuteExcelAction(action);
        }
        return false;
    },
    get_designerSpreadsheetExists: function () {
        return window.external.DesignerSpreadsheetExists();
    },
    get_property: function (name) {
        var o = window.external.GetProperty(name);
        if (o == null)
            return null;
        o = Sys.Serialization.JavaScriptSerializer.deserialize(o);
        return o;
    },
    set_property: function (name, value) {
        window.external.SetProperty(name, Sys.Serialization.JavaScriptSerializer.serialize(value));
    },
    install: function (force) {
        this._forceInstall = force;
        this._subscriptions = this.get_subscriptions();
        if (this._subscriptions == null || this._subscriptions.match(this.EmptyStringRegex))
            this._subscriptions = 'Free';
        Sys.Net.WebServiceProxy.invoke(CodeOnTime._ClientLibrary._libraryService, "GetFolders", false, { 'subscriptions': this._subscriptions }, Function.createDelegate(this, this._onGetFoldersSuccess), Function.createDelegate(this, this._methodFailure));
        $get('InstallStatus').innerHTML = 'Preparing to install the code generation library....';
    },
    _showError: function (error) {
        if ($get('InstallError'))
            $get('InstallError').innerHTML = error.replace(/\r\n/g, '<br/>');
        else
            alert(error);
    },
    _resetInstallation: function () {
        if (this._timerID) {
            window.clearInterval(this._timerID);
            this._timerID = null;
        }
        this._installFolders = [];
        this._folderBusy = false;
        this._installFiles = [];
        this._fileBusy = false;
        this._fileBlockIndex = 0;
    },
    _methodFailure: function (error, method, context) {
        this._resetInstallation();
        var sb = new Sys.StringBuilder();
        sb.append(String.format('<b>{0}</b>', error.get_message()));
        sb.appendLine();
        sb.appendLine();
        sb.appendLine('Stack Trace:');
        sb.append(error.get_stackTrace());
        this._showError(sb.toString());
    },
    _onGetFoldersSuccess: function (result, context) {
        this._installFolders = result;
        var updateAvailable = false;
        var sb = new Sys.StringBuilder();
        for (var i = 0; i < result.length; i++) {
            var folderInfo = result[i];
            if (folderInfo.Name == '__Expired') {
                if (confirm('Your activation code has expired.\n\n' +
                    'Click OK to renew if you want to continue receving\n' +
                    'web application generator and code generation library\n' +
                    'updates.\n\n' +
                    'The code generator will continue to work on this computer\n' +
                    'if you do not choose to renew.'))
                    $openUrl("http://codeontime.com/buy");
                return;
            }
            folderInfo.UpdateIsRequired = window.external.LibraryFolderUpdateIsRequired(folderInfo.Release, folderInfo.Name);
            folderInfo.Index = i;
            if (folderInfo.UpdateIsRequired) {
                updateAvailable = true;
                sb.append(String.format('<div style="margin-top:2px"><span id="InstallStatusIndicator{0}" class="InstallCurrent" style="visibility:hidden;">&nbsp;&nbsp;</span><span>{1}</span></div>', i, folderInfo.Name));
            }
        }
        if (updateAvailable) {
            $get('InstallPlan').innerHTML = sb.toString();
            var install = true;
            if (!this._forceInstall && !confirm('An update of the code generation library is available.\r\nInstall?'))
                install = false;
            $openUrl('http://codeontime.com/blog/label/Release%20Notes');
            if (!install)
                return;
            if ($get('InstallDialog'))
                this.showDialog('InstallDialog');
            this._timerID = window.setInterval('CodeOnTime.Client._executeInstallStep()', 100);
        }
    },
    _nextInstallFolder: function (skipCurrent) {
        if (skipCurrent)
            Array.removeAt(this._installFolders, 0);
        while (this._installFolders.length > 0 && !this.get_currentInstallFolder().UpdateIsRequired)
            Array.removeAt(this._installFolders, 0);
    },
    _executeInstallStep: function () {
        if (!this._folderBusy && this.get_currentInstallFolder()) {
            this._nextInstallFolder(false);
            if (this.get_currentInstallFolder()) {
                Sys.UI.DomElement.setVisible($get('InstallStatusIndicator' + this.get_currentInstallFolder().Index), true);
                try {
                    window.external.BackupLibraryFolder(this.get_currentInstallFolder().Release, this.get_currentInstallFolder().Name);
                }
                catch (ex) {
                    this._showError(ex.message);
                    this._resetInstallation();
                    return;
                }
                this._folderBusy = true;
                Sys.Net.WebServiceProxy.invoke(CodeOnTime._ClientLibrary._libraryService, "GetFiles", false,
                    { release: this.get_currentInstallFolder().Release, folder: this.get_currentInstallFolder().Name, subscriptions: this._subscriptions },
                    Function.createDelegate(this, this._onGetFilesSuccess), Function.createDelegate(this, this._methodFailure));
                $get('InstallStatus').innerHTML = String.format('Downloading the list of files for the <b>{0}</b> folder...', this.get_currentInstallFolder().Name);
            }
        }
        if (!this._fileBusy && this.get_currentInstallFile()) {
            this._fileBusy = true;
            Sys.Net.WebServiceProxy.invoke(CodeOnTime._ClientLibrary._libraryService, "GetFileBlock", false,
                {
                    release: this.get_currentInstallFolder().Release, folder: this.get_currentInstallFolder().Name, subscriptions: this._subscriptions,
                    name: this.get_currentInstallFile(), blockIndex: this._fileBlockIndex++
                },
                Function.createDelegate(this, this._onGetFileBlockSuccess), Function.createDelegate(this, this._methodFailure));
            $get('InstallStatus').innerHTML = String.format('Installing <b>{1}</b> file block <b>#{2}</b> to the <b>{0}</b> folder...', this.get_currentInstallFolder().Name, this.get_currentInstallFile(), this._fileBlockIndex);
        }
    },
    get_currentInstallFolder: function () {
        return this._installFolders.length > 0 ? this._installFolders[0] : null;
    },
    get_currentInstallFile: function () {
        return this._installFiles.length > 0 ? this._installFiles[0] : null;
    },
    _onGetFilesSuccess: function (result, context) {
        this._installFiles = result;
    },
    _onGetFileBlockSuccess: function (result, context) {
        if (result == null) {
            Array.removeAt(this._installFiles, 0);
            this._fileBlockIndex = 0;
            if (this._installFiles.length == 0) {
                var indicator = $get('InstallStatusIndicator' + this.get_currentInstallFolder().Index);
                Sys.UI.DomElement.addCssClass($get('InstallStatusIndicator' + this.get_currentInstallFolder().Index), 'InstallCompleted');
                this._nextInstallFolder(true);
                this._folderBusy = false;
                if (!this.get_currentInstallFolder()) {
                    $get('InstallStatus').innerHTML = 'Installation has completed successfully.';
                    this.home();
                }
            }
        }
        else
            window.external.InstallLibraryFile(this.get_currentInstallFolder().Release, this.get_currentInstallFolder().Name, this.get_currentInstallFile(), result);
        this._fileBusy = false;
    },
    get_subscriptions: function () {
        return window.external.Subscriptions;
    },
    set_subscripions: function (value) {
        window.external.Subscriptions = value;
    },
    getVisualStudioPath: function (version) {
        return window.external.GetVisualStudioPathCOM(version);
    },
    getHighestVisualStudioPath: function () {
        return this.getVisualStudioPath('2019') || this.getVisualStudioPath('2017') || this.getVisualStudioPath('2015') || this.getVisualStudioPath('2013') || this.getVisualStudioPath('2012') || this.getVisualStudioPath('2010') || this.getVisualStudioPath('2008');
    },
    home: function () {
        this.sendRequest({ Name: 'Home' });
    },
    loadResource: function (path) {
        return window.external.LoadResource(path);
    },
    appendResource: function (path, containerId) {
        var text = this.loadResource(path);
        var tempContainer = document.createElement('div');
        tempContainer.innerHTML = text;
        if (containerId == null)
            containerId = 'PageDialogCell';
        var container = $get(containerId);
        while (tempContainer.childNodes.length > 0) {
            var template = tempContainer.childNodes[0];
            while (template && !template.tagName)
                template = template.nextSibling;
            if (template) {
                var elem = document.createElement(template.tagName);
                container.appendChild(elem);
                elem.setAttribute('id', template.getAttribute('id'));
                elem.className = 'Dialog';
                elem.setAttribute('_title', template.getAttribute('title'));
                elem.innerHTML = template.innerHTML;
                tempContainer.removeChild(template);
            }
            else
                break
        }
        delete tempContainer;
    },
    _get_connectionStringDialog: function () {
        return this._connectionStringDialog ? this._connectionStringDialog : 'DatabaseConnectionDialog';
    },
    set_connectionStringDialog: function (value) {
        this._connectionStringDialog = value;
    },
    showDatabaseConnectionDialog: function (autoFocus, dialog) {
        this.hideDialog();
        this.set_connectionStringDialog(dialog);
        this.showDialog(this._get_connectionStringDialog());
        if (autoFocus)
            $get(this._get_connectionStringDialog() + '_ConnectionString').focus();
        var sampleDbElem = $get('SqlServer_SampleDatabases');
        var databases = CodeOnTime.Client._listSampleDatabases().split(/;/);
        sampleDbElem.options.length = 0;
        sampleDbElem.options[0] = new Option('(select)', '');
        for (var i = 0; i < databases.length; i++) {
            var db = databases[i];
            if (db != '') {
                var m = db.match(/^\d+\s*(.+)$/)
                var opt = new Option(m ? m[1] : db, db);
                if (m) opt.style.color = '#0066ff';
                sampleDbElem.options[sampleDbElem.length] = opt;
            }
        }

    },
    encryptConnectionString: function (elem) {
        if (!this._connectionStringPasswords)
            this._connectionStringPasswords = {};
        var m = this.ConnectionStringRegex.exec(elem.value);
        if (m && !m[3].match(/^\*+$/)) {
            this._connectionStringPasswords[elem.id] = m[3];
            elem.value = elem.value.replace(this.ConnectionStringRegex, '$1*****$4');
        }
    },
    decryptConnectionString: function (elem) {
        if (this._connectionStringPasswords) {
            var password = this._connectionStringPasswords[elem.id];
            if (password != null) {
                var m = this.ConnectionStringRegex.exec(elem.value);
                if (m && m[3].match(/^\*+$/))
                    return elem.value.replace(this.ConnectionStringRegex, '$1' + password.replace(/\$/g, '$$$$') + '$4');
            }
        }
        return elem.value;
    },
    initializeDatabaseConnectionDialog: function (text, providerName, connectionString, dataObjectFilter, dataObjectGenerate, hostDatabaseSharing, metadataFileName, sessionStateMode, callbacks) {

        var isAzureFactory = this.get_isAzureFactory();

        this._metadataFileName = metadataFileName;
        this._callbacks = callbacks ? callbacks : [];
        this.appendResource('_System\\Resources.ConnectionString.htm');
        $get('DatabaseConnectionDialog_Text').innerHTML = text;
        var providerNameElem = $get('DatabaseConnectionDialog_ProviderName');
        if (!providerName || providerName == "")
            providerNameElem.selectedIndex = 3;
        else {
            for (var i = 0; i < providerNameElem.options.length; i++) {
                if (providerNameElem.options[i].value == providerName) {
                    providerNameElem.selectedIndex = i;
                    break;
                }
            }
        }
        CodeOnTime.Client.verifyProviderName(providerNameElem);

        var providerSelect = $get('DatabaseConnectionDialog_ProviderName');
        if (this.get_isAzureFactory()) {
            Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_ProviderName_Container'), false);
            var message = $get('DatabaseConnectionDialog_Text');
            message.innerText += "\n\nPlease enter a connection string for your Microsoft SQL Server database.";
        }
        else if (connectionString == '')
            providerSelect.size = '14';

        this.set_sessionStateMode(sessionStateMode);
        $get('SessionStateMode').value = sessionStateMode;
        var connectionStringElem = $get('DatabaseConnectionDialog_ConnectionString');
        connectionStringElem.value = connectionString;
        this.encryptConnectionString(connectionStringElem);
        var lastConnectionError = this.showDatabaseError();
        $get('DatabaseConnectionDialog_Filter').value = dataObjectFilter;
        CodeOnTime.Client.configureDatabaseObjectFilter(false);
        this._checkIfMetadataIsAvailable();
        $get('DatabaseConnectionDialog_HostDatabaseSharing').checked = hostDatabaseSharing == 'true';
        if (dataObjectGenerate == 'Controllers')
            $get('DatabaseConnectionDialog_CreateControllers').checked = true;
        else if (dataObjectGenerate == 'None')
            $get('DatabaseConnectionDialog_DoNotCreateControllers').checked = true;
        else
            $get('DatabaseConnectionDialog_CreateControllersAndPages').checked = true;
        return lastConnectionError;
    },
    verifyProviderName: function (select) {
        var isCustomProvider = (select.value == 'CodeOnTime.CustomDataProvider');
        Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_ConnectionStringProperties'), !isCustomProvider);
        Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_ConnectionStringRefreshActions'), !isCustomProvider);
        Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_CustomDataProviderDescription'), isCustomProvider);
        var csInput = (select.id == 'MembershipDialog_ProviderName') ? $get('MembershipDialog_ConnectionString') : $get('DatabaseConnectionDialog_ConnectionString');
        if (isCustomProvider)
            csInput.value = '__none';
        else
            csInput.value = '';
    },
    _executeDialogCallback: function (callbacks, name) {
        if (callbacks)
            for (var i = 0; i < callbacks.length; i++)
                if (callbacks[i].name == name) {
                    eval(callbacks[i].script);
                    break;
                }
    },
    _executeDatabaseConnectionDialogCallback: function (name) {
        this._executeDialogCallback(this._callbacks, name);
        this._initializeDataModels();
    },
    _checkIfMetadataIsAvailable: function () {
        //Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_DeleteMetadataDiv'), CodeOnTime.Client.fileExists(this._metadataFileName));
        Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_DeleteMetadataDiv'), false);
    },
    get_databaseConnectionProvider: function (dialog) {
        if (!dialog) dialog = 'DatabaseConnectionDialog';
        var providerNameElem = $get(dialog + '_ProviderName');
        return providerNameElem.options[providerNameElem.selectedIndex].value;
    },
    get_databaseConnectionString: function (dialog) {
        if (!dialog) dialog = 'DatabaseConnectionDialog';
        return this.decryptConnectionString($get(dialog + '_ConnectionString'));
    },
    get_databaseConnectionHostDatabaseSharing: function () {
        return $get('DatabaseConnectionDialog_HostDatabaseSharing').checked ? 'true' : 'false';
    },
    get_sessionStateMode: function () {
        var mode = this._sessionStateMode;
        if (mode == '' && this.get_variable('ProjectId').match(/Azure Factory/))
            mode == 'ASPNET';
        else
            mode == 'None';
        return mode;
    },
    set_sessionStateMode: function (value) {
        this._sessionStateMode = value;
    },
    get_databaseObjectFilter: function () {
        return $get('DatabaseConnectionDialog_Filter').value;
    },
    get_databaseObjectGeneration: function () {
        if ($get('DatabaseConnectionDialog_CreateControllersAndPages').checked)
            return 'ControllersAndPages';
        if ($get('DatabaseConnectionDialog_CreateControllers').checked)
            return 'Controllers';
        if ($get('DatabaseConnectionDialog_DoNotCreateControllers').checked)
            return 'None';
        else
            return '';

    },
    _validateProjectLevel: function () {
        var success = window.external.ValidateProjectLevel(this.get_databaseObjectGeneration(), this.get_databaseConnectionProvider());

        if (!success) {
            this._toggleTabView('BusinessLogicLayerDialog_TabView', 0);
            setTimeout(function () {
                var dataModeList = $('#dataModelList');
                if (dataModeList.is(':visible'))
                    dataModeList.focus();
            }, 100);
        }
        return success;
    },
    verifyDatabaseObjectFilter: function () {
        var result = window.external.VerifyDatabaseObjectFilter($get('DatabaseConnectionDialog_Filter').value, null, this.get_databaseConnectionProvider(), this.get_databaseConnectionString());
        if (!result && window.external.FileExists("Error.DataAquarium.Metadata.xml"))
            this.showDatabaseError();
        return result;
    },
    showDatabaseError: function () {
        var connectionError = CodeOnTime.Client.loadFromProject('Error.' + this._metadataFileName);
        var lastConnectionError = connectionError.documentElement ? connectionError.selectSingleNode('e:error').xml : null;
        if (lastConnectionError) {
            $get('DatabaseConnectionDialog_ConnectionStringError').innerHTML = lastConnectionError.replace(/\r\n/, '<br/>');
            Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_ConnectionStringError'), true);
            $get('DatabaseConnectionDialog_ConnectionString').focus();
        }
        return lastConnectionError;
    },
    ensureTrust: function () {
        window.external.EnsureTrust(this.get_databaseConnectionProvider());
    },
    validateDatabaseConnectionString: function () {
        var connectionString = this.get_databaseConnectionString();
        var providerName = this.get_databaseConnectionProvider();
        if (connectionString.match(this.EmptyStringRegex) && !(providerName == 'CodeOnTime.CustomDataProvider')) {
            alert('A non-blank connection string is expected.');
            this.showDatabaseConnectionDialog(true);
            return false;
        }
        return true;
    },
    deleteMetadata: function (silent) {
        if (silent == null && !confirm('Delete the cached project metadata?')) return false;
        //this.fileDelete(this._metadataFileName);
        this._checkIfMetadataIsAvailable();
        return true;
    },
    refreshMetadata: function (projectId, projectName, silent, deleteDatabaseModel) {
        if (window.external.SilentRefresh)
            silent = window.external.SilentRefresh;
        var result = window.external.RefreshMetadata(projectId, projectName, silent == true, deleteDatabaseModel != false);
        if (projectId == null)
            this._checkIfMetadataIsAvailable();
        this.modelRefreshRequired = false;
        return result;
    },
    _initializeConnectionStringParameters: function () {
        Array.clear(this._connectionStringParameters);
        var iterator = /\s*([\w ]+)\s*=\s*([\S\s]*?)\s*(;|$)/g;
        var connectionString = this.decryptConnectionString($get(this._get_connectionStringDialog() + '_ConnectionString'));
        var match = iterator.exec(connectionString);
        while (match) {
            var o = RegExp[1];
            Array.add(this._connectionStringParameters, { Name: match[1], Value: match[2] });
            match = iterator.exec(connectionString);
        }
    },
    _get_connectionStringParameter: function (name) {
        name = name.toLowerCase();
        for (var i = 0; i < this._connectionStringParameters.length; i++)
            if (this._connectionStringParameters[i].Name.toLowerCase() == name)
                return this._connectionStringParameters[i];
        Array.add(this._connectionStringParameters, { Name: name, Value: '' });
        return this._connectionStringParameters[this._connectionStringParameters.length - 1];
    },
    _runConnectionStringWizard: function (dialog) {
        this.set_connectionStringDialog(dialog);
        this._initializeConnectionStringParameters();
        Sys.UI.DomElement.setVisible($get('SqlServer_Azure_SampleDatabases'), true);
        Sys.UI.DomElement.setVisible($get('SqlServer_CMS'), true);
        Sys.UI.DomElement.setVisible($get('MySQL_CMS'), true);
        Sys.UI.DomElement.setVisible($get('Oracle_CMS'), true);
        Sys.UI.DomElement.setVisible($get('SqlServer_SessionState'), true);
        Sys.UI.DomElement.setVisible($get('Oracle_SessionState'), true);
        Sys.UI.DomElement.setVisible($get('MySQL_SessionState'), true);
        Sys.UI.DomElement.setVisible($get('SessionStateModeWrapper'), this.get_isAzureFactory());
        CodeOnTime.Client._switchSessionStateMode();
        if (this.get_isHostedFactory())
            Sys.UI.DomElement.setVisible($get('SqlServer_Azure_Membership'), false);
        if (this.get_isHostedFactory() || dialog == "MembershipDialog") {
            Sys.UI.DomElement.setVisible($get('SqlServer_Azure_SampleDatabases'), false);
            Sys.UI.DomElement.setVisible($get('SqlServer_CMS'), false);
            Sys.UI.DomElement.setVisible($get('MySQL_CMS'), false);
            Sys.UI.DomElement.setVisible($get('Oracle_CMS'), false);
            Sys.UI.DomElement.setVisible($get('Oracle_SessionState'), false);
            Sys.UI.DomElement.setVisible($get('MySQL_SessionState'), false);
            Sys.UI.DomElement.setVisible($get('SqlServer_SessionState'), false);
        }
        switch (this.get_databaseConnectionProvider(dialog)) {
            case 'System.Data.SqlClient':
                this._configureSqlServerConnection(dialog);
                break;
            case 'System.Data.OracleClient':
            case 'Oracle.DataAccess.Client':
            case 'Oracle.ManagedDataAccess.Client':
                this._configureOracleConnection(dialog);
                break;
            case 'System.Data.OleDb':
                this._configureAccessConnection(dialog);
                break;
            case 'MySql.Data.MySqlClient':
                this._configureMySQLConnection(dialog);
                break;
            case 'IBM.Data.DB2':
                this._configureDB2Connection(dialog);
                break;
            case 'Npgsql':
                this._configurePostgreSQLConnection(dialog);
                break;
            case 'FirebirdSql.Data.FirebirdClient':
                this._configureFirebirdConnection(dialog);
                break;
            default:
                alert('Please enter a valid connection string directly in the input field.\nThe connection string wizard is not available for this data provider.');
                $get(dialog && dialog.match(/Membership/) ? 'MembershipDialog_ConnectionString' : 'DatabaseConnectionDialog_ConnectionString').focus();
                break;
        }
    },
    configureDatabaseObjectFilter: function (showUI, filter, fromConfigureVisibility) {
        var providerNameElem = $get('DatabaseConnectionDialog_ProviderName');
        var connectionStringElem = $get('DatabaseConnectionDialog_ConnectionString');
        var filterElem = $get('DatabaseConnectionDialog_Filter');
        var filterSummaryElem = $get('DatabaseConnectionDialog_FilterSummary');
        if (window.external.DataModelRequired) {
            Sys.UI.DomElement.setVisible(filterSummaryElem.parentNode, false);
            return;
        }
        if (!filter) filter = filterElem.value;
        if (filter == '__none') {
            filter = '';
            $get('DatabaseConnectionDialog_DoNotCreateControllers').checked = true;
        }
        if (showUI) {
            var oldFilter = filter;
            filter = window.external.SelectDatabaseObjects(providerNameElem.value, this.decryptConnectionString(connectionStringElem), filterElem.value);
            $get('DatabaseConnectionDialog_ConnectionString').focus();
            //if (oldFilter != filter)
            //    this.deleteMetadata(false);
        }
        if (!fromConfigureVisibility && !this._configureObjectFilterVisibility())
            return;
        var sb = new Sys.StringBuilder();
        if (filter.length == 0)
            sb.append('<b>All database tables and views are included in this project.</b> <a href=\"javascript:\" id=\"DatabaseConnectionDialog_SelectTables2\" onclick="CodeOnTime.Client.configureDatabaseObjectFilter(true);return false;\" title=\"Select the database tables and views for this project.\">Change</a>');
        else {
            Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_SelectTables'), true);
            var list = filter.split(';');
            var rowsPerColumns = Math.ceil(list.length / 3);
            if (rowsPerColumns > 0) {
                sb.append('The following database objects are included in this project:');
                var currentRow = 0;
                for (var i = 0; i < list.length; i++) {
                    if (currentRow++ == 0)
                        sb.append('<div style="float:left;"><ul style="margin:4px 20px;">');
                    sb.append(String.format('<li>{0}</li>', list[i]));
                    if (currentRow == rowsPerColumns) {
                        currentRow = 0;
                        sb.append('</ul></div>');
                    }
                }
            }
            sb.append('<div style="clear:left;"></div>');
        }
        filterElem.value = filter;
        $get('DatabaseConnectionDialog_FilterSummary').innerHTML = sb.toString();
    },
    _configureObjectFilterVisibility: function () {
        var createControllers = $get('DatabaseConnectionDialog_CreateControllers').checked || $get('DatabaseConnectionDialog_CreateControllersAndPages').checked;
        if (!createControllers) {
            Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_FilterSummary').parentNode, false);
            Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_SelectTables'), false);
            $get('DatabaseConnectionDialog_Filter').value = "__none";
            return false;
        }
        else {
            Sys.UI.DomElement.setVisible($get('DatabaseConnectionDialog_FilterSummary').parentNode, true);
            $get('DatabaseConnectionDialog_Filter').value = "";
            if ($get('DatabaseConnectionDialog_ConnectionString').value)
                this.configureDatabaseObjectFilter(false, null, true);
            return true;
        }
    },
    _saveConnectionString: function (val) {
        var connectionStringElem = $get(this._get_connectionStringDialog() + '_ConnectionString');
        connectionStringElem.value = val;
        this.encryptConnectionString(connectionStringElem);
        this.resetDatabaseModel();
        var memCS = $get('MembershipDialog_ConnectionString').value;
        $('#MembershipCS_Different_Warning').toggle(memCS != '' && memCS != val);
    },
    _configureMembershipConnectionString: function (stringFunc) {
        if (this._get_membershipSupportEnabled() && this._get_connectionStringDialog() == 'DatabaseConnectionDialog') {
            var membershipEnabledElem = $get('MembershipDialog_Enabled');
            if (true/*!membershipEnabledElem.checked*/) {
                membershipEnabledElem.checked = true;
                var providerName = $get('DatabaseConnectionDialog_ProviderName').value;
                if (providerName)
                    $get('MembershipDialog_ProviderName').value = providerName;
                $get('MembershipDialog_StandaloneDatabase_Container').disabled = false;
                $get('MembershipDialog_ConnectionStringSettings').disabled = false;
                CodeOnTime.Client.toggleMembershipOptions(membershipEnabledElem, false);
                var membershipConnectionStringElem = $get('MembershipDialog_ConnectionString');
                membershipConnectionStringElem.value = stringFunc(this.get_databaseConnectionProvider());
                this.encryptConnectionString(membershipConnectionStringElem);
            }
        }
    },
    _configureOracleConnection: function () {
        this.hideDialog();
        this.showDialog('OracleClientConnectionDialog');
        $get('Oracle_ServerName').value = this._get_connectionStringParameter('Data Source').Value;
        $get('Oracle_UserName').value = this._get_connectionStringParameter('User ID').Value;
        $get('Oracle_Password').value = this._get_connectionStringParameter('Password').Value;
        $get('Oracle_ServerName').focus();
    },
    _createOracleConnectionString: function (provider) {
        var sb = new Sys.StringBuilder();
        sb.append(String.format('Data Source={0};', $get('Oracle_ServerName').value));
        sb.append(String.format('User ID={0};', $get('Oracle_UserName').value));
        sb.append(String.format('Password={0};', $get('Oracle_Password').value));
        if (provider == '')
            provider = this.get_databaseConnectionProvider();
        if (provider == 'System.Data.OracleClient')
            sb.append('Persist Security Info=True;Unicode=True;');
        return sb.toString();
    },
    _saveOracleConnectionString: function () {
        //this.hideDialog();
        //this.showDialog(this._get_connectionStringDialog());
        this.showDatabaseConnectionDialog(true, this._get_connectionStringDialog());
        this._saveConnectionString(this._createOracleConnectionString());
        this._configureMembershipConnectionString(this._createOracleConnectionString);
    },
    _configureMySQLConnection: function () {
        this.hideDialog();
        this.showDialog('MySQLConnectionDialog');
        $get('MySQL_ServerName').value = this._get_connectionStringParameter('Server').Value;
        $get('MySQL_UserName').value = this._get_connectionStringParameter('User ID').Value;
        $get('MySQL_Password').value = this._get_connectionStringParameter('Password').Value;
        $get('MySQL_Database').value = this._get_connectionStringParameter('Database').Value;
        $get('MySQL_ServerName').focus();
    },
    _createMySQLConnectionString: function () {
        var sb = new Sys.StringBuilder();
        sb.append(String.format('Server={0};', $get('MySQL_ServerName').value));
        sb.append(String.format('User ID={0};', $get('MySQL_UserName').value));
        sb.append(String.format('Password={0};', $get('MySQL_Password').value));
        sb.append(String.format('Database={0};', $get('MySQL_Database').value));
        sb.append('Persist Security Info=True;');
        return sb.toString();
    },
    _saveMySQLConnectionString: function () {
        //this.hideDialog();
        //this.showDialog(this._get_connectionStringDialog());
        this.showDatabaseConnectionDialog(true, this._get_connectionStringDialog());
        this._saveConnectionString(this._createMySQLConnectionString());
        $get('MembershipDialog_Enabled').checked = true;
        $get('MembershipDialog_StandaloneDatabase_Container').disabled = false;
        $get('MembershipDialog_ConnectionStringSettings').disabled = false;
        CodeOnTime.Client.toggleMembershipOptions(true, false);
        $get('MembershipDialog_ProviderName').value = $get('DatabaseConnectionDialog_ProviderName').value;
        var membershipConnectionStringElem = $get('MembershipDialog_ConnectionString');
        membershipConnectionStringElem.value = this._createMySQLConnectionString();
        this.encryptConnectionString(membershipConnectionStringElem);
    },
    _configureFirebirdConnection: function () {
        this.hideDialog();
        this.showDialog('FirebirdConnectionDialog');
        $get('Firebird_ServerName').value = this._get_connectionStringParameter('data source').Value;
        $get('Firebird_UserName').value = this._get_connectionStringParameter('user id').Value;
        $get('Firebird_Password').value = this._get_connectionStringParameter('password').Value;
        $get('Firebird_Database').value = this._get_connectionStringParameter('initial catalog').Value;
        $get('Firebird_ServerName').focus();
    },
    _createFirebirdConnectionString: function () {
        var sb = new Sys.StringBuilder();
        // character set=NONE;data source=127.0.0.1;initial catalog="C:\Program Files\Firebird\Firebird_2_5\examples\empbuild\EMPLOYEE.FDB";user id=SYSDBA;password=masterkey;dialect=3;server type=0
        sb.append('character set=NONE;');
        sb.append(String.format('data source={0};', $get('Firebird_ServerName').value));
        sb.append(String.format('initial catalog={0};', $get('Firebird_Database').value.replace(/"/g, "")));
        sb.append(String.format('user id={0};', $get('Firebird_UserName').value));
        sb.append(String.format('password={0};', $get('Firebird_Password').value));
        sb.append('dialect=3;server type=0');
        return sb.toString();
    },
    _saveFirebirdConnectionString: function () {
        //this.hideDialog();
        //this.showDialog(this._get_connectionStringDialog());
        this.showDatabaseConnectionDialog(true, this._get_connectionStringDialog());
        this._saveConnectionString(this._createFirebirdConnectionString());
    },
    _configureDB2Connection: function () {
        this.hideDialog();
        this.showDialog('DB2ConnectionDialog');
        $get('DB2_Server').value = this._get_connectionStringParameter('Server').Value;
        $get('DB2_Database').value = this._get_connectionStringParameter('Database').Value;
        $get('DB2_UserName').value = this._get_connectionStringParameter('UID').Value;;
        $get('DB2_Password').value = this._get_connectionStringParameter('PWD').Value;
        $get('DB2_Database').focus();
    },
    _saveDB2ConnectionString: function () {
        this.showDatabaseConnectionDialog(true, this._get_connectionStringDialog());
        this._saveConnectionString(this._createDB2ConnectionString());
    },
    _createDB2ConnectionString: function () {
        var sb = new Sys.StringBuilder();
        if ($get('DB2_Server').value != '')
            sb.append(String.format('Server={0};', $get('DB2_Server').value));
        sb.append(String.format('Database={0};', $get('DB2_Database').value));
        if ($get('DB2_UserName').value != '')
            sb.append(String.format('UID={0};', $get('DB2_UserName').value));
        if ($get('DB2_Password').value != '')
            sb.append(String.format('PWD={0};', $get('DB2_Password').value));
        return sb.toString();
    },
    _configurePostgreSQLConnection: function () {
        this.hideDialog();
        this.showDialog('PostgreSQLConnectionDialog');
        $get('PostgreSQL_Host').value = this._get_connectionStringParameter('Host').Value;
        $get('PostgreSQL_Port').value = this._get_connectionStringParameter('Port').Value;
        $get('PostgreSQL_Database').value = this._get_connectionStringParameter('Database').Value;
        $get('PostgreSQL_UserName').value = this._get_connectionStringParameter('User ID').Value;;
        $get('PostgreSQL_Password').value = this._get_connectionStringParameter('Password').Value;
        $get('PostgreSQL_Database').focus();
    },
    _savePostgreSQLConnectionString: function () {
        this.showDatabaseConnectionDialog(true, this._get_connectionStringDialog());
        this._saveConnectionString(this._createPostgreSQLConnectionString());
    },
    _createPostgreSQLConnectionString: function () {
        var sb = new Sys.StringBuilder();
        if ($get('PostgreSQL_Host').value != '')
            sb.append(String.format('Host={0};', $get('PostgreSQL_Host').value));
        if ($get('PostgreSQL_Port').value != '')
            sb.append(String.format('Port={0};', $get('PostgreSQL_Port').value));
        sb.append(String.format('Database={0};', $get('PostgreSQL_Database').value));
        if ($get('PostgreSQL_UserName').value != '')
            sb.append(String.format('User ID={0};', $get('PostgreSQL_UserName').value));
        if ($get('PostgreSQL_Password').value != '')
            sb.append(String.format('Password={0};', $get('PostgreSQL_Password').value));
        return sb.toString();
    },
    _configureAccessConnection: function () {
        this.hideDialog();
        this.showDialog('AccessConnectionDialog');
        $get('Access_FileName').value = this._get_connectionStringParameter('Data Source').Value;
        $get('Access_UserName').value = this._get_connectionStringParameter('User ID').Value;;
        $get('Access_Password').value = this._get_connectionStringParameter('Password').Value;
        $get('Access_FileName').focus();
    },
    _saveAccessConnectionString: function () {
        this.showDatabaseConnectionDialog(true, this._get_connectionStringDialog());
        this._saveConnectionString(this._createAccessConnectionString());
    },
    _createAccessConnectionString: function () {
        var sb = new Sys.StringBuilder();
        sb.append(String.format('Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};', $get('Access_FileName').value));
        sb.append(String.format('User Id={0};', $get('Access_UserName').value));
        sb.append(String.format('Password={0};', $get('Access_Password').value));
        return sb.toString();
    },
    _configureSqlServerConnection: function () {
        this.hideDialog();
        this.showDialog('SqlServerConnectionDialog');
        $get('SqlServer_Name').value = this._get_connectionStringParameter('Data Source').Value;
        $get('SqlServer_Database').value = this._get_connectionStringParameter('Initial Catalog').Value;
        if (this.get_isAzureFactory()) {
            $get('SqlServer_WindowsAuthentication').checked = false;
            $get('SqlServer_WindowsAuthentication').disabled = true;
            $get('SqlServer_SqlServerAuthentication').checked = true;
        }
        if (!this.get_isAzureFactory() && (this._get_connectionStringParameter('Integrated Security').Value.toLowerCase() == 'true' || !(this._get_connectionStringParameter('Persist Security Info').Value.toLowerCase() == 'true'))) {
            $get('SqlServer_WindowsAuthentication').checked = true;
            $get('SqlServer_UserName').value = '';
            $get('SqlServer_Password').value = '';
        }
        else {
            $get('SqlServer_SqlServerAuthentication').checked = true;
            $get('SqlServer_UserName').value = this._get_connectionStringParameter('User ID').Value;
            $get('SqlServer_Password').value = this._get_connectionStringParameter('Password').Value;
        }
        $get('SqlServer_Name').focus();
        var allowASPNETSessionProvider = this.get_isAzureFactory() && this._verifySessionStateSupport(true);
        Sys.UI.DomElement.setVisible($get('SessionStateModeWrapper'), allowASPNETSessionProvider);
        $get('SessionStateMode').value = allowASPNETSessionProvider ? 'ASPNET' : 'Custom';
        this._switchSessionStateMode();
        this._updateSqlServerConnectionControls(false);
    },
    _updateSqlServerConnectionControls: function (allowChangeFocus) {
        if (allowChangeFocus == null)
            allowChangeFocus = true;
        if ($get('SqlServer_WindowsAuthentication').checked) {
            $get('SqlServer_UserName').disabled = true;
            $get('SqlServer_Password').disabled = true;
        }
        else {
            $get('SqlServer_UserName').disabled = false;
            if (allowChangeFocus)
                $get('SqlServer_UserName').focus();
            $get('SqlServer_Password').disabled = false;
        }
    },
    _createSqlServerConnectionString: function (skipParameters) {
        if (skipParameters == null) skipParameters = [];
        var sb = new Sys.StringBuilder();
        sb.append(String.format('Data Source={0};', $get('SqlServer_Name').value));
        if (Array.indexOf(skipParameters, 'Initial Catalog') == -1)
            sb.append(String.format('Initial Catalog={0};', $get('SqlServer_Database').value));
        if ($get('SqlServer_WindowsAuthentication').checked)
            sb.append('Integrated Security=True;');
        else {
            sb.append('Persist Security Info=True;');
            sb.append(String.format('User ID={0};', $get('SqlServer_UserName').value));
            sb.append(String.format('Password={0};', $get('SqlServer_Password').value));
        }
        return sb.toString();
    },
    _saveSqlServerConnectionString: function () {
        //        this.hideDialog();
        //        this.showDialog(this._get_connectionStringDialog());
        if (this.get_isAzureFactory()) {
            if (!this._verifySessionStateSupport(true) && !this._verifyCustomSessionStateSupport(true) && confirm('Session State support is not installed in the application database.\nAzure Factory applications require session state in order to run on multiple instances of Compute servers in Azure cloud.\n\nInstall?'))
                this._addCustomSessionStateSupport(true);
        }
        this.showDatabaseConnectionDialog(true, CodeOnTime.Client._get_connectionStringDialog())
        this._saveConnectionString(this._createSqlServerConnectionString());
        this._configureMembershipConnectionString(this._createSqlServerConnectionString);
    },
    _showDataSources: function () {
        var nameList = $get('SqlServer_NameList');
        if (Sys.UI.DomElement.getVisible(nameList))
            Sys.UI.DomElement.setVisible(nameList, false);
        else {
            var dataSources = window.external.DiscoverDataSources('System.Data.SqlClient');
            var list = dataSources.selectNodes('/DocumentElement/SqlDataSources');
            if (list.length == 0)
                alert('No data sources available.');
            else {
                nameList.innerHTML = '';
                for (var i = 0; i < list.length; i++) {
                    var serverNameNode = list.get(i).selectSingleNode('ServerName');
                    var instanceNameNode = list.get(i).selectSingleNode('InstanceName');
                    var serverName = String.format('{0}{1}', serverNameNode ? serverNameNode.text : '', instanceNameNode ? '\\' + instanceNameNode.text : '');
                    var option = document.createElement('option');
                    option.setAttribute('value', serverName);
                    option.innerHTML = serverName;
                    if (option.value.toLowerCase() == $get('SqlServer_Name').value.toLowerCase())
                        option.setAttribute('selected', 'selected');
                    nameList.appendChild(option);
                }
                Sys.UI.DomElement.setVisible(nameList, true);
            }
        }
    },
    _showDatabases: function () {
        var databaseList = $get('SqlServer_DatabaseList');
        if (Sys.UI.DomElement.getVisible(databaseList))
            Sys.UI.DomElement.setVisible(databaseList, false);
        else {
            var databases = window.external.DiscoverDatabases('System.Data.SqlClient', this._createSqlServerConnectionString(['Initial Catalog']), 'Databases');
            if (!databases) return;
            var list = databases.selectNodes('/DocumentElement/Databases/database_name');
            if (list.length == 0)
                alert('No databases available.');
            else {
                databaseList.innerHTML = '';
                for (var i = 0; i < list.length; i++) {
                    var databaseName = list.get(i).text;
                    var option = document.createElement('option');
                    option.setAttribute('value', databaseName);
                    option.innerHTML = databaseName;
                    if (databaseName.toLowerCase() == $get('SqlServer_Database').value.toLowerCase())
                        option.setAttribute('selected', 'selected');
                    databaseList.appendChild(option);
                }
                Sys.UI.DomElement.setVisible(databaseList, true);
            }
        }
    },
    _createDatabase: function (databaseProperty) {
        return window.external.CreateDatabase(this._get_connectionStringProviderName(), this._createDatabaseConnectionString(), databaseProperty);
    },
    _createDatabaseConnectionString: function (providerName) {
        if (!providerName)
            providerName = this.get_databaseConnectionProvider();
        switch (providerName) {
            case 'System.Data.SqlClient':
                return this._createSqlServerConnectionString();
            case 'System.Data.OracleClient':
            case 'Oracle.DataAccess.Client':
            case 'Oracle.ManagedDataAccess.Client':
                return this._createOracleConnectionString();
            case 'MySql.Data.MySqlClient':
                return this._createMySQLConnectionString();
            case 'IBM.Data.DB2':
                return this._createDB2ConnectionString();
            case 'Npgsql':
                return this._createPostgreSQLConnectionString();
            case 'System.Data.OleDb':
                return this._createAccessConnectionString();
            case 'FirebirdSql.Data.FirebirdClient':
                return this._createFirebirdConnectionString();
            default:
                return '';
        }
    },
    _get_connectionStringProviderName: function () {
        return $get(this._get_connectionStringDialog() + '_ProviderName').value;
    },
    _testConnection: function () {
        var providerName = this._get_connectionStringProviderName();
        var result = this.testConnectionString(providerName, this._createDatabaseConnectionString(providerName));
        //alert(result ? result : 'Test connection succeeded.');
    },
    testConnectionString: function (providerName, connectionString) {
        window.external.TestConnectionString(providerName, connectionString);
    },
    _get_membershipSupportEnabled: function () {
        return this._membershipSupportEnabled == true;
    },
    _verifyMembershipSupport: function () {
        var providerName = this._get_connectionStringProviderName();
        var result = window.external.VerifyMembershipSupport(providerName, this._createDatabaseConnectionString(providerName));
        if (result)
            this._membershipSupportEnabled = true;
        return result
    },
    _listSampleDatabases: function () {
        return window.external.ListSampleDatabases(this._get_connectionStringProviderName());
    },
    _aboutSampleDatabase: function (database) {
        window.external.AboutSampleDatabase(this._get_connectionStringProviderName(), database);
    },
    _installSampleDatabase: function (database) {
        var providerName = this._get_connectionStringProviderName();
        window.external.InstallSampleDatabase(providerName, this._createDatabaseConnectionString(providerName), database);
        this.deleteMetadata(true);
    },
    _uninstallSampleDatabase: function (database) {
        var providerName = this._get_connectionStringProviderName();
        window.external.UninstallSampleDatabase(providerName, this._createDatabaseConnectionString(providerName), database);
        this.deleteMetadata(true);
    },
    _addMembershipSupport: function () {
        if (!confirm('Click OK to create tables and stored procedures required to support ASP.NET Membership and Role Manager in the database.')) return;
        var providerName = this._get_connectionStringProviderName();
        window.external.AddMembershipSupport(providerName, this._createDatabaseConnectionString(providerName));
        this._membershipSupportEnabled = true;
    },
    _removeMembershipSupport: function () {
        if (!confirm('Click OK to delete ASP.NET Membership and Role Manager tables and stored procedures from the database.\n\nAll user accounts and roles stored in standard ASP.NET Membership tables will be permanently deleted.')) return;
        var providerName = this._get_connectionStringProviderName();
        window.external.RemoveMembershipSupport(providerName, this._createDatabaseConnectionString(providerName));
        this._membershipSupportEnabled = false;
    },
    _verifySessionStateSupport: function (silent) {
        var providerName = this._get_connectionStringProviderName();
        var connString = this._createDatabaseConnectionString(providerName);
        var result = window.external.VerifySessionStateSupport(providerName, connString, silent == true);
        //alert("Provider Name: " + providerName + "\n Connection String: " + connString + "\nResult: " + result);
        if (result)
            this.set_sessionStateMode('ASPNET');
        return result;
    },
    _addSessionStateSupport: function (silent) {
        if (window.external.IsFreeTrial) {
            alert('Session State is not supported in the Trial mode.');
            return;
        }
        if (silent != true && !confirm('Click OK to create tables and stored procedures  required to support ASP.NET Session State in application database.')) return;
        var providerName = this._get_connectionStringProviderName();
        window.external.AddSessionStateSupport(providerName, this._createDatabaseConnectionString(providerName));
        this.set_sessionStateMode('ASPNET');
    },
    _removeSessionStateSupport: function () {
        if (!confirm('Click OK to delete ASP.NET Session State tables and stored procedures from the database.')) return;
        var providerName = this._get_connectionStringProviderName();
        window.external.RemoveSessionStateSupport(providerName, this._createDatabaseConnectionString(providerName));
        this.set_sessionStateMode('None');
    },
    _verifyCustomSessionStateSupport: function (silent) {
        if (window.external.IsFreeTrial) {
            alert('Session State is not supported in the Trial mode.');
            return;
        }
        var providerName = this._get_connectionStringProviderName();
        var result = window.external.VerifyCustomSessionStateSupport(providerName, this._createDatabaseConnectionString(providerName), silent == true);
        if (result)
            this.set_sessionStateMode('Custom');
        else
            this.set_sessionStateMode('None');
        return result;
    },
    _addCustomSessionStateSupport: function (silent) {
        if (window.external.IsFreeTrial) {
            alert('Session State is not supported in the Trial mode.');
            return;
        }
        if (!silent && !confirm('Click OK to create the table required to support Custom Session State in application database.')) return;
        var providerName = this._get_connectionStringProviderName();
        window.external.AddCustomSessionStateSupport(providerName, this._createDatabaseConnectionString(providerName));
        this.set_sessionStateMode('Custom');
    },
    _removeCustomSessionStateSupport: function () {
        if (!confirm('Click OK to delete Custom Session State table from the database.')) return;
        var providerName = this._get_connectionStringProviderName();
        window.external.RemoveCustomSessionStateSupport(providerName, this._createDatabaseConnectionString(providerName));
        this.set_sessionStateMode('None');
    },
    _switchSessionStateMode: function () {
        var mode = $get('SessionStateMode').value;
        if (mode == 'ASPNET') {
            Sys.UI.DomElement.setVisible($get('ASPNETSessionState'), true);
            Sys.UI.DomElement.setVisible($get('CustomSessionState'), false);
        }
        else {
            Sys.UI.DomElement.setVisible($get('ASPNETSessionState'), false);
            Sys.UI.DomElement.setVisible($get('CustomSessionState'), true);
        }
    },
    _verifyCMS: function () {
        var providerName = this._get_connectionStringProviderName();
        window.external.VerifyCMS(providerName, this._createDatabaseConnectionString(providerName));
    },
    _addCMS: function (addUsersAndRoles) {
        var providerName = this._get_connectionStringProviderName(),
            pageImplementation = $get('PageImplementation').value;
        if (pageImplementation == 'aspx') {
            alert('CMS is not supported with "ASPX" page implementation. Please change Page Implementation to "HTML" in order to enable CMS.');
            return;
        }
        if (!confirm('Click OK to add CMS support ' + (addUsersAndRoles ? 'with users and roles ' : '') + 'to your database.')) return;
        window.external.AddCMS(providerName, this._createDatabaseConnectionString(providerName), addUsersAndRoles);
    },
    _removeCMS: function () {
        if (!confirm('Click OK to remove CMS support from your database.')) return;
        var providerName = this._get_connectionStringProviderName();
        window.external.RemoveCMS(providerName, this._createDatabaseConnectionString(providerName));
    },
    _sortModels: function () {
        window.external.ModelSortOrderAlpha = !window.external.ModelSortOrderAlpha;
        this._initializeDataModels();
    },
    _initializeDataModels: function () {
        var generate = this.get_databaseObjectGeneration(),
            generateControllers = generate != 'None' && this.get_databaseConnectionProvider() != 'CodeOnTime.CustomDataProvider';

        Sys.UI.DomElement.setVisible(document.getElementById('dataModelContainer'), generateControllers);
        Sys.UI.DomElement.setVisible(document.getElementById('BusinessLogicLayerDialog_TabView$Tab0').parentNode, generateControllers);

        if (!generateControllers) {
            $('#dataModelContainer').hide();
            this._toggleTabView('BusinessLogicLayerDialog_TabView', 1);
            return;
        }

        var modelString = window.external.GetDataModelsString(),
            connectionString = this.get_databaseConnectionString(),
            providerName = this.get_databaseConnectionProvider(),
            firebird = providerName.match(/Firebird/),
            dataModelList = $('#dataModelList').empty().hide(),
            businessEntityList = $('#businessEntityList').empty().addClass('fullWidth');

        businessEntityList[0].innerHTML = '<div class="emptyListMessage">No tables detected.</div>';

        if (connectionString == '')
            return;

        var controllerString = window.external.GetDatabaseEntities(), //window.external.EnumerateDatabaseTables(providerName, connectionString),
            controllers = controllerString.split(';'),
            models = modelString == '' ? {} : eval('(' + modelString + ')'),
            suggested = [],
            hasSuggested = false,
            useSchemas = false,
            i = 0;

        if (controllers.length != 0) {
            businessEntityList.empty();
            for (model in models) {
                $(models[model].References).each(function () {
                    suggested.push(this);
                });
            }

            var schemas = [];
            $(controllers).each(function () {
                var tableName = this,
                    indexOfDot = tableName.indexOf('.'),
                    schema;
                if (indexOfDot > 0) {
                    schema = tableName.substring(tableName, indexOfDot);
                    if (Array.indexOf(schemas, schema) === -1)
                        schemas.push(schema);
                }

            });

            useSchemas = schemas.length > 1;

            //var firstController = controllers[0],
            //    firstSchema = controllers[0].substring(0, firstController.indexOf('.'));
            //$(controllers).each(function () {
            //    var controller = this,
            //        indexOfDot = controller.indexOf('.');
            //    if (indexOfDot > -1 && controller.substring(0, indexOfDot) != firstSchema)
            //        useSchemas = true;
            //});

            function trimName(name) {
                if (name.startsWith('dbo.'))
                    name = name.substring(4);
                var indexOfDot = name.indexOf('.');
                if (indexOfDot == 0 || !useSchemas)
                    name = name.substring(indexOfDot + 1);
                return name;
            }

            // add a model definition with reference tables to the data model list
            function renderModel(model) {
                var modelTable = trimName(model.Schema + '.' + model.Table),
                    modelLabel = model.Name;
                if (modelTable != modelLabel)
                    modelLabel += ' <span>(' + modelTable + ')</span>';
                var modelContainer = $(String.format('<div class="dataModel customModel" onclick="CodeOnTime.Client.openDataModelBuilder(\'{0}\');return false;">'
                    + '<div class="dataModelName">{1}</div></div>', model.Name, modelLabel));

                if (model.References.length > 0) {
                    var tablesList = $('<div class="dataModelTables"></div>').appendTo(modelContainer),
                        usedTables = [],
                        innerText = '';

                    var first = true;
                    for (var j = 0; j < model.References.length; j++) {
                        var table = trimName(model.References[j]);

                        if ($.inArray(table, usedTables) == -1) {
                            usedTables.push(table);

                            if (j != 0) innerText += ', ';

                            innerText += table;
                        }

                    }
                    tablesList.text(innerText);
                }

                modelContainer.appendTo(dataModelList);
            }


            // add an undefined database object to the object list
            function renderObject(tableName) {
                var name = trimName(tableName);

                var modelContainer = $(
                    '<div class="dataModel" onclick="CodeOnTime.Client.createDataModelBuilder(\'' + tableName.replace(/\'/g, '\\\'') + '\');return false;">'
                    + ' <div class="dataModelName">' + trimName(name) + '</div>'
                    + '</div>');

                modelContainer.appendTo(businessEntityList);
            }

            // check if model defined for table 
            function tableDefined(tableName) {
                var parts = tableName.split('.'),
                    schema, table = tableName;
                if (parts.length > 1) {
                    schema = parts[0];
                    table = parts[1];
                }
                for (name in models) {

                    var model = models[name];
                    if (!schema || model.Schema == schema)
                        if (model.Table == table)
                            return model;
                }
            }
            var hasModels = !$.isEmptyObject(models), undefinedControllers = [];
            if (hasModels) {
                // render two lists
                businessEntityList.removeClass('fullWidth');
                dataModelList.show();
                $('#model-desc-nomodels').hide();
                $('#model-desc-models').show();

                // render first 7 as recent
                var sortedModels = [],
                    modelCount = 0;
                for (model in models) {
                    sortedModels.push(models[model]);
                    modelCount++;
                }

                var sortModelsAlpha = window.external.ModelSortOrderAlpha;

                if (!sortModelsAlpha)
                    sortedModels.sort(function (a, b) {
                        return parseInt(b.Modified.substring(6)) - parseInt(a.Modified.substring(6));
                    });

                var sortButton = '<span class="model-sort-button" title="' +
                    (sortModelsAlpha ? 'Models are displayed alphabetically. Click this link to display most recently changed data models at the top.' : 'Most recently changed models are displayed at the top. Click this link to display data models in alphabetical order.') + '" onclick="setTimeout(function(){CodeOnTime.Client._sortModels()},10)">' +
                    (sortModelsAlpha ? 'sorted' : 'last changed') + '</span>';
                if (modelCount < 5)
                    sortButton = '';

                $('<div class="dataModelHeader">Data Models' + sortButton + '</div>').appendTo(dataModelList);
                var max = 7;
                if (models.length > 7)
                    $('<div class="dataModelHeader">Frequent</div>').appendTo(dataModelList);
                else
                    max = sortedModels.length;

                for (var i = 0; i < max; i++) {
                    var m = sortedModels[i];
                    renderModel(m);
                    m.rendered = true;
                }

                // render remaining alphabetically
                var first = true;
                for (model in models)
                    if (!models[model].rendered) {
                        if (first) {
                            first = false;
                            $('<div class="dataModelHeader">Other</div>').appendTo(dataModelList);
                        }
                        renderModel(model);
                    }

                // render suggestions
                if (suggested.length > 0) {
                    var first = true;
                    suggested.sort();
                    for (i = 0; i < suggested.length; i++) {
                        var table = suggested[i],
                            tableName = firebird ? trimName(table) : table,
                            index = -1;

                        for (; index < controllers.length; ++index)
                            if (controllers[index] == tableName)
                                break;

                        if (index == -1 || index == controllers.length || tableDefined(table))
                            continue;

                        if (first) {
                            hasSuggested = true;
                            first = false;
                            $('<div class="dataModelHeader">Suggested Database Entities</div>').appendTo(businessEntityList);
                        }

                        undefinedControllers.push(tableName);

                        renderObject(table, businessEntityList);

                        controllers.splice(index, 1);
                    }
                }
                if (dataModelList.is(':visible')) {
                    var saveDataModeListHeight = dataModelList.css('height');
                    dataModelList.height('');
                    dataModelList.focus();
                    dataModelList.height(saveDataModeListHeight);
                    $(window).trigger('resize');
                }
            }
            else {
                $('#model-desc-models').hide();
                $('#model-desc-nomodels').show();
                $(window).trigger('resize');
            }

            // render non-models
            if (controllers.length > 0) {
                var definedControllers = [], firstC = true;
                for (i = 0; i < controllers.length; i++) {
                    var table = controllers[i];
                    if (!tableDefined(table)) {

                        if (firstC) {
                            firstC = false;
                            var label = hasSuggested ? 'Other Entities Without a Model' : 'Database Entities Without a Model';
                            $('<div class="dataModelHeader">' + label + '</div>').appendTo(businessEntityList);
                        }

                        renderObject(table);

                        undefinedControllers.push(table);
                    }
                    else
                        definedControllers.push(table);
                }

                if (!firstC) {
                    // render "Define All Entities"
                    var label = hasModels ? 'add all' : 'add models for all entities',
                        addAll = $('<div class="dataModelHeader2 defineAllHeader"></div><div class="dataModel defineAllEntities" onclick="CodeOnTime.Client.createDataModelBuilderAll(\'' + undefinedControllers.join(',').replace(/\'/g, '\\\'') + '\');return false;">'
                            + ' <div class="dataModelName">' + label + '</div>'
                            + '</div>');

                    if (hasModels)
                        addAll.appendTo(businessEntityList);
                    else
                        addAll.prependTo(businessEntityList);
                }

                // render defined tables
                if (definedControllers.length > 0) {
                    $('<div class="dataModelHeader">Entities with a Model</div>').appendTo(businessEntityList);

                    for (i = 0; i < definedControllers.length; i++)
                        renderObject(definedControllers[i]);
                }

                // activate last search
                this._lastSearch = '';
                var searchElement = $('#DataModel_SearchBox');
                if (searchElement.length && searchElement.val() != '')
                    this._searchEntities(searchElement);
                var saveBusinessEntityListHeight = businessEntityList.height();
                businessEntityList.height('');
                if (!hasModels && businessEntityList.is(':visible'))
                    businessEntityList.focus();
                businessEntityList.height(saveBusinessEntityListHeight);
            }
        }
    },
    _businessEntityList: '',
    _dataModelList: '',
    _lastSearch: '',
    _searchTimeout: null,
    _searchEntities: function (searchElement) {
        if (this._searchTimeout != null)
            clearTimeout(this._searchTimeout);
        var that = this;
        this._searchTimeout = setTimeout(function () {
            var searchInput = $(searchElement),
                query = searchInput.val().toLowerCase();
            if (query == that._lastSearch)
                return;
            that._lastSearch = query;


            // debug
            var entities = $('#businessEntityList .dataModel, #dataModelList .dataModel');
            entities.show();

            if (query == 'search...' || query == '')
                return;

            var queryOr = [],
                querySplit = query.split(',');
            for (var strPos in querySplit) {
                var str = querySplit[strPos].trim();
                if (str != '')
                    queryOr.push(str.split(' '));
            }
            entities.each(function () {
                var entity = $(this),
                    header = entity.find('.dataModelName'),
                    tables = entity.find('.dataModelTables'),
                    text = entity.text().toLowerCase(),
                    found = false;

                for (var queryAndPos in queryOr) {
                    var queryAnd = queryOr[queryAndPos],
                        matchAnd = true;
                    for (var sPos in queryAnd) {
                        var s = queryAnd[sPos];
                        if (text.indexOf(s) == -1) {
                            matchAnd = false;
                            break;
                        }
                    }
                    if (matchAnd) {
                        found = true;
                        break;
                    }

                }
                if (!found)
                    entity.hide();
            });
            //return;
            //// end debug


            //// restore list
            //var beList = $('#businessEntityList'),
            //    dmList = $('#dataModelList');

            //beList[0].innerHTML = that._businessEntityList;
            //dmList[0].innerHTML = that._dataModelList;

            //if (query == 'search...' || query == '')
            //    return;

            //// get lists
            //var entityList = [];
            //$('#businessEntityList .dataModel').each(function () {
            //    var entity = $(this).detach(),
            //        fullName = entity.text(),
            //        table = fullName.split('.');
            //    entityList.push({ schema: table[0], table: table[1], fullName: fullName, container: entity });
            //});
            //$('#dataModelList .dataModel').each(function () {
            //    var dm = $(this).detach(),
            //        //nane = dm.find('.dataModelName').text(),
            //        references = dm.find('.dataModelTables').text();
            //    entityList.push({ name: name, container: entity, references: references });
            //});

            //for (i = 0; i < entityList; i++) {
            //    var entity = entityList[i];
            //    if (entity.table.indexOf(query) != -1) {
            //        entity.found = true;
            //        entity.appendTo(beList);
            //    }
            //}

        }, 750);
    },
    createDataModelBuilder: function (table) {
        var discoveryDepth = $get('BusinessLogicLayerDialog_DiscoveryDepth').value;
        window.external.NormalizeModelNames = $get('DataModel_NormalizeModelNames').checked;
        if (window.external.CreateDataModelBuilder(table, this.get_databaseConnectionProvider(), this.get_databaseConnectionString(), discoveryDepth))
            this.executePendingModelAction();
    },
    executePendingModelAction: function () {
        var that = this;
        if (window.external.HasPendingModelAction)
            setTimeout(function () {
                window.external.OpenOrCreateModel(that.get_databaseConnectionProvider(), that.get_databaseConnectionString(), $get('BusinessLogicLayerDialog_DiscoveryDepth').value);
                that.executePendingModelAction();
            });
        else
            this.resetDataModels();
    },
    createDataModelBuilderAll: function (tables) {
        if (confirm('Create data models for all undefined database entities?')) {
            var discoveryDepth = $get('BusinessLogicLayerDialog_DiscoveryDepth').value;
            window.external.NormalizeModelNames = $get('DataModel_NormalizeModelNames').checked;
            if (window.external.CreateDataModelBuilderAll(tables, this.get_databaseConnectionProvider(), this.get_databaseConnectionString(), discoveryDepth))
                this.resetDataModels();
        }
    },
    openDataModelBuilder: function (file) {
        window.external.NormalizeModelNames = $get('DataModel_NormalizeModelNames').checked;
        if (window.external.OpenDataModelBuilder(file, this.get_databaseConnectionProvider(), this.get_databaseConnectionString()))
            this.executePendingModelAction();
    },
    resetDataModels: function () {
        this._dataModels = null;
        this._controllerList = null;
        this._initializeDataModels();
        this.modelRefreshRequired = true;
        $('#dataModelList')[0].scrollTop = 0;
        $('#businessEntityList')[0].scrollTop = 0;
    },
    resetDatabaseModel: function () {
        window.external.ResetDatabaseModel();
    },
    modelRefreshRequired: false,
    ensureRefreshModels: function () {
        this.modelRefreshRequired = true;
    },
    replaceExpressions: function (url) {
        return window.external.ReplaceExpressions(url);
    },
    showWebServerDialog: function (autoFocus) {
        this.hideDialog();
        this.showDialog('WebServerDialog');
        if (autoFocus) {
            var elem = $get('WebServerDialog_WebServceParameters');
            if (Sys.UI.DomElement.getVisible(elem))
                $get('WebServerDialog_WebServerPort').focus();
            else
                $get('WebServerDialog_WebConfig').focus();
        }
        this.refreshWebServerDialog();
    },
    initializeWebServerDialog: function (options, callbacks) {
        this._webServerCallbacks = callbacks ? callbacks : [];
        this.appendResource('_System\\Resources.WebServer.htm');
        $get('WebServerDialog_WebServerRun').checked = options.run == 'true';
        if (options.port == 8888)
            options.port = window.external.RandomPortNumber(parseInt(options.port));
        //options.port = parseInt(options.port);
        //while (options.port == 8888 || options.port <= 80 || options.port == 447 || options.port > 64000 || options.port <= 1100)
        //    options.port = Math.floor(Math.random() * 100000);
        $get('WebServerDialog_WebServerPort').value = options.port;
        $get('WebServerDialog_WebConfig').value = options.webConfig;
        $get('WebServerDialog_Preview').value = options.preview == 'None' ? 'Browser' : options.preview;
        var winVer = this.getWindowsVersion();
        if (!winVer || winVer.Major < 10) {
            options.client = 'W7';
            $('#WebServerDialog_Client').addClass('hidden');
        }
        else if (winVer && winVer.Major == 10 && !options.client)
            options.client = 'W10';
        $('#WebServerDialog_Client_' + (options.client || 'W7')).attr('checked', 'checked');
        this.refreshWebServerDialog();
    },
    refreshWebServerDialog: function () {
        var run = this.get_webServerRun(),
            preview = this.get_preview(),
            client = this.get_client(),
            clientIsApp = preview != 'None' && preview != 'Browser',
            implementation = $get('PageImplementation').value,
            ui = this.get_touchEnabled();

        if (implementation == 'aspx' || !ui) {
            $('.WebServerDialog_Preview_App').attr('disabled', 'disabled');
            $('#WebServerDialog_AppRequiresTouchUIHTML').show();
            if (clientIsApp) {
                $get('WebServerDialog_Preview').value = preview = 'Browser';
                client = '';
                clientIsApp = false;
            }
        }
        else {
            $('.WebServerDialog_Preview_App').removeAttr('disabled');
            $('#WebServerDialog_AppRequiresTouchUIHTML').hide();
        }

        if (run == 'true')
            $('#WebServerDialog_Preview').removeAttr('disabled');
        else
            $('#WebServerDialog_Preview').attr('disabled', 'true');

        $('#WebServerDialog_Client').toggle(clientIsApp);
        $('#WebServerDialog_Preview_Desc').toggle(preview != 'None');
        $('#WebServerDialog_Preview_Desc span').addClass('hidden');
        $('#WebServerDialog_PreviewDesc_' + preview + client).removeClass('hidden');
    },
    _executeWebServerDialogCallback: function (name) {
        this._executeDialogCallback(this._webServerCallbacks, name);
    },
    get_webServerRun: function () {
        return $get('WebServerDialog_WebServerRun').checked ? 'true' : 'false';
    },
    get_webServerPort: function () {
        return $get('WebServerDialog_WebServerPort').value;
    },
    get_preview: function () {
        return this.get_webServerRun() == 'true' ? $get('WebServerDialog_Preview').value : 'None';
    },
    get_client: function () {
        var c = this.get_preview();
        if (c == 'None' || c == 'Browser')
            return '';
        return $('input[name="WebServerDialog_Client"]:checked').val();
    },
    get_webServerWebConfig: function () {
        return $get('WebServerDialog_WebConfig').value;
    },
    validateWebServerPort: function () {
        var port = this.get_webServerPort();
        if (!(port.match(/^\d+$/) && parseInt(port) >= 80)) {
            Continue('WebServer');
            alert('Invalid web server port.');
            return false;
        }
        return true;
    },
    showBusinessLogicLayerDialog: function (autoFocus) {
        this.hideDialog();
        this.showDialog('BusinessLogicLayerDialog');
        if (autoFocus) {
            this.focusTabView('BusinessLogicLayerDialog');
            var dataModelList = $('#dataModelList');
            var businessEntityList = $('#businessEntityList');
            if (dataModelList.is(':visible'))
                dataModelList.focus();
            else if (businessEntityList.is(':visible'))
                businessEntityList.focus();
        }
        //if (autoFocus && !Sys.UI.DomElement.getVisible($get('BusinessLogicLayerDialog_Generate').disabled))
        //    $get(Sys.UI.DomElement.getVisible($get('BusinessLogicLayerDialog_GenerateField')) ? 'BusinessLogicLayerDialog_Generate' : 'BusinessLogicLayerDialog_InsertMethod').focus();
        //$get('BusinessLogicLayerDialog_GenerateLabel').disabled = $get('BusinessLogicLayerDialog_Generate').disabled;
        //        this.checkBusinessLogicLayerMethodsVisibility();
    },
    initializeBusinessLogicLayerDialog: function (normalizeModelNames, discoveryDepth, fieldMap, keys, labelFormatExpression, fieldsToIgnore, fieldsToHide, customLabels, forceGenerate, selectMethod, selectSingleMethod, insertMethod, updateMethod, deleteMethod, generatedSharedBusinessRules, includeViews, tabViewSelection, callbacks) {
        this._bllCallbacks = callbacks ? callbacks : [];
        this.appendResource('_System\\Resources.BLL.htm');
        this._initializeTabView('BusinessLogicLayerDialog_TabView', tabViewSelection);
        $get('DataModel_NormalizeModelNames').checked = (normalizeModelNames != 'false');
        $get('BusinessLogicLayerDialog_DiscoveryDepth').value = discoveryDepth;
        $get('BusinessLogicLayerDialog_FieldMap').value = fieldMap;
        $get('BusinessLogicLayerDialog_Keys').value = keys;
        $get('BusinessLogicLayerDialog_LabelFormatExpression').value = labelFormatExpression;
        $get('BusinessLogicLayerDialog_FieldsToIgnore').value = fieldsToIgnore;
        $get('BusinessLogicLayerDialog_FieldsToHide').value = fieldsToHide;
        $get('BusinessLogicLayerDialog_CustomLabels').value = customLabels;
        var advancedOptionsAreVisible = discoveryDepth.toString() != '3' || fieldMap.length != 0 || keys.length != 0 || labelFormatExpression.length != 0 || fieldsToIgnore.length != 0 || fieldsToHide.length != 0 || customLabels.length != 0;
        //Sys.UI.DomElement.setVisible($get('BusinessLogicLayerDialog_AdvancedOptionsContainer'), advancedOptionsAreVisible);
        $get('BusinessLogicLayerDialog_AdvancedOptions').checked = advancedOptionsAreVisible;
        $get('BusinessLogicLayerDialog_AdvancedOptions').disabled = forceGenerate == null;
        $get('BusinessLogicLayerDialog_AdvancedOptionsLabel').disabled = forceGenerate == null;
        //        Sys.UI.DomElement.setVisible($get('BusinessLogicLayerDialog_GenerateField'), !forceGenerate);
        //$get('BusinessLogicLayerDialog_Generate').checked = forceGenerate || generateFlag == 'true';
        //        $get('BusinessLogicLayerDialog_GenerateField').disabled = forceGenerate == null;
        $get('BusinessLogicLayerDialog_SelectMethod').value = selectMethod;
        $get('BusinessLogicLayerDialog_SelectSingleMethod').value = selectSingleMethod;
        $get('BusinessLogicLayerDialog_InsertMethod').value = insertMethod;
        $get('BusinessLogicLayerDialog_UpdateMethod').value = updateMethod;
        $get('BusinessLogicLayerDialog_DeleteMethod').value = deleteMethod;
        var sharedBusinessRules = $get('BusinessLogicLayerDialog_SharedBusinessRules');
        sharedBusinessRules.checked = generatedSharedBusinessRules == 'true';
        sharedBusinessRules.disabled = forceGenerate == null;
        $get('BusinessLogicLayerDialog_SharedBusinessRulesLabel').disabled = forceGenerate == null;
        $get('BusinessLogicLayerDialog_IncludeViews').checked = includeViews == 'true';
        $get('BusinessLogicLayerDialog_IncludeViews').disabled = forceGenerate == null;
        $get('BusinessLogicLayerDialog_IncludeViewsLabel').disabled = forceGenerate == null;
        this._initializeDataModels();
    },
    get_businessLogicLayerSettings: function () {
        var nameExp = /^\s*(.+)\s*$/;
        var settings = {
            'normalizeModelNames': $get('DataModel_NormalizeModelNames').checked ? 'true' : 'false',
            'discoveryDepth': $get('BusinessLogicLayerDialog_DiscoveryDepth').value,
            'labelFormatExpression': $get('BusinessLogicLayerDialog_LabelFormatExpression').value,
            'fieldsToIgnore': $get('BusinessLogicLayerDialog_FieldsToIgnore').value.trim(),
            'fieldsToHide': $get('BusinessLogicLayerDialog_FieldsToHide').value,
            'customLabels': $get('BusinessLogicLayerDialog_CustomLabels').value,
            'fieldMap': $get('BusinessLogicLayerDialog_FieldMap').value,
            'keys': $get('BusinessLogicLayerDialog_Keys').value,
            //'generate': $get('BusinessLogicLayerDialog_Generate').checked ? 'true' : 'false',
            'selectMethod': $get('BusinessLogicLayerDialog_SelectMethod').value.match(nameExp)[1],
            'selectSingleMethod': $get('BusinessLogicLayerDialog_SelectSingleMethod').value.match(nameExp)[1],
            'insertMethod': $get('BusinessLogicLayerDialog_InsertMethod').value.match(nameExp)[1],
            'updateMethod': $get('BusinessLogicLayerDialog_UpdateMethod').value.match(nameExp)[1],
            'deleteMethod': $get('BusinessLogicLayerDialog_DeleteMethod').value.match(nameExp)[1],
            'generateSharedBusinessRules': $get('BusinessLogicLayerDialog_SharedBusinessRules').checked ? 'true' : 'false',
            'includeViews': $get('BusinessLogicLayerDialog_IncludeViews').checked ? 'true' : 'false'
        };
        var discoveryDepth = settings.discoveryDepth.match(/^\s*(\d*)\s*$/);
        if (!discoveryDepth) {
            settings.discoveryDepth = 3;
            settings._error = { 'id': 'BusinessLogicLayerDialog_DiscoveryDepth', 'text': 'Leave this field blank or enter a valid number.' };
        }
        else
            settings.discoveryDepth = discoveryDepth[1];
        Sys.UI.DomElement.setVisible($get('BusinessLogicLayerDialog_DiscoveryDepthError'), false);
        try {
            new RegExp(settings.labelFormatExpression.replace(/\?\'\w+\'/g, ''));
        }
        catch (ex) {
            settings.labelFormatExpression = '';
            settings._error = { 'id': 'BusinessLogicLayerDialog_LabelFormatExpression', 'text': ex.message };
        }
        Sys.UI.DomElement.setVisible($get('BusinessLogicLayerDialog_LabelFormatExpressionError'), false);
        var test = /^\w+$/;
        if (!settings.selectMethod.match(test)) settings.selectMethod = 'Select';
        if (!settings.selectSingleMethod.match(test)) settings.selectSingleMethod = 'SelectSingle';
        if (settings.selectMethod == settings.selectSingleMethod) {
            settings.selectMethod = 'Select';
            settings.selectSingleMethod = 'SelectSingle';
        }
        if (!settings.insertMethod.match(test)) settings.insertMethod = 'Insert';
        if (!settings.updateMethod.match(test)) settings.updateMethod = 'Update';
        if (!settings.deleteMethod.match(test)) settings.deleteMethod = 'Delete';
        return settings;
    },
    checkBusinessLogicLayerMethodsVisibility: function (visible) {
        //if (visible == null) visible = $get('BusinessLogicLayerDialog_Generate').checked;
        //Sys.UI.DomElement.setVisible($get('BusinessLogicLayerDialog_MethodsDiv'), visible)
    },
    _executeBusinessLogicLayerDialogCallback: function (name) {
        this._executeDialogCallback(this._bllCallbacks, name);
    },
    showGlobalizationDialog: function (autoFocus) {
        this.hideDialog();
        this.showDialog('GlobalizationDialog');
    },
    initializeGlobalizationDialog: function (uiCulture, culture, enableClientBasedCulture, supportedCultures, googleTranslateApiKey, callbacks) {
        this._globalizationCallbacks = callbacks ? callbacks : [];
        this.appendResource('_System\\Resources.Globalization.htm');
        var uiCultureList = window.external.GetNeutralCultures().split('|');
        var uiCultureElem = $get('GlobalizationDialog_UICulture');
        for (var i = 0; i < uiCultureList.length; i++) {
            var c = uiCultureList[i];
            var option = document.createElement('option');
            uiCultureElem.appendChild(option);
            option.value = c.split(',')[0];
            option.innerHTML = c;
        }
        uiCultureElem.value = uiCulture == '' ? window.external.GetCurrentNeutralCulture() : uiCulture;
        var cultureElem = $get('GlobalizationDialog_Culture');
        var cultureList = window.external.GetSpecificCultures().split('|');
        for (i = 0; i < cultureList.length; i++) {
            c = cultureList[i];
            option = document.createElement('option');
            cultureElem.appendChild(option);
            option.value = c.split(',')[0];
            option.innerHTML = c;
        }
        cultureElem.value = culture == '' ? window.external.GetCurrentSpecificCulture() : culture;
        $get('GlobalizationDialog_EnableClientBasedCulture').checked = enableClientBasedCulture == 'true';
        $get('GlobalizationDialog_SupportedCultures').value = supportedCultures;
        $get('GlobalizationDialog_GoogleTranslateApiKey').value = googleTranslateApiKey;
    },
    _executeGlobalizationDialogCallback: function (name) {
        this._executeDialogCallback(this._globalizationCallbacks, name);
    },
    get_globalizatinSettings: function () {
        var settings = {
            'uiCulture': $get('GlobalizationDialog_UICulture').value,
            'culture': $get('GlobalizationDialog_Culture').value,
            'enableClientBasedCulture': $get('GlobalizationDialog_EnableClientBasedCulture').checked ? 'true' : 'false',
            'supportedCultures': $get('GlobalizationDialog_SupportedCultures').value.trim(),
            'googleTranslateApiKey': $get('GlobalizationDialog_GoogleTranslateApiKey').value.trim()
        };
        if (settings.uiCulture == '')
            settings.uiCulture = window.external.GetCurrentNeutralCulture();
        if (settings.culture == '')
            settings.culture = window.external.GetCurrentSpecificCulture();

        var list = settings.supportedCultures.split(/;|\n/);
        var supportedCultures = '';

        var defaultCultureIsListed = false;
        for (var i = 0; i < list.length; i++) {
            var m = list[i].match(/^\s*([\w\-]+)\s*(,\s*([\w\-]+))?\s*/);
            if (m) {
                var culture = m[1];
                var uiCulture = m[3];
                if (uiCulture.length == 0)
                    uiCulture = culture;
                if (culture == settings.culture && uiCulture == settings.uiCulture)
                    defaultCultureIsListed = true;
                supportedCultures = String.format('{0}{1},{2}; ', supportedCultures, culture, uiCulture);
            }
        }
        if (!defaultCultureIsListed /*&& supportedCultures.length > 0*/)
            supportedCultures = String.format('{0},{1}; {2}', settings.culture, settings.uiCulture, supportedCultures);
        settings.supportedCultures = supportedCultures;
        return settings;
    },
    generateValidationKey: function () {
        return window.external.GenerateValidationKey();
    },
    toggleMembershipOptions: function (sender, validate) {
        var membership = $get('MembershipDialog_Enabled');
        var customSecurity = $get('MembershipDialog_CustomSecurity');
        var customSecurityConfig = $get('MembershipDialog_CustomSecurityConfig');
        var windowsAuthentication = $get('MembershipDialog_WindowsAuthentication');
        var activeDirectory = $get('MembershipDialog_ActiveDirectory');
        var activeDirectoryConfig = $get('MembershipDialog_ActiveDirectoryConfig');
        Sys.UI.DomElement.setVisible(customSecurityConfig, false);
        Sys.UI.DomElement.setVisible(activeDirectoryConfig, false);
        if (sender.checked) {
            switch (sender.id) {
                case 'MembershipDialog_Enabled':
                    windowsAuthentication.checked = false;
                    customSecurity.checked = false;
                    activeDirectory.checked = false;
                    MembershipDialog_DisplayMyAccount.checked = true;
                    break;
                case 'MembershipDialog_WindowsAuthentication':
                    membership.checked = false;
                    customSecurity.checked = false;
                    activeDirectory.checked = false;
                    MembershipDialog_DedicatedLogin.checked = false;
                    MembershipDialog_DisplayMyAccount.checked = false;
                    break;
                case 'MembershipDialog_ActiveDirectory':
                    membership.checked = false;
                    customSecurity.checked = false;
                    windowsAuthentication.checked = false;
                    MembershipDialog_DisplayPasswordRecovery.checked = false;
                    MembershipDialog_DisplaySignUp.checked = false;
                    MembershipDialog_DisplayMyAccount.checked = false;
                    MembershipDialog_DisplayMyAccount_Container.disabled = true;
                    MembershipDialog_StandaloneDatabase.checked = false;
                    Sys.UI.DomElement.setVisible(activeDirectoryConfig, true);
                    if (activeDirectoryConfig.value.length == 0)
                        activeDirectoryConfig.setAttribute('value', 'Connection String = LDAP://server-address \nConnection User Name = domain\\username\nConnection Password = password\nEnable Search Methods = true\nAttribute Map Username = SAMAccountName');
                    Sys.UI.DomElement.setVisible($get('MembershipDialog_ConnectionStringSettings'), false);
                    break;
                case 'MembershipDialog_CustomSecurity':
                    membership.checked = false;
                    windowsAuthentication.checked = false;
                    activeDirectory.checked = false;
                    MembershipDialog_DisplayPasswordRecovery.checked = false;
                    MembershipDialog_DisplaySignUp.checked = false;
                    //MembershipDialog_DisplayMyAccount.checked = false;
                    //MembershipDialog_DisplayMyAccount_Container.disabled = true;
                    MembershipDialog_StandaloneDatabase.checked = false;
                    //MembershipDialog_DedicatedLogin.checked = false;
                    Sys.UI.DomElement.setVisible(customSecurityConfig, true);
                    Sys.UI.DomElement.setVisible($get('MembershipDialog_ConnectionStringSettings'), false);
                    if (!customSecurityConfig.value.trim().length)
                        customSecurityConfig.value =
                            'table Users = Users\n' +
                            'column [int|uiid] UserID = UserID\n' +
                            'column [text] UserName = UserName\n' +
                            'column [text] Password = Password\n' +
                            'column [text] Email = Email\n' +
                            '\n' +
                            'table Roles = Roles\n' +
                            'column [int|uiid] RoleID = RoleID\n' +
                            'column [text] RoleName = RoleName\n' +
                            '\n' +
                            'table UserRoles = UserRoles\n' +
                            'column [int|uiid] UserID = UserID\n' +
                            'column [int|uiid] RoleID = RoleID\n';
                    break;
            }
        }

        $get('MembershipDialog_DedicatedLogin_Container').disabled = !(membership.checked || customSecurity.checked || activeDirectory.checked) || !this.get_isStandard();
        $get('MembershipDialog_DisplayRememberMe_Container').disabled = !(membership.checked || customSecurity.checked || activeDirectory.checked) || !this.get_isStandard();
        $get('MembershipDialog_RememberMeSet_Container').disabled = !(membership.checked || customSecurity.checked || activeDirectory.checked) || !this.get_isStandard();
        $get('MembershipDialog_DisplayPasswordRecovery_Container').disabled = !membership.checked || !this.get_isStandard();
        $get('MembershipDialog_DisplaySignUp_Container').disabled = !membership.checked || !this.get_isStandard();
        $get('MembershipDialog_DisplayMyAccount_Container').disabled = !(membership.checked || windowsAuthentication.checked || customSecurity.checked) || !this.get_isStandard();
        $get('MembershipDialog_DisplayHelp_Container').disabled = !(membership.checked || customSecurity.checked || activeDirectory.checked || windowsAuthentication.checked) || !this.get_isStandard();
        $get('MembershipDialog_StandaloneDatabase_Container').disabled = !membership.checked;
        $get('MembershipDialog_ConnectionStringSettings').disabled = !membership.checked;
        $get('MembershipDialog_IdleUserDetection_Container').disabled = !(membership.checked || customSecurity.checked || windowsAuthentication.checked) || !CodeOnTime.Client.get_isPremium();

        if (membership.checked && validate && $get('DatabaseConnectionDialog_ProviderName').value == 'System.Data.SqlClient' && $get('MembershipDialog_ConnectionString').value == '') {
            var sqlExpressStatus = CodeOnTime.Client.get_sqlExpressStatus();
            if (sqlExpressStatus != 'Running') {
                alert('Microsoft SQL Express is not installed on your computer. Please review\nStandalone ASP.NET Membership Database configuration instructions.\n\nPress OK to view instructions.');
                $openUrl('http://codeontime.com/learn/sample-applications/order-form/installing-asp-net-membership');
            }
        }
    },
    showMembershipDialog: function (autoFocus) {
        this.hideDialog();
        this.showDialog('MembershipDialog');
        if (autoFocus)
            this.focusTabView('MembershipDialog');
        var useStandaloneDatabase =
            this.decryptConnectionString($get('MembershipDialog_ConnectionString')).match(/^\s*$/) == null &&
            this.decryptConnectionString($get('DatabaseConnectionDialog_ConnectionString')) != this.decryptConnectionString($get('MembershipDialog_ConnectionString')) &&
            !MembershipDialog_CustomSecurity.checked;
        $get('MembershipDialog_StandaloneDatabase').checked = useStandaloneDatabase;
        Sys.UI.DomElement.setVisible($get('MembershipDialog_ConnectionStringSettings'), useStandaloneDatabase);
    },
    initializeMembershipDialog: function (enabled, providerName, connectionString, windowsAuthentication, activeDirectory, activeDirectoryConfig, customSecurity, membershipConfig, dedicatedLogin, displayRememberMe, rememberMeSet, displayPasswordRecovery, displaySignUp, displayMyAccount, displayHelp, idleUserDetectionTimeout, tabViewSelection, callbacks) {
        this._membershipCallbacks = callbacks ? callbacks : [];
        this.appendResource('_System\\Resources.Membership.htm');
        this._initializeTabView('MembershipDialog_TabView', tabViewSelection);
        $get('MembershipDialog_Enabled').checked = enabled == 'true';
        var providerNameElem = $get('MembershipDialog_ProviderName');
        for (var i = 0; i < providerNameElem.options.length; i++) {
            if (providerNameElem.options[i].value == providerName) {
                providerNameElem.selectedIndex = i;
                break;
            }
        }
        if (this.get_isAzureFactory()) {
            //providerNameElem.disabled = true;
            Sys.UI.DomElement.setVisible($get('MembershipDialog_ProviderName_Container'), false);
        }
        if (connectionString != '') {
            $get('MembershipDialog_StandaloneDatabase_Container').disabled = false;
            $get('MembershipDialog_StandaloneDatabase').checked = true;
            var connectionStringElem = $get('MembershipDialog_ConnectionString');
            connectionStringElem.value = connectionString;
            this.encryptConnectionString(connectionStringElem);
        }
        if (enabled == 'true') {
            this.toggleMembershipOptions($get('MembershipDialog_Enabled'));
        }
        else if (windowsAuthentication == 'true') {
            $get('MembershipDialog_WindowsAuthentication').checked = true;
            this.toggleMembershipOptions($get('MembershipDialog_WindowsAuthentication'));
        }
        else if (activeDirectory == 'true') {
            $get('MembershipDialog_ActiveDirectory').checked = true;
            $get('MembershipDialog_ActiveDirectoryConfig').value = activeDirectoryConfig;
            this.toggleMembershipOptions($get('MembershipDialog_ActiveDirectory'));
        }
        else if (customSecurity == 'true') {
            $get('MembershipDialog_CustomSecurity').checked = customSecurity == 'true';
            $get('MembershipDialog_CustomSecurityConfig').value = membershipConfig;
            this.toggleMembershipOptions($get('MembershipDialog_CustomSecurity'));
        }
        else {
            this.toggleMembershipOptions($get('MembershipDialog_Enabled'));
        }
        $get('MembershipDialog_DedicatedLogin').checked = dedicatedLogin == 'true';
        $get('MembershipDialog_DisplayRememberMe').checked = displayRememberMe == 'true';
        $get('MembershipDialog_RememberMeSet').checked = rememberMeSet == 'true';
        $get('MembershipDialog_DisplayPasswordRecovery').checked = displayPasswordRecovery == 'true';
        $get('MembershipDialog_DisplaySignUp').checked = displaySignUp == 'true';
        $get('MembershipDialog_DisplayMyAccount').checked = displayMyAccount == 'true';
        $get('MembershipDialog_DisplayHelp').checked = displayHelp == 'true';
        idleUserDetectionTimeout = parseInt(idleUserDetectionTimeout)
        if (idleUserDetectionTimeout.toString() == 'NaN') idleUserDetectionTimeout = -1;
        $get('MembershipDialog_IdleUserDetectionTimeout').value = idleUserDetectionTimeout > 0 && this.get_isPremium() ? idleUserDetectionTimeout : 15;
        $get('MembershipDialog_IdleUserDetection').checked = idleUserDetectionTimeout > 0;
        $get('MembershipDialog_IdleUserDetection_Container').disabled = !this.get_isPremium();
        $get('MembershipDialog_IdleUserDetectionTimeout').readOnly = $get('MembershipDialog_IdleUserDetection_Container').disabled;

        //        this.toggleMembershipOptions($get('MembershipDialog_Enabled'));
        //        this.toggleMembershipOptions($get('MembershipDialog_WindowsAuthentication'));
        //        this.toggleMembershipOptions($get('MembershipDialog_ActiveDirectory'));
        //        this.toggleMembershipOptions($get('MembershipDialog_CustomSecurity'));
    },
    _executeMembershipDialogCallback: function (name) {
        this._executeDialogCallback(this._membershipCallbacks, name);
    },
    get_membershipEnabled: function () {
        return $get('MembershipDialog_Enabled').checked ? 'true' : 'false';
    },
    get_membershipProviderName: function () {
        return $get('MembershipDialog_ProviderName').value;
    },
    get_membershipConnectionString: function () {
        if (!$get('MembershipDialog_StandaloneDatabase').checked)
            return '';
        return this.decryptConnectionString($get('MembershipDialog_ConnectionString'));
    },
    get_membershipWindowsAuthentication: function () {
        return $get('MembershipDialog_WindowsAuthentication').checked ? 'true' : 'false';
    },
    get_membershipActiveDirectory: function () {
        return $get('MembershipDialog_ActiveDirectory').checked ? 'true' : 'false';
    },
    get_membershipActiveDirectoryConfig: function () {
        return $get('MembershipDialog_ActiveDirectoryConfig').value;
    },
    get_membershipCustomSecurity: function () {
        return $get('MembershipDialog_CustomSecurity').checked ? 'true' : 'false';
    },
    get_membershipConfig: function () {
        return $get('MembershipDialog_CustomSecurityConfig').value;
    },
    get_membershipDedicatedLogin: function () {
        return $get('MembershipDialog_DedicatedLogin').checked ? 'true' : 'false';
    },
    get_membershipDisplayRememberMe: function () {
        return $get('MembershipDialog_DisplayRememberMe').checked ? 'true' : 'false';
    },
    get_membershipRememberMeSet: function () {
        return $get('MembershipDialog_RememberMeSet').checked ? 'true' : 'false';
    },
    get_membershipDisplayPasswordRecovery: function () {
        return $get('MembershipDialog_DisplayPasswordRecovery').checked ? 'true' : 'false';
    },
    get_membershipDisplaySignUp: function () {
        return $get('MembershipDialog_DisplaySignUp').checked ? 'true' : 'false';
    },
    get_membershipDisplayMyAccount: function () {
        return $get('MembershipDialog_DisplayMyAccount').checked ? 'true' : 'false';
    },
    get_membershipDisplayHelp: function () {
        return $get('MembershipDialog_DisplayHelp').checked ? 'true' : 'false';
    },
    get_membershipIdleUserDetectionTimeout: function () {
        var timeout = $get('MembershipDialog_IdleUserDetection').checked ? parseInt(MembershipDialog_IdleUserDetectionTimeout.value) : -1;
        if (timeout.toString() == 'NaN') timeout = -1;
        return timeout;
    },
    showReportsDialog: function (autoFocus) {
        this.hideDialog();
        this.showDialog('ReportsDialog');
        if (autoFocus)
            $get('ReportsDialog_Enabled').focus();
    },
    initializeReportsDialog: function (enabled, callbacks) {
        this._reportsCallbacks = callbacks ? callbacks : [];
        this.appendResource('_System\\Resources.Reports.htm');
        $get('ReportsDialog_Enabled').checked = enabled == 'true';
    },
    _executeReportsDialogCallback: function (name) {
        this._executeDialogCallback(this._reportsCallbacks, name);
    },
    get_reportsEnabled: function () {
        return $get('ReportsDialog_Enabled').checked ? 'true' : 'false';
    },
    get_touchEnabled: function () {
        var ui = $get('UserInterface').value;
        return ui == 'TouchUI' || ui == 'Both';
    },
    showThemeDialog: function (autoFocus) {
        this.hideDialog();
        this.showDialog('ThemeDialog');
        var themeList = $get('ThemeDialog_Theme');
        if (!IsDotNetNukeFactory() && !IsSharePointFactory() && !CodeOnTime.Client.get_isStandard()) {
            themeList.value = 'Aquarium';
        }
        if (autoFocus) $get('ThemeDialog_Theme').focus();
    },
    initializeThemeDialog: function (theme, callbacks) {
        this._themeCallbacks = callbacks ? callbacks : [];
        this.appendResource('_System\\Resources.Theme.htm');
        var standardThemes = ['Aquarium', 'Citrus', 'Granite', 'Lacquer', 'Simple'];
        var themeList = $get('ThemeDialog_Theme');
        if (!window.external.DesignerHomeUrl) {
            for (var i = 0; i < themeList.options.length; i++) {
                var o = themeList.options[i];
                if (Array.indexOf(standardThemes, o.value) == -1) {
                    o.disabled = true;
                }
            }
        }
        themeList.value = theme;
        if (this.get_variable('ProjectId').match(/Mobile Factory/)) {
            theme += ' Mobile';
            Sys.UI.DomElement.setVisible($get('ThemePreview_Desktop'), false);
        }
        else if (this.get_variable('ProjectId').match(/DotNetNuke Factory|SharePoint Factory/))
            Sys.UI.DomElement.setVisible($get('ThemePreview_TouchUI'), false);
        $get('ThemeDialog_ThemeContainer').className = String.format('Field Theme {0}', theme);
    },
    _executeThemeDialogCallback: function (name) {
        this._executeDialogCallback(this._themeCallbacks, name);
    },
    get_theme: function () {
        if (!IsDotNetNukeFactory() && !IsSharePointFactory() && !CodeOnTime.Client.get_isStandard())
            return 'Aquarium';

        return $get('ThemeDialog_Theme').value;
    },
    showLayoutDialog: function (autoFocus) {
        this.hideDialog();
        this.showDialog('LayoutDialog');
        if (autoFocus) $get('LayoutDialog_Layout').focus();
    },
    initializeLayoutDialog: function (project, callbacks) {
        var layout = this.readProperty(project, 'p:project/p:layout/@name', 'Classic');
        var menuStyle = this.readProperty(project, 'p:project/p:layout/@menuStyle', 'MultiLevel')
        this._layoutCallbacks = callbacks ? callbacks : [];
        this.appendResource('_System\\Resources.Layout.htm');
        $get('LayoutDialog_Layout').value = layout;
    },
    _executeLayoutDialogCallback: function (name) {
        this._executeDialogCallback(this._layoutCallbacks, name);
    },
    get_layout: function () {
        return $get('LayoutDialog_Layout').value;
    },
    get_menuStyle: function () {
        return $get('FeaturesDialog_MenuPresentationStyle').value;
    },
    get_sourceControl: function () {
        return $get('SourceControl').value;
    },
    showFeaturesDialog: function (autoFocus) {
        this.hideDialog();
        this.showDialog('FeaturesDialog');
        if (autoFocus)
            this.focusTabView('FeaturesDialog');
    },
    initializeFeaturesDialog: function (options, features, callbacks) {
        this._featuresCallbacks = callbacks ? callbacks : [];

        this.appendResource('_System\\Resources.Features.htm');

        if (this.get_isHostedFactory()) {
            Sys.UI.DomElement.setVisible($get('FeaturesDialog_PageHeaderAndCopyrightTab'), false);
            Sys.UI.DomElement.setVisible($get('FeaturesDialog_NavigationTab'), false);
            Sys.UI.DomElement.setVisible($get('FeaturesDialog_PermalinksAndHistory'), false);
        }
        else
            Sys.UI.DomElement.setVisible($get('FeaturesDialog_PackagingTab'), false);

        Sys.UI.DomElement.setVisible($get('FeaturesDialog_TouchUITab'), !this.get_isHostedFactory());
        Sys.UI.DomElement.setVisible($get('FeaturesDialog_CMSTab'), !this.get_isHostedFactory());

        this._initializeTabView('FeaturesDialog_TabView', options.tabViewSelection);
        $get('FeaturesDialog_PageHeader').value = options.pageHeader;
        $get('FeaturesDialog_Copyright').value = options.copyright;
        $get('FeaturesDialog_Annotations').checked = options.annotations == 'true';
        $get('FeaturesDialog_AnnotationsPath').value = options.annotationsPath;
        $get('FeaturesDialog_NewColumn').checked = options.newColumn == 'true';
        $get('FeaturesDialog_Floating').checked = options.floating == 'true';

        // Touch UI Tab
        $get('FeaturesDialog_DesktopDisplayDensity').value = options.desktopDisplayDensity;
        $get('FeaturesDialog_MobileDisplayDensity').value = options.mobileDisplayDensity;
        $get('FeaturesDialog_Transitions').value = options.transitions;
        if (options.sidebar == 'true')
            options.sidebar = 'Landscape';
        else if (options.sidebar == 'false')
            options.sidebar = 'Never';
        $get('FeaturesDialog_Sidebar').value = options.sidebar;
        $get('FeaturesDialog_LabelsInList').value = options.labelsInList;
        $get('FeaturesDialog_InitialListMode').value = options.initialListMode;
        $get('FeaturesDialog_MenuLocation').value = options.menuLocation;
        $get('FeaturesDialog_PromoteActions').checked = options.promoteActions == 'true';
        $get('FeaturesDialog_SmartDates').checked = options.smartDates == 'true';
        $get('FeaturesDialog_MapApiIdentifier').value = options.mapApiIdentifier;
        $get('FeaturesDialog_MapApiIdentifierMobile').value = options.mapApiIdentifierMobile;

        // CMS
        $get('FeaturesDialog_SearchEngine').value = options.searchEngine;
        $get('FeaturesDialog_AnalysisEngine').value = options.analysisEngine;
        $get('FeaturesDialog_AnalysisOnDataPages').checked = options.analysisOnDataPages == 'true';

        $get('FeaturesDialog_MaxGridFields').value = options.maxGridFields;
        $get('FeaturesDialog_MultiSelect').checked = options.multiSelect == 'true';
        $get('FeaturesDialog_BatchEdit').checked = options.batchEdit == 'true';
        $get('FeaturesDialog_AdvancedSearch').checked = options.advancedSearch == 'true';
        $get('FeaturesDialog_AdvancedLookup').checked = options.advancedLookup == 'true';
        $get('FeaturesDialog_RelationshipExplorer').checked = options.relationshipExplorer == 'true';
        $get('FeaturesDialog_EnablePermalinks').checked = options.permalinks == 'true';
        $get('FeaturesDialog_EnableHistory').checked = options.historyEnabled == 'true';
        $get('FeaturesDialog_EnableTransactions').checked = options.enableTransactions == 'true';
        if (window.external.IsPremium)
            $get('FeaturesDialog_ShowModalForms').checked = options.showModalForms == 'true';
        else {
            $get('FeaturesDialog_ShowModalForms').disabled = true;
            $get('FeaturesDialog_ShowModalFormsLabel').disabled = true;
        }
        $get('FeaturesDialog_UseSaveAndNew').checked = options.useSaveAndNew == 'true';
        $get('FeaturesDialog_EaseUrlHashing').checked = options.urlHashing == 'true';
        if (!window.external.IsUnlimited) {
            $get('FeaturesDialog_EaseUrlHashing').disabled = true;
            $get('FeaturesDialog_EaseUrlHashingLabel').disabled = true;
            $get('FeaturesDialog_EaseAuditing').disabled = true;
            $get('FeaturesDialog_EaseAuditingLabel').disabled = true;
        }
        //        $get('FeaturesDialog_DetectUnderscoreSeparatedSchema').checked = detectUnderscoreSeparatedSchema == 'true';
        $get('FeaturesDialog_MenuPresentationStyle').value = options.menuStyle;
        Sys.UI.DomElement.setVisible($get('FeaturesDialog_MenuPresentationStyle_Settings'), !this.get_isHostedFactory());
        if (!window.external.IsPremium)
            $get('FeaturesDialog_MenuPresentationStyle_Settings').disabled = 'disabled';
        if (this.get_isHostedFactory()) {
            $get('FeaturesDialog_PackageProperties').value = this.readProperty(features, 'p:packageProperties',
                this.get_isSharePointFactory() ?
                    'Title = \r\n' +
                    'Description = \r\n' +
                    ''
                    :
                    'Version = 01.00.00\r\n' +
                    'Friendly Name = \r\n' +
                    'Description   = DotNetNuke Factory application module\r\n' +
                    'Owner Name    = Code On Time\r\n' +
                    'Owner Organization =  Code On Time LLC\r\n' +
                    'Owner Url = http://codeontime.com\r\n' +
                    'Owner Email = customerservice@codeontime.com');
        }
        var easeAuditing = this.readProperty(features, 'p:ease/p:auditing');
        if (easeAuditing)
            $get('FeaturesDialog_EaseAuditing').value = easeAuditing;
        $get('FeaturesDialog_Grid_ActionColumn').checked = this.readProperty(features, 'p:grid/@actionColumn') == 'true';
        var deliveryMethod = this.readProperty(features, 'p:smtp/@deliveryMethod', 'Network');
        $get('FeaturesDialog_SMTPConfig_DeliveryMethod').value = deliveryMethod;
        $get('FeaturesDialog_SMTPConfig_ClientDomain').value = this.readProperty(features, 'p:smtp/@clientDomain', '');
        $get('FeaturesDialog_SMTPConfig_From').value = this.readProperty(features, 'p:smtp/@from', '');
        $get('FeaturesDialog_SMTPConfig_DeliveryFormat').value = this.readProperty(features, 'p:smtp/@deliveryFormat', '');
        $get('FeaturesDialog_SMTPConfig_TargetName').value = this.readProperty(features, 'p:smtp/@targetName', '');
        $get('FeaturesDialog_SMTPConfig_EnableSsl').checked = this.readProperty(features, 'p:smtp/@enableSsl', 'false') == 'true';
        $get('FeaturesDialog_SMTPConfig_Host').value = this.readProperty(features, 'p:smtp/@host', '');
        $get('FeaturesDialog_SMTPConfig_Port').value = this.readProperty(features, 'p:smtp/@port', '');
        $get('FeaturesDialog_SMTPConfig_DefaultCredentials').checked = this.readProperty(features, 'p:smtp/@defaultCredentials', 'true') == 'true';
        $get('FeaturesDialog_SMTPConfig_Username').value = this.readProperty(features, 'p:smtp/@username', '');
        $get('FeaturesDialog_SMTPConfig_Password').value = this.readProperty(features, 'p:smtp/@password', '');
        $get('FeaturesDialog_SMTPConfig_PickupDirectoryLocation').value = this.readProperty(features, 'p:smtp/@pickupDirectoryLocation', '');

        this._configureFeatureAddons(features);
        CodeOnTime.Client.configureSMTPSettings(deliveryMethod);
    },
    AddonCatalog: ['OfflineSync', 'ContentMaker', /*'Survey', 'AssistantUI'*/],
    _configureFeatureAddons: function (features) {
        var that = this;
        if (!that.Addons) {
            // init the map of addons and event handlers for UI elements
            that.Addons = eval('(' + window.external.Addons + ')');
            $(document).on('click', '#FeaturesDialog_Addons :checkbox', function () {
                CodeOnTime.Client.configureAddon($(this));
            }).on('click', '#FeaturesDialog_Addons select', function () {
                if ($(this).val() === 'NotInstalled')
                    $openUrl('https://codeontime.com/buy#' + $(this).data('type').toLowerCase() + '-addon');
            });
        }

        var addonTypes = $('#FeaturesDialog_Addons').find(':checkbox');
        addonTypes.each(function () {
            var addonCheckbox = $(this),
                name = addonCheckbox.attr('id').match(/_Addons_(\w+?)$/);
            if (name) {
                name = name[1];
                addonCheckbox.data('type', name);
                if (Array.indexOf(that.AddonCatalog, name) === -1)
                    addonCheckbox.attr('disabled', 'disabled').next('label').first().attr('disabled', 'disabled');
                else
                    that.configureAddon(addonCheckbox, that.readProperty(features, 'p:addons/@' + name));
            }
        });
    },
    configureAddon: function (addonCheckbox, value) {
        var type = addonCheckbox.data('type'),
            addons = this.Addons[type] || [],
            selector = $('#' + addonCheckbox.attr('id') + '_Selector');
        if (!selector.length) {
            // <select id="FeaturesDialog_Addons_OfflineSync" style="float:right"><option>Not Installed</option></select>
            selector = $('<select style="float:right"></select>').attr('id', 'FeaturesDialog_Addons_' + type + '_Selector').data('type', type);
            $(addons).each(function () {
                var option = $('<option/>').attr('value', this.fileName).text(this.text).appendTo(selector);
                if (value === this.fileName)
                    option.attr('selected', 'selected');
            });
            if (!addons.length)
                $('<option value="NotInstalled">This add-on is not installed</option>').appendTo(selector.css({ 'font-weight': 'bold' }));
            selector.insertBefore(addonCheckbox);
        }
        if (arguments.length === 2) {
            if (value && value === selector.val()) {
                addonCheckbox.attr('checked', 'checked');
                selector.show();
            }
            else
                selector.hide();
        }
        else {
            if (addonCheckbox.is(':checked'))
                selector.show();
            else
                selector.hide();
        }
    },
    persistAddons: function (project) {
        var that = this;
        $(that.AddonCatalog).each(function () {
            var type = this,
                addonCheckbox = $('#FeaturesDialog_Addons_' + type),
                selector = $('#FeaturesDialog_Addons_' + type + '_Selector'),
                fileName = selector.val();
            if (addonCheckbox.length) {
                if (!addonCheckbox.is(':checked') || fileName === 'NotInstalled')
                    fileName = null;
                that.writeProperty(project, 'p:project/p:features/p:addons/@' + type, fileName);
            }
        });
    },
    _executeFeaturesDialogCallback: function (name) {
        this._executeDialogCallback(this._featuresCallbacks, name);
    },
    configureSMTPSettings: function (deliveryMethod) {
        if (!deliveryMethod)
            deliveryMethod = $get('FeaturesDialog_SMTPConfig_DeliveryMethod').value;
        Sys.UI.DomElement.setVisible($get('FeaturesDialog_SMTPConfig_NetworkFields'), deliveryMethod == 'Network');
        Sys.UI.DomElement.setVisible($get('FeaturesDialog_SMTPConfig_BasicAuth'), !$get('FeaturesDialog_SMTPConfig_DefaultCredentials').checked);
        Sys.UI.DomElement.setVisible($get('FeaturesDialog_SMTPConfig_SpecifyPickupDirectoryFields'), deliveryMethod == 'SpecifiedPickupDirectory');
    },
    get_annotationsFeature: function () {
        return $get('FeaturesDialog_Annotations').checked ? 'true' : 'false';
    },
    get_annotationsPathFeature: function () {
        return $get('FeaturesDialog_AnnotationsPath').value;
    },
    get_newColumnFeature: function () {
        return $get('FeaturesDialog_NewColumn').checked ? 'true' : 'false';
    },
    get_floatingFeature: function () {
        return $get('FeaturesDialog_Floating').checked ? 'true' : 'false';
    },
    get_maxGridFieldsFeature: function () {
        var v = $get('FeaturesDialog_MaxGridFields').value;
        if (!v.match(/^\d+$/)) v = '10';
        return v;
    },
    get_multiSelectFeature: function () {
        return $get('FeaturesDialog_MultiSelect').checked ? 'true' : 'false';
    },
    get_batchEditFeature: function () {
        return $get('FeaturesDialog_BatchEdit').checked ? 'true' : 'false';
    },
    get_pageHeaderFeature: function () {
        return $get('FeaturesDialog_PageHeader').value;
    },
    get_copyrightFeature: function () {
        return $get('FeaturesDialog_Copyright').value;
    },
    get_features: function () {
        return {
            'advancedSearch': $get('FeaturesDialog_AdvancedSearch').checked ? 'true' : 'false',
            'advancedLookup': $get('FeaturesDialog_AdvancedLookup').checked ? 'true' : 'false',
            'relationshipExplorer': $get('FeaturesDialog_RelationshipExplorer').checked ? 'true' : 'false',
            'permalinks': $get('FeaturesDialog_EnablePermalinks').checked ? 'true' : 'false',
            'history': $get('FeaturesDialog_EnableHistory').checked ? 'true' : 'false',
            'enableTransactions': $get('FeaturesDialog_EnableTransactions').checked ? 'true' : 'false',
            'showModalForms': $get('FeaturesDialog_ShowModalForms').checked ? 'true' : 'false',
            'useSaveAndNew': $get('FeaturesDialog_UseSaveAndNew').checked ? 'true' : 'false',
            'urlHashing': $get('FeaturesDialog_EaseUrlHashing').checked ? 'true' : 'false',
            //'detectUnderscoreSeparatedSchema': $get('FeaturesDialog_DetectUnderscoreSeparatedSchema').checked ? 'true' : 'false',
            'menuPresentationStyle': $get('FeaturesDialog_MenuPresentationStyle').value,
            'packageProperties': $get('FeaturesDialog_PackageProperties').value,
            'easeAuditing': $get('FeaturesDialog_EaseAuditing').value,
            'actionColumn': $get('FeaturesDialog_Grid_ActionColumn').checked ? 'true' : 'false',
            'desktopDisplayDensity': $get('FeaturesDialog_DesktopDisplayDensity').value,
            'mobileDisplayDensity': $get('FeaturesDialog_MobileDisplayDensity').value,
            'transitions': $get('FeaturesDialog_Transitions').value,
            'sidebar': $get('FeaturesDialog_Sidebar').value,
            'labelsInList': $get('FeaturesDialog_LabelsInList').value,
            'initialListMode': $get('FeaturesDialog_InitialListMode').value,
            'menuLocation': $get('FeaturesDialog_MenuLocation').value,
            'promoteActions': $get('FeaturesDialog_PromoteActions').checked ? 'true' : 'false',
            'smartDates': $get('FeaturesDialog_SmartDates').checked ? 'true' : 'false',
            'mapApiIdentifier': $get('FeaturesDialog_MapApiIdentifier').value,
            'mapApiIdentifierMobile': $get('FeaturesDialog_MapApiIdentifierMobile').value,
            'searchEngine': $get('FeaturesDialog_SearchEngine').value,
            'analysisEngine': $get('FeaturesDialog_AnalysisEngine').value,
            'analysisOnDataPages': $get('FeaturesDialog_AnalysisOnDataPages').checked ? 'true' : 'false',
            'clientDomain': $get('FeaturesDialog_SMTPConfig_ClientDomain').value,
            'from': $get('FeaturesDialog_SMTPConfig_From').value,
            'deliveryFormat': $get('FeaturesDialog_SMTPConfig_DeliveryFormat').value,
            'targetName': $get('FeaturesDialog_SMTPConfig_TargetName').value,
            'enableSsl': $get('FeaturesDialog_SMTPConfig_EnableSsl').checked ? 'true' : 'false',
            'deliveryMethod': $get('FeaturesDialog_SMTPConfig_DeliveryMethod').value,
            'host': $get('FeaturesDialog_SMTPConfig_Host').value,
            'port': $get('FeaturesDialog_SMTPConfig_Port').value,
            'defaultCredentials': $get('FeaturesDialog_SMTPConfig_DefaultCredentials').checked ? 'true' : 'false',
            'username': $get('FeaturesDialog_SMTPConfig_Username').value,
            'password': $get('FeaturesDialog_SMTPConfig_Password').value,
            'pickupDirectoryLocation': $get('FeaturesDialog_SMTPConfig_PickupDirectoryLocation').value
        };
    },
    get_showDemoLink: function () {
        return window.external.ShowDemoLink;
    },
    set_showDemoLink: function (value) {
        window.external.ShowDemoLink = value;
    },
    get_isEducational: function () {
        return window.external.IsEducational;
    },
    _initializeTabView: function (id, selectedTab) {
        selectedTab = selectedTab == null ? null : Number.parseInvariant(selectedTab);
        var content = $get(id);
        var tabView = document.createElement('div');
        var sb = new Sys.StringBuilder();
        sb.append(String.format('<table id="{0}$TabView" class="TabView"><tr><td id="{0}$Tabs" class="Tabs"></td><td id="{0}$Body" class="Body"><div id="{0}$Views" class="Views"></div></td></tr></table>', id));
        tabView.innerHTML = sb.toString();
        sb.clear();
        content.parentNode.insertBefore(tabView, content);
        // initialize tabs
        sb.append('<ul>');
        var tabs = $get(id + '$Tabs');
        var views = $get(id + '$Views');
        var index = 0;
        for (var i = 0; i < content.childNodes.length; i++) {
            var tabContent = content.childNodes[i];
            if (tabContent.tagName != 'DIV' || !Sys.UI.DomElement.getVisible(tabContent)) continue;
            // initialize a tab and its body
            var selected = selectedTab == null && index == 0 || selectedTab == index;
            if (selected)
                $get(String.format('{0}$TabView', id)).setAttribute('SelectedTab', index);
            sb.append(String.format('<li><a href="javascript:" onclick="CodeOnTime.Client._toggleTabView(\'{2}\',{3});return false" class="{1}" id="{2}$Tab{3}">{0}</a></li>',
                tabContent.title,
                selected ? 'Selected' : '',
                id, index));
            tabContent.id = String.format('{0}$View{1}', id, index);
            views.appendChild(tabContent);
            Sys.UI.DomElement.setVisible(tabContent, selected);
            tabContent.title = '';
            index++;
        }
        sb.append('</ul>');
        tabs.innerHTML = sb.toString();
    },
    _get_tabViewSelection: function (id) {
        var elem = $get(String.format('{0}$TabView', id));
        var result = null;
        if (elem)
            result = elem.getAttribute('SelectedTab');
        if (result == null)
            result = '0';
        return result;
    },
    _toggleTabView: function (id, index) {
        var i = 0;
        do {
            var elem = $get(String.format('{0}$Tab{1}', id, i));
            if (!elem) break;
            // de-select the tab
            Sys.UI.DomElement.removeCssClass(elem, 'Selected');
            // hide the view
            elem = $get(String.format('{0}$View{1}', id, i));
            Sys.UI.DomElement.setVisible(elem, false);
            // process next tab/view
            i++;
        }
        while (true);
        // activate the tab
        elem = $get(String.format('{0}$Tab{1}', id, index));
        Sys.UI.DomElement.addCssClass(elem, 'Selected');

        $get(String.format('{0}$TabView', id)).setAttribute('SelectedTab', index);

        elem = $get(String.format('{0}$View{1}', id, index));
        Sys.UI.DomElement.setVisible(elem, true);
        $(window).trigger('resize');
        this.focusTabView(elem);
        //        var inputs = elem.getElementsByTagName('input');
        //        for (i = 0; i < inputs.length; i++) {
        //            elem = inputs[i];
        //            if (elem.type != 'hidden') {
        //                try {
        //                    //elem.select();
        //                    elem.focus();
        //                }
        //                catch (ex) {
        //                }
        //                break;
        //            }
        //        }
    },
    focusTabView: function (container) {
        if (typeof container == 'string')
            container = $get(container + '_TabView$TabView');
        for (var i = 0; i < container.childNodes.length; i++) {
            var elem = container.childNodes[i];
            if (elem.tagName == 'TEXTAREA' || elem.tagName == 'INPUT' && elem.type != 'hidden' || elem.tagName == 'SELECT') {
                try {
                    //elem.select();
                    elem.focus();
                    return true;
                }
                catch (ex) {
                }
            }
            else {
                var result = this.focusTabView(elem);
                if (result)
                    return result;
            }
        }
        return false;
    },
    addCultureSet: function () {
        var culture = $get('GlobalizationDialog_Culture').value;
        var uiCulture = $get('GlobalizationDialog_UICulture').value;
        var cultureSet = culture + ', ' + uiCulture;
        if (confirm(String.format('Your project will support "{0}" culture set. Press OK to add the culture set to the supported cultures.', cultureSet))) {
            var sc = $get('GlobalizationDialog_SupportedCultures');
            sc.value += (sc.value != '' ? '\n' : '') + cultureSet;
            this.resetCultureSet();
        }
    },
    resetCultureSet: function () {
        $get('GlobalizationDialog_Culture').value = window.external.GetCurrentNeutralCulture();
        $get('GlobalizationDialog_UICulture').value = window.external.GetCurrentSpecificCulture();
    },
    showProviderHelp: function (providerName) {
        switch (providerName) {
            case 'System.Data.SqlClient':
                $openUrl('http://codeontime.com/learn/sample-applications/northwind');
                break;
            case 'System.Data.OracleClient':
            case 'Oracle.DataAccess.Client':
            case 'Oracle.ManagedDataAccess.Client':
                $openUrl('http://codeontime.com/learn/sample-applications/hr');
                break;
            case 'MySql.Data.MySqlClient':
                $openUrl('http://codeontime.com/learn/sample-applications/sakila');
                break;
            case 'IBM.Data.DB2':
                $openUrl('http://codeontime.com/learn/sample-applications/sample-db2');
                break;
            case 'iAnywhere.Data.SQLAnywhere':
                $openUrl('http://codeontime.com/learn/sample-applications/demo-sqlanywhere');
                break;
            case 'Npgsql':
                $openUrl('http://codeontime.com/learn/sample-applications/pagila-postgresql');
                break;
            default:
                alert('No help available for this provider.');
        }
    },
    getWindowsVersion: function () {
        var versions = window.external.GetWindowsVersion().split('.');
        return {
            'Major': parseInt(versions[0]),
            'Minor': parseInt(versions[1]),
            'Revision': parseInt(versions[2])
        };
    },
    getPreviewConfig: function () {
        var config = null;
        if (arguments.length == 0)
            config = window.external.GetPreviewConfig();
        else
            config = window.external.GetPreviewConfigBy(arguments[0], arguments[1]);
        return Sys.Serialization.JavaScriptSerializer.deserialize(config);
    },
    copyToClipboard: function (text) {
        window.external.CopyToClipboard(text);
    },
    traceWriteLine: function (text) {
        window.external.TraceWriteLine(text);
    },
    asyncCallbacks: [],
    asyncCall: function (type, options, success) {
        var callbackId = new Date().getTime();
        window.external.AsyncCall(type, callbackId, JSON.stringify(options));
        var cover = $('<div class="cover"></div>').appendTo($('body'));
        var queryCallbackInterval = setInterval(function () {
            var result = window.external.GetAsyncCallback(callbackId);
            if (result != '503') {
                clearInterval(queryCallbackInterval);
                cover.remove();
                success(result);
            }
        }, 50);
    },
    externalQuery: function (options, success, failure) {
        var method = options.method || 'GET',
            url = options.url,
            body = "", headers = "",
            result = null;

        if (options.data) {
            if (options.contentType == 'application/json')
                body = JSON.stringify(options.data);
            else {
                var first = true;
                for (d in options.data) {
                    if (first)
                        first = false;
                    else
                        body += '&';
                    body += encodeURIComponent(d) + '=' + encodeURIComponent(options.data[d]);
                }
            }
            if (!method.match(/POST|PUT/))
                url += '?' + body;
        }

        if (options.headers)
            $.each(options.headers, function (i, h) {
                if (i != 0)
                    headers += '\n';
                headers += h.name + ': ' + h.value;
            });

        CodeOnTime.Client.asyncCall('httprequest', {
            url: url,
            method: method,
            headers: headers,
            body: body,
            contentType: options.contentType
        }, function (result) {
            if (result && result.startsWith('Error: ')) {
                if (failure) {
                    result = result.substring(7);
                    if (result && result[0] == '{')
                        result = JSON.parse(result);
                    failure(result);
                }
            }
            else if (success) {
                if (result && result[0] == '{')
                    result = JSON.parse(result);
                success(result);
            }
        });

    },
    authenticateAzure: function (options, success, failure) {
        var config = options.config,
            code;

        if (options.refresh)
            code = config.RefreshToken;
        else
            code = window.external.GetAzureAuthCode(config.TenantID, config.ClientID)

        if (!code)
            return;

        var data = {
            client_id: config.ClientID,
            redirect_uri: 'https://codeontime.com/publish/azure',
            client_secret: config.ClientSecret,
            resource: 'https://management.azure.com/'
        };
        if (!options.refresh) {
            data.grant_type = 'authorization_code';
            data.code = code;
        }
        else {
            data.grant_type = 'refresh_token';
            data.refresh_token = code;
        }

        this.externalQuery({
            url: String.format("https://login.microsoftonline.com/{0}/oauth2/token", config.TenantID),
            method: 'POST',
            contentType: 'application/x-www-form-urlencoded',
            data: data
        }, function (result) {
            if (result.access_token)
                config.AccessToken = result.access_token;
            if (result.refresh_token)
                config.RefreshToken = result.refresh_token;
            success(config);
        }, function (result) {
            alert(JSON.stringify(result))
            if (failure)
                failure(result);
        });
    },
    queryAzure: function (options, success, failure) {
        if (!options.config.AccessToken) {
            this.reauthenticateAzure(options, success, failure);
            return;
        }
        var auth = 'Bearer ' + options.config.AccessToken,
            addAuth = true;

        if (!options.url) {
            if (options.endpoint[0] != '/')
                options.endpoint = '/' + options.endpoint;
            options.url = 'https://management.azure.com' + options.endpoint;
        }
        if (!options.data)
            options.data = {};
        if (!options.headers)
            options.headers = [];
        else
            $(options.headers).each(function () {
                if (this.name == 'Authorization') {
                    this.value = auth;
                    addAuth = false;
                }
            })

        if (addAuth)
            options.headers.push({ name: 'Authorization', value: auth });

        if (!options.apiVersion)
            options.apiVersion = '2017-03-01';

        if (options.method && options.method.match(/POST|PUT/))
            options.url += '?api-version=' + options.apiVersion;
        else
            options.data['api-version'] = options.apiVersion;

        if (!failure)
            failure = function (error) {
                if (typeof (error) == 'object')
                    error = JSON.stringify(error);
                alert(error);
            };

        this.externalQuery(options, success, function (result) {
            if (options.doRefreshToken != false && result.error) {

                if (result.error.code == "ExpiredAuthenticationToken") {
                    CodeOnTime.Client.authenticateAzure({
                        refresh: true,
                        config: options.config
                    }, function (result) {
                        options.doRefreshToken = false;
                        options.config.AccessToken = result.AccessToken;
                        options.config.RefreshToken = result.RefreshToken;
                        CodeOnTime.Client.queryAzure(options, success, failure);
                    }, function () {
                        alert('Your token has expired! Please sign in again.');
                        CodeOnTime.Client.reauthenticateAzure(options, success, failure);
                    });
                }
                else if (result.error.code == 'AuthenticationFailed') {
                    CodeOnTime.Client.reauthenticateAzure(options, success, failure);
                }
            }
            else
                failure(result);
        });
    },
    reauthenticateAzure: function (options, originalSuccess, originalFailure) {
        options.config.AccessToken = null;
        options.config.RefreshToken = null;
        CodeOnTime.Client.authenticateAzure({
            config: options.config
        }, function (result) {
            options.config.AccessToken = result.AccessToken;
            options.config.RefreshToken = result.RefreshToken;
            CodeOnTime.Client.queryAzure(options, originalSuccess, originalFailure);
        }, function (result) {
            showPage('AuthenticateAzure');
        });
    },
    publish: function (options) {
        switch (options.mode) {
            case 'FileSystem':
                return 'C:\Users\Dennis Bykkov\Documents\Code OnTime\Publish\Web Site Factory\NW1';
            case 'FTP':
                return window.external.PublishFTP(options.url, options.username, options.password, options.data);
        }
    },
    enumerateDirectory: function (success) {
        CodeOnTime.Client.asyncCall('localmanifest', '', function (result) {
            if (result && result[0] == '{')
                result = JSON.parse(result);
            success(result);
        });
    },
    cloneDirectory: function (from, to) {
        window.external.CloneDirectory(from, to);
    },
    zipDirectory: function (from, to) {
        window.external.ZipDirectory(from, to);
    },
    copyFile: function (from, to) {
        window.external.CopyFile(from, to);
    },
    openFolderWithSelection: function (path) {
        window.external.OpenFolderWithSelection(path);
    },
    enumerateFTP: function (options, success) {
        CodeOnTime.Client.asyncCall('ftpmanifest', options, function (result) {
            if (result && result[0] == '{')
                result = JSON.parse(result);
            success(result);
        });
    },
    testFTP: function (options, success, failure) {
        CodeOnTime.Client.uiBusy(true);
        CodeOnTime.Client.asyncCall('ftplistdirectory', options, function (result) {
            CodeOnTime.Client.uiBusy(false);
            if (!result)
                failure('Something went wrong.');
            if (result && result.startsWith('ERROR: '))
                failure(result.substring(7));
            else
                success(result);
        });
    },
    uiBusy: function (value) {
        if (arguments.length == 0)
            return window.external.uiBusy;
        else
            window.external.uiBusy = value;
    },
    uiProgress: function () {
        return window.external.uiProgress;
    },
    publishMode: function (value) {
        if (!arguments.length)
            return window.external.PublishMode;
        else
            window.external.PublishMode = value;
    },
    publishDebugMode: function (value) {
        if (!arguments.length)
            return window.external.PublishDebugMode;
        else
            window.external.PublishDebugMode = value;
    }
}

CodeOnTime._ClientLibrary.registerClass('CodeOnTime._ClientLibrary', Sys.Component);
Sys.Application.add_init(function () {
    CodeOnTime.Client = $create(CodeOnTime._ClientLibrary);
});
CodeOnTime.Client = new CodeOnTime._ClientLibrary();
CodeOnTime.Client.EmptyStringRegex = / /;
CodeOnTime.Client.ValidProjectNameRegex = / /;
CodeOnTime.Client.ConnectionStringRegex = / /i;


// we use this function to open urls since flash does not work if launched from 64-bit enbedded browser from a link
function $openUrl(url) {
    window.external.OpenUrl(url);
    return false;
}

function $confirm(text, caption, buttons, icon) {
    var result = window.external.Confirm(text, caption, buttons, icon);
    if (!buttons || buttons.toLowerCase() == 'okcancel')
        return result == 'OK';
    else if (buttons.toLowerCase() == 'yesno')
        return result == 'Yes';
    return result;
}

$addHandler(window, 'resize', function () { CodeOnTime.Client.resizeDialog(); });

CodeOnTime._ClientLibrary._libraryService = "http://store.codeontime.com/libraryservice.svc";
CodeOnTime._ClientLibrary._debugLibraryService = "http://localhost:52787/libraryservice.svc";

function browserPulse() {
    //    if (document.body.style.backgroundColor == 'yellow')
    //        document.body.style.backgroundColor = '';
    //    else
    //        document.body.style.backgroundColor = 'yellow';
    //
}