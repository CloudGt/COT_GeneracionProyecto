/*!
* Data Aquarium Framework - Resources
* Copyright 2008-2022 Code On Time LLC; Licensed MIT; http://codeontime.com/license
*/
(function () {
    Type.registerNamespace('Web');

    var _dvr = Web.DataViewResources = {};

    _dvr.Common = {
        WaitHtml: '<div class="Wait"></div>'
    };

    _dvr.Pager = {
        ItemsPerPage: '^ItemsPerPage^Items per page: ^ItemsPerPage^',
        PageSizes: [10, 15, 20, 25],
        ShowingItems: '^ShowingItems^Showing <b>{0}</b>-<b>{1}</b> of <b>{2}</b> items^ShowingItems^',
        SelectionInfo: ' (<b>{0}</b> selected)',
        Refresh: '^Refresh^Refresh^Refresh^',
        Next: '^Next^Next^Next^ »',
        Previous: '« ^Previous^Previous^Previous^',
        Page: '^Page^Page^Page^',
        PageButtonCount: 10
    };

    _dvr.ActionBar = {
        View: '^View^View^View^'
    };

    _dvr.ModalPopup = {
        Close: '^Close^Close^Close^',
        MaxWidth: 800,
        MaxHeight: 600,
        OkButton: '^OK^OK^OK^',
        CancelButton: '^Cancel^Cancel^Cancel^',
        SaveButton: '^Save^Save^Save^',
        SaveAndNewButton: '^SaveAndNew^Save and New^SaveAndNew^'
    };

    _dvr.Menu = {
        SiteActions: '^SiteActions^Site Actions^SiteActions^',
        SeeAlso: '^SeeAlso^See Also^SeeAlso^',
        Summary: '^Summary^Summary^Summary^',
        Tasks: '^Tasks^Tasks^Tasks^',
        About: '^About^About^About^'
    };

    _dvr.HeaderFilter = {
        GenericSortAscending: '^GenericSortAscending^Smallest on Top^GenericSortAscending^',
        GenericSortDescending: '^GenericSortDescending^Largest on Top^GenericSortDescending^',
        StringSortAscending: '^StringSortAscending^Ascending^StringSortAscending^',
        StringSortDescending: '^StringSortDescending^Descending^StringSortDescending^',
        DateSortAscending: '^DateSortAscending^Earliest on Top^DateSortAscending^',
        DateSortDescending: '^DateSortDescending^Latest on Top^DateSortDescending^',
        EmptyValue: '^EmptyValue^(Empty)^EmptyValue^',
        BlankValue: '^BlankValue^(Blank)^BlankValue^',
        Loading: '^Loading^Loading...^Loading^',
        ClearFilter: '^ClearFilter^Clear Filter from {0}^ClearFilter^',
        SortBy: '^SortBy^Sort by {0}^SortBy^',
        MaxSampleTextLen: 80,
        CustomFilterOption: '^CustomFilterOption^Filter...^CustomFilterOption^'
    };

    _dvr.InfoBar = {
        FilterApplied: '^FilterApplied^A filter has been applied.^FilterApplied^',
        ValueIs: ' <span class="Highlight">{0}</span> ',
        Or: ' ^InfoBarOr^or^InfoBarOr^ ',
        And: ' ^InfoBarAnd^and^InfoBarAnd^ ',
        EqualTo: '^InfoBarEqualTo^is equal to^InfoBarEqualTo^ ',
        LessThan: '^InfoBarLessThan^is less than^InfoBarLessThan^ ',
        LessThanOrEqual: '^InfoBarLessThanOrEqual^is less than or equal to^InfoBarLessThanOrEqual^ ',
        GreaterThan: '^InfoBarGreaterThan^is greater than^InfoBarGreaterThan^ ',
        GreaterThanOrEqual: '^InfoBarGreaterThanOrEqual^is greater than or equal to^InfoBarGreaterThanOrEqual^ ',
        Like: '^InfoBarLike^is like^InfoBarLike^ ',
        StartsWith: '^InfoBarStartsWith^starts with^InfoBarStartsWith^ ',
        Empty: '^InfoBarEmpty^empty^InfoBarEmpty^',
        QuickFind: ' ^InfoBarQuickFind^Any field contains^InfoBarQuickFind^ '
    };

    _dvr.Lookup = {
        SelectToolTip: '^SelectToolTip^Select {0}^SelectToolTip^',
        ClearToolTip: '^ClearToolTip^Clear {0}^ClearToolTip^',
        NewToolTip: '^NewToolTip^New {0}^NewToolTip^',
        SelectLink: '^SelectLink^(select)^SelectLink^',
        ShowActionBar: true,
        DetailsToolTip: '^DetailsToolTip^View details for {0}^DetailsToolTip^',
        ShowDetailsInPopup: true,
        GenericNewToolTip: '^GenericNewToolTip^Create New^GenericNewToolTip^',
        AddItem: '^AddItem^Add Item^AddItem^'
    };

    _dvr.Validator = {
        Required: '^Required^Required^Required^',
        RequiredField: '^RequiredField^This field is required.^RequiredField^',
        EnforceRequiredFieldsWithDefaultValue: false,
        NumberIsExpected: '^NumberIsExpected^A number is expected.^NumberIsExpected^',
        BooleanIsExpected: '^BooleanIsExpected^A logical value is expected.^BooleanIsExpected^',
        DateIsExpected: '^DateIsExpected^A date is expected.^DateIsExpected^',
        Optional: '^Optional^Optional^Optional^'
    };

    var _mn = Sys.CultureInfo.CurrentCulture.dateTimeFormat.MonthNames;

    _dvr.Data = {
        ConnectionLost: '^ConnectionLost^The network connection has been lost. Try again?^ConnectionLost^',
        AnyValue: '^AnyValue^(any)^AnyValue^',
        NullValue: '<span class="NA">^NullValue^n/a^NullValue^</span>',
        NullValueInForms: '^NullValueInForms^N/A^NullValueInForms^',
        BooleanDefaultStyle: 'DropDownList',
        BooleanOptionalDefaultItems: [[null, '^NullValueInForms^N/A^NullValueInForms^'], [false, '^No^No^No^'], [true, '^Yes^Yes^Yes^']],
        BooleanDefaultItems: [[false, '^No^No^No^'], [true, '^Yes^Yes^Yes^']],
        MaxReadOnlyStringLen: 600,
        NoRecords: '^NoRecords^No records found.^NoRecords^',
        BlobHandler: 'Blob.ashx',
        BlobDownloadLink: '^BlobDownloadLink^download^BlobDownloadLink^',
        BlobDownloadLinkReadOnly: '<span style="color:gray;">^BlobDownloadLink^download^BlobDownloadLink^</span>',
        BlobDownloadHint: '^BlobDownloadHint^Click here to download the original file.^BlobDownloadHint^',
        BlobDownloadOriginalHint: '^BlobDownloadOriginalHint^Tap image to download the original file.^BlobDownloadOriginalHint^',
        BatchUpdate: '^BatchUpdate^update^BatchUpdate^',
        NoteEditLabel: '^NoteEditLabel^edit^NoteEditLabel^',
        NoteDeleteLabel: '^NoteDeleteLabel^delete^NoteDeleteLabel^',
        NoteDeleteConfirm: '^NoteDeleteConfirm^Delete?^NoteDeleteConfirm^',
        UseLEV: '^UseLEV^Paste "{0}"^UseLEV^',
        DiscardChanges: '^DiscardChanges^Discard changes?^DiscardChanges^',
        KeepOriginalSel: '^KeepOriginalSel^keep original selection^KeepOriginalSel^',
        DeleteOriginalSel: '^DeleteOriginalSel^delete original selection^DeleteOriginalSel^',
        Import: {
            UploadInstruction: '^ImportUploadInstruction^Please select the file to upload. The file must be in <b>CSV</b>, <b>XLS</b>, or <b>XLSX</b> format.^ImportUploadInstruction^',
            DownloadTemplate: '^ImportDownloadTemplate^Download import file template.^ImportDownloadTemplate^',
            Uploading: '^ImportUploading^Your file is being uploaded to the server. Please wait...^ImportUploading^',
            MappingInstruction: '^ImportMappingInstruction^There are <b>{0}</b> record(s) in the file <b>{1}</b> ready to be processed.<br/>Please map the import fields from data file to the application fields and click <i>Import</i> to start processing.^ImportMappingInstruction^',
            StartButton: '^ImportStartButton^Import^ImportStartButton^',
            AutoDetect: '^ImportAutoDetect^(auto detect)^ImportAutoDetect^',
            Processing: '^ImportProcessing^Import file processing has been initiated. The imported data records will become available upon successful processing. You may need to refresh the relevant views/pages to see the imported records.^ImportProcessing^',
            Email: '^ImportEmail^Send the import log to the following email addresses (optional)^ImportEmail^',
            EmailNotSpecified: '^ImportEmailNotSpecified^Recipient of the import log has not been specified. Proceed anyway?^ImportEmailNotSpecified^'
        },
        Filters: {
            Labels: {
                And: '^FilterLabelAnd^and^FilterLabelAnd^',
                Or: '^FilterLabelOr^or^FilterLabelOr^',
                Equals: '^FilterLabelEquals^equals^FilterLabelEquals^',
                Clear: '^FilterLabelClear^Clear^FilterLabelClear^',
                SelectAll: '^FilterLabelSelectAll^(Select All)^FilterLabelSelectAll^',
                Includes: '^FilterLabelIncludes^includes^FilterLabelIncludes^',
                FilterToolTip: '^FilterLabelFilterToolTip^Change^FilterLabelFilterToolTip^'
            },
            Number: {
                Text: '^NumberFilterText^Number Filters^NumberFilterText^',
                Kind: '^Number^Number^Number^',
                List: [
                    { Function: '=', Text: '^Equals^Equals^Equals^', Prompt: true },
                    { Function: '<>', Text: '^DoesNotEqual^Does Not Equal^DoesNotEqual^', Prompt: true },
                    { Function: '<', Text: '^LessThan^Less Than^LessThan^', Prompt: true },
                    { Function: '>', Text: '^GreaterThan^Greater Than^GreaterThan^', Prompt: true },
                    { Function: '<=', Text: '^LessThanOrEqual^Less Than Or Equal^LessThanOrEqual^', Prompt: true },
                    { Function: '>=', Text: '^GreateThanOrEqual^Greater Than Or Equal^GreateThanOrEqual^', Prompt: true },
                    { Function: '$between', Text: '^Between^Between^Between^', Prompt: true },
                    { Function: '$in', Text: '^Includes^Includes^Includes^', Prompt: true, Hidden: true },
                    { Function: '$notin', Text: '^DoesNotInclude^Does Not Include^DoesNotInclude^', Prompt: true, Hidden: true },
                    { Function: '$isnotempty', Text: '^NotEmpty^Not Empty^NotEmpty^' },
                    { Function: '$isempty', Text: '^Empty^Empty^Empty^' }
                ]
            },
            Text: {
                Text: '^TextFilterText^Text Filters^TextFilterText^',
                Kind: '^Text^Text^Text^',
                List: [
                    { Function: '=', Text: '^Equals^Equals^Equals^', Prompt: true },
                    { Function: '<>', Text: '^DoesNotEqual^Does Not Equal^DoesNotEqual^', Prompt: true },
                    { Function: '$beginswith', Text: '^BeginsWith^Begins With^BeginsWith^', Prompt: true },
                    { Function: '$doesnotbeginwith', Text: '^DoesNotBeginWith^Does Not Begin With^DoesNotBeginWith^', Prompt: true },
                    { Function: '$contains', Text: '^Contains^Contains^Contains^', Prompt: true },
                    { Function: '$doesnotcontain', Text: '^DoesNotContain^Does Not Contain^DoesNotContain^', Prompt: true },
                    { Function: '$endswith', Text: '^EndsWith^Ends With^EndsWith^', Prompt: true },
                    { Function: '$doesnotendwith', Text: '^DoesNotEndWith^Does Not End With^DoesNotEndWith^', Prompt: true },
                    { Function: '$in', Text: '^Includes^Includes^Includes^', Prompt: true, Hidden: true },
                    { Function: '$notin', Text: '^DoesNotInclude^Does Not Include^DoesNotInclude^', Prompt: true, Hidden: true },
                    { Function: '$isnotempty', Text: '^NotEmpty^Not Empty^NotEmpty^' },
                    { Function: '$isempty', Text: '^Empty^Empty^Empty^' }
                ]
            },
            Boolean: {
                Text: '^BooleanFilterText^Logical Filters^BooleanFilterText^',
                Kind: '^Logical^Logical^Logical^',
                List: [
                    { Function: '$true', Text: '^Yes^Yes^Yes^' },
                    { Function: '$false', Text: '^No^No^No^' },
                    { Function: '$isnotempty', Text: '^NotEmpty^Not Empty^NotEmpty^' },
                    { Function: '$isempty', Text: '^Empty^Empty^Empty^' }
                ]
            },
            Date: {
                Text: '^DateFilterText^Date Filters^DateFilterText^',
                Kind: '^Date^Date^Date^',
                List: [
                    { Function: '=', Text: '^Equals^Equals^Equals^', Prompt: true },
                    { Function: '<>', Text: '^DoesNotEqual^Does Not Equal^DoesNotEqual^', Prompt: true },
                    { Function: '<', Text: '^Before^Before^Before^', Prompt: true },
                    { Function: '>', Text: '^After^After^After^', Prompt: true },
                    { Function: '<=', Text: '^OnOrBefore^On or Before^OnOrBefore^', Prompt: true },
                    { Function: '>=', Text: '^OnOrAfter^On or After^OnOrAfter^', Prompt: true },
                    { Function: '$between', Text: '^Between^Between^Between^', Prompt: true },
                    { Function: '$in', Text: '^Includes^Includes^Includes^', Prompt: true, Hidden: true },
                    { Function: '$notin', Text: '^DoesNotInclude^Does Not Include^DoesNotInclude^', Prompt: true, Hidden: true },
                    { Function: '$isnotempty', Text: '^NotEmpty^Not Empty^NotEmpty^' },
                    { Function: '$isempty', Text: '^Empty^Empty^Empty^' },
                    null,
                    { Function: '$tomorrow', Text: '^Tomorrow^Tomorrow^Tomorrow^' },
                    { Function: '$today', Text: '^Today^Today^Today^' },
                    { Function: '$yesterday', Text: '^Yesterday^Yesterday^Yesterday^' },
                    null,
                    { Function: '$nextweek', Text: '^NextWeek^Next Week^NextWeek^' },
                    { Function: '$thisweek', Text: '^ThisWeek^This Week^ThisWeek^' },
                    { Function: '$lastweek', Text: '^LastWeek^Last Week^LastWeek^' },
                    null,
                    { Function: '$nextmonth', Text: '^NextMonth^Next Month^NextMonth^' },
                    { Function: '$thismonth', Text: '^ThisMonth^This Month^ThisMonth^' },
                    { Function: '$lastmonth', Text: '^LastMonth^Last Month^LastMonth^' },
                    null,
                    { Function: '$nextquarter', Text: '^NextQuarter^Next Quarter^NextQuarter^' },
                    { Function: '$thisquarter', Text: '^ThisQuarter^This Quarter^ThisQuarter^' },
                    { Function: '$lastquarter', Text: '^LastQuarter^Last Quarter^LastQuarter^' },
                    null,
                    { Function: '$nextyear', Text: '^NextYear^Next Year^NextYear^' },
                    { Function: '$thisyear', Text: '^ThisYear^This Year^ThisYear^' },
                    { Function: '$yeartodate', Text: '^YearToDate^Year to Date^YearToDate^' },
                    { Function: '$lastyear', Text: '^LastYear^Last Year^LastYear^' },
                    null,
                    { Function: '$past', Text: '^Past^Past^Past^' },
                    { Function: '$future', Text: '^Future^Future^Future^' },
                    null,
                    {
                        Text: '^AllDatesInPreriod^All Dates in the Period^AllDatesInPreriod^',
                        List: [
                            { Function: '$quarter1', Text: '^Quarter1^Quarter 1^Quarter1^' },
                            { Function: '$quarter2', Text: '^Quarter2^Quarter 2^Quarter2^' },
                            { Function: '$quarter3', Text: '^Quarter3^Quarter 3^Quarter3^' },
                            { Function: '$quarter4', Text: '^Quarter4^Quarter 4^Quarter4^' },
                            null,
                            { Function: '$month1', Text: _mn[0] },
                            { Function: '$month2', Text: _mn[1] },
                            { Function: '$month3', Text: _mn[2] },
                            { Function: '$month4', Text: _mn[3] },
                            { Function: '$month5', Text: _mn[4] },
                            { Function: '$month6', Text: _mn[5] },
                            { Function: '$month7', Text: _mn[6] },
                            { Function: '$month8', Text: _mn[7] },
                            { Function: '$month9', Text: _mn[8] },
                            { Function: '$month10', Text: _mn[9] },
                            { Function: '$month11', Text: _mn[10] },
                            { Function: '$month12', Text: _mn[11] }
                        ]
                    }
                ]
            }
        }
    };


    _dvr.Form = {
        ShowActionBar: true,
        ShowCalendarButton: true,
        RequiredFieldMarker: '<span class="Required">*</span>',
        RequiredFiledMarkerFootnote: '* - ^RequiredFiledMarkerFootNote^indicates a required field^RequiredFiledMarkerFootNote^',
        SingleButtonRowFieldLimit: 7,
        GeneralTabText: '^GeneralTabText^General^GeneralTabText^',
        Minimize: '^Minimize^Collapse^Minimize^',
        Maximize: '^Maximize^Expand^Maximize^'
    };

    _dvr.Grid = {
        InPlaceEditContextMenuEnabled: true,
        QuickFindText: '^QuickFindText^Quick Find^QuickFindText^',
        QuickFindToolTip: '^QuickFindToolTip^Type to search the records and press Enter^QuickFindToolTip^',
        ShowAdvancedSearch: '^ShowAdvancedSearch^Show Advanced Search^ShowAdvancedSearch^',
        VisibleSearchBarFields: 3,
        DeleteSearchBarField: '^DeleteSearchBarField^(delete)^DeleteSearchBarField^',
        //AddSearchBarField: '^AddSearchBarField^More Search Fields^AddSearchBarField^',
        HideAdvancedSearch: '^HideAdvancedSearch^Hide Advanced Search^HideAdvancedSearch^',
        PerformAdvancedSearch: '^PerformAdvancedSearch^Search^PerformAdvancedSearch^',
        ResetAdvancedSearch: '^ResetAdvancedSearch^Reset^ResetAdvancedSearch^',
        NewRowLink: '^NewRowLink^Click here to create a new record.^NewRowLink^',
        RootNodeText: '^RootNodeText^Top Level^RootNodeText^',
        FlatTreeToggle: '^FlatTreeToggle^Switch to Hierarchy^FlatTreeToggle^',
        HierarchyTreeModeToggle: '^HierarchyTreeModeToggle^Switch to Flat List^HierarchyTreeModeToggle^',
        AddConditionText: '^AddConditionText^Add search condition^AddConditionText^',
        AddCondition: '^AddCondition^Add Condition^AddCondition^',
        RemoveCondition: '^RemoveCondition^Remove Condition^RemoveCondition^',
        ActionColumnHeaderText: '^ActionBarActionsHeaderText^Actions^ActionBarActionsHeaderText^',
        Aggregates: {
            None: { FmtStr: '', ToolTip: '' },
            Sum: { FmtStr: '^SumAggregate^Total: {0}^SumAggregate^', ToolTip: '^SumAggregateToolTip^Total of {0}^SumAggregateToolTip^' },
            Count: { FmtStr: '^CountAggregate^Count: {0}^CountAggregate^', ToolTip: '^CountAggregateToolTip^Count of {0}^CountAggregateToolTip^' },
            Avg: { FmtStr: '^AvgAggregate^Avg: {0}^AvgAggregate^', ToolTip: '^AvgAggregateToolTip^Average of {0}^AvgAggregateToolTip^' },
            Max: { FmtStr: '^MaxAggregate^Max: {0}^MaxAggregate^', ToolTip: '^MaxAggregateToolTip^Maximum of {0}^MaxAggregateToolTip^' },
            Min: { FmtStr: '^MinAggregate^Min: {0}^MinAggregate^', ToolTip: '^MinAggregateToolTip^Minimum of {0}^MinAggregateToolTip^' }
        },
        Freeze: '^Freeze^Freeze^Freeze^',
        Unfreeze: '^Unfreeze^Unfreeze^Unfreeze^'
    };

    _dvr.Views = {
        DefaultDescriptions: {
            '$DefaultGridViewDescription': '^DefaultGridViewDescription^This is a list of {0}.^DefaultGridViewDescription^',
            '$DefaultEditViewDescription': '^DefaultEditViewDescription^Please review {0} information below. Press Edit to change this record, press Delete to delete the record, or press Cancel/Close to return back.^DefaultEditViewDescription^',
            '$DefaultCreateViewDescription': '^DefaultCreateViewDescription^Please fill this form and press Save button to create a new {0} record. Press Cancel to return to the previous screen.^DefaultCreateViewDescription^'
        },
        DefaultCategoryDescriptions: {
            '$DefaultEditDescription': '^DefaultEditDescription^These are the fields of the {0} record that can be edited.^DefaultEditDescription^',
            '$DefaultNewDescription': '^DefaultNewDescription^Complete the form. Make sure to enter all required fields.^DefaultNewDescription^',
            '$DefaultReferenceDescription': '^DefaultReferenceDescription^Additional details about {0} are provided in the reference information section.^DefaultReferenceDescription^'
        }
    };

    _dvr.Actions = {
        Scopes: {
            'Grid': {
                'Select': {
                    HeaderText: '^SelectActionHeaderText^Select^SelectActionHeaderText^'
                },
                'Edit': {
                    HeaderText: '^EditActionHeaderText^Edit^EditActionHeaderText^'
                },
                'Delete': {
                    HeaderText: '^DeleteActionHeaderText^Delete^DeleteActionHeaderText^',
                    Confirmation: '^DeleteActionConfirmation^Delete?^DeleteActionConfirmation^',
                    Notify: '^Deleted^{$selected} deleted^Deleted^'
                },
                'Duplicate': {
                    HeaderText: '^DuplicateActionHeaderText^Duplicate^DuplicateActionHeaderText^'
                },
                'New': {
                    HeaderText: '^NewActionHeaderText^New^NewActionHeaderText^'
                },
                'BatchEdit': {
                    HeaderText: '^BatchEditActionHeaderText^Batch Edit^BatchEditActionHeaderText^'
                    //                    ,CommandArgument: {
                    //                        'editForm1': {
                    //                            HeaderText: '^BatchEditInFormActionHeaderText^Batch Edit (Form)^BatchEditInFormActionHeaderText^'
                    //                        }
                    //                    }
                },
                'Open': {
                    HeaderText: '^OpenActionHeaderText^Open^OpenActionHeaderText^'
                }
            },
            'Form': {
                'Edit': {
                    HeaderText: '^EditActionHeaderText^Edit^EditActionHeaderText^'
                },
                'Delete': {
                    HeaderText: '^DeleteActionHeaderText^Delete^DeleteActionHeaderText^',
                    Confirmation: '^DeleteActionConfirmation^Delete?^DeleteActionConfirmation^',
                    Notify: '^Deleted^{$selected} deleted^Deleted^'
                },
                'Cancel': {
                    HeaderText: '^DefaultCancelActionHeaderText^Close^DefaultCancelActionHeaderText^',
                    WhenLastCommandName: {
                        'Duplicate': {
                            HeaderText: '^EditModeCancelActionHeaderText^Cancel^EditModeCancelActionHeaderText^'
                        },
                        'Edit': {
                            HeaderText: '^EditModeCancelActionHeaderText^Cancel^EditModeCancelActionHeaderText^'
                        },
                        'New': {
                            HeaderText: '^EditModeCancelActionHeaderText^Cancel^EditModeCancelActionHeaderText^'
                        }

                    }
                },
                'Update': {
                    HeaderText: '^UpdateActionHeaderText^OK^UpdateActionHeaderText^',
                    Notify: '^Saved^Saved - {0}^Saved^',
                    CommandArgument: {
                        'Save': {
                            HeaderText: '^Save^Save^Save^',
                            Notify: '^Saved^Saved - {0}^Saved^'
                        },
                        'SaveAndContinue': {
                            HeaderText: '^SaveAndContinue^Save and Continue^SaveAndContinue^',
                            Notify: '^Saved^Saved - {0}^Saved^'
                        }
                    },
                    WhenLastCommandName: {
                        'BatchEdit': {
                            HeaderText: '^UpdateActionInBatchModeHeaderText^Update Selection^UpdateActionInBatchModeHeaderText^',
                            Confirmation: '^UpdateActionInBatchModeConfirmation^Update?^UpdateActionInBatchModeConfirmation^',
                            Notify: '^Saved^Saved - {0}^Saved^'
                        }
                    }
                },
                'Insert': {
                    HeaderText: '^InsertActionHeaderText^OK^InsertActionHeaderText^',
                    Notify: '^Saved^Saved - {0}^Saved^',
                    CommandArgument: {
                        'Save': {
                            HeaderText: '^Save^Save^Save^',
                            Notify: '^Saved^Saved - {0}^Saved^'
                        },
                        'SaveAndNew': {
                            HeaderText: '^SaveAndNew^Save and New^SaveAndNew^',
                            Notify: '^Saved^Saved - {0}^Saved^'
                        }
                    }
                },
                'Confirm': {
                    HeaderText: '^UpdateActionHeaderText^OK^UpdateActionHeaderText^'
                },
                'Navigate': {
                    Controller: {
                        'SiteContent': {
                            HeaderText: '^AddSystemIdentity^Add System Identity^AddSystemIdentity^'
                        }
                    }
                }
            },
            'ActionBar': {
                _Self: {
                    'Actions': {
                        HeaderText: '^ActionBarActionsHeaderText^Actions^ActionBarActionsHeaderText^'
                    },
                    'Report': {
                        HeaderText: '^ActionBarReportHeaderText^Report^ActionBarReportHeaderText^'
                    },
                    'Record': {
                        HeaderText: '^ActionBarRecordHeaderText^Record^ActionBarRecordHeaderText^'
                    }
                },
                'New': {
                    HeaderText: '^ActionBarNewHeaderText^New {0}^ActionBarNewHeaderText^',
                    Description: '^ActionBarNewHeaderDescription^Create a new {0} record.^ActionBarNewHeaderDescription^',
                    HeaderText2: '^ActionBarNewHeaderText2^New^ActionBarNewHeaderText2^',
                    VarMaxLen: 15
                },
                'Edit': {
                    HeaderText: '^EditActionHeaderText^Edit^EditActionHeaderText^'
                },
                'Delete': {
                    HeaderText: '^DeleteActionHeaderText^Delete^DeleteActionHeaderText^',
                    Confirmation: '^DeleteActionConfirmation^Delete?^DeleteActionConfirmation^',
                    Notify: '^Deleted^{$selected} deleted^Deleted^'
                },
                'ExportCsv': {
                    HeaderText: '^ExportCsvActionHeaderText^Download^ExportCsvActionHeaderText^',
                    Description: '^ExportCsvActionDescription^Download items in CSV format.^ExportCsvActionDescription^'
                },
                'ExportRowset': {
                    HeaderText: '^ExportRowsetActionHeaderText^Export to Spreadsheet^ExportRowsetActionHeaderText^',
                    Description: '^ExportRowsetActionDescription^Analyze items with spreadsheet<br/>application.^ExportRowsetActionDescription^'
                },
                'ExportRss': {
                    HeaderText: '^ExportRssActionHeaderText^View RSS Feed^ExportRssActionHeaderText^',
                    Description: '^ExportRssActionDescription^Syndicate items with an RSS reader.^ExportRssActionDescription^'
                },
                'Import': {
                    HeaderText: '^ImportActionHeaderText^Import From File^ImportActionHeaderText^',
                    Description: '^ImportActionDescription^Upload a CSV, XLS, or XLSX file<br/>to import records.^ImportActionDescription^'
                },
                'Update': {
                    HeaderText: '^ActionBarUpdateActionHeaderText^Save^ActionBarUpdateActionHeaderText^',
                    Description: '^ActionBarUpdateActionDescription^Save changes to the database.^ActionBarUpdateActionDescription^',
                    Notify: '^Saved^Saved - {0}^Saved^'
                },
                'Insert': {
                    HeaderText: '^ActionBarInsertActionHeaderText^Save^ActionBarInsertActionHeaderText^',
                    Description: '^ActionBarInsertActionDescription^Save new record to the database.^ActionBarInsertActionDescription^',
                    Notify: '^Saved^Saved - {0}^Saved^'
                },
                'Cancel': {
                    HeaderText: '^ActionBarCancelActionHeaderText^Cancel^ActionBarCancelActionHeaderText^',
                    WhenLastCommandName: {
                        'Edit': {
                            HeaderText: '^ActionBarCancelActionHeaderText^Cancel^ActionBarCancelActionHeaderText^',
                            Description: '^ActionBarCancelWhenEditActionDescription^Cancel all record changes.^ActionBarCancelWhenEditActionDescription^'
                        },
                        'New': {
                            HeaderText: '^ActionBarCancelActionHeaderText^Cancel^ActionBarCancelActionHeaderText^',
                            Description: '^ActionBarCancelWhenNewActionDescription^Cancel new record.^ActionBarCancelWhenNewActionDescription^'
                        }
                    }
                },
                'Report': {
                    HeaderText: '^ReportActionHeaderText^Report^ReportActionHeaderText^',
                    Description: '^ReportActionDescription^Render a report in PDF format^ReportActionDescription^'
                },
                'ReportAsPdf': {
                    HeaderText: '^ReportAsPdfActionHeaderText^PDF Document^ReportAsPdfActionHeaderText^',
                    Description: '^ReportAsPdfActionDescription^View items as Adobe PDF document.<br/>Requires a compatible reader.^ReportAsPdfActionDescription^'
                },
                'ReportAsImage': {
                    HeaderText: '^ReportAsImageActionHeaderText^Multipage Image^ReportAsImageActionHeaderText^',
                    Description: '^ReportAsImageActionDescription^View items as a multipage TIFF image.^ReportAsImageActionDescription^'
                },
                'ReportAsExcel': {
                    HeaderText: '^ReportAsExcelActionHeaderText^Spreadsheet^ReportAsExcelActionHeaderText^',
                    Description: '^ReportAsExcelActionDescription^View items in a formatted<br/>Microsoft Excel spreadsheet.^ReportAsExcelActionDescription^'
                },
                'ReportAsWord': {
                    HeaderText: '^ReportAsWordActionHeaderText^Microsoft Word^ReportAsWordActionHeaderText^',
                    Description: '^ReportAsWordActionDescription^View items in a formatted<br/>Microsoft Word document.^ReportAsWordActionDescription^'
                },
                'DataSheet': {
                    HeaderText: '^DataSheetActionHeaderText^Show in Data Sheet^DataSheetActionHeaderText^',
                    Description: '^DataSheetActionDescription^Display items using a data sheet<br/>format.^DataSheetActionDescription^'
                },
                'Grid': {
                    HeaderText: '^GridActionHeaderText^Show in Standard View^GridActionHeaderText^',
                    Description: '^GridActionDescription^Display items in the standard<br/>list format.^GridActionDescription^'
                },
                'Tree': {
                    HeaderText: '^TreeActionHeaderText^Show Hierarchy^TreeActionHeaderText^',
                    Description: '^TreeActionDescription^Display hierarchical relationships.^TreeActionDescription^'
                },
                'Search': {
                    HeaderText: '^PerformAdvancedSearch^Search^PerformAdvancedSearch^',
                    Description: '^PerformAdvancedSearch^Search^PerformAdvancedSearch^ {0}'
                },
                'Upload': {
                    HeaderText: '^Upload^Upload^Upload^',
                    Description: '^UploadDescription^Upload multiple files.^UploadDescription^'
                }
            },
            'Row': {
                'Update': {
                    HeaderText: '^RowUpdateActionHeaderText^Save^RowUpdateActionHeaderText^',
                    Notify: '^Saved^Saved - {0}^Saved^',
                    WhenLastCommandName: {
                        'BatchEdit': {
                            HeaderText: '^RowUpdateWhenBatchEditActionHeaderText^Update Selection^RowUpdateWhenBatchEditActionHeaderText^',
                            Confirmation: '^RowUpdateWhenBatchEditActionConfirmation^Update?^RowUpdateWhenBatchEditActionConfirmation^'
                        }
                    }
                },
                'Insert': {
                    HeaderText: '^RowInsertActionHeaderText^Insert^RowInsertActionHeaderText^',
                    Notify: '^Saved^Saved - {0}^Saved^'
                },
                'Cancel': {
                    HeaderText: '^RowCancelActionHeaderText^Cancel^RowCancelActionHeaderText^'
                }
            },
            'ActionColumn': {
                'Edit': {
                    HeaderText: '^EditActionHeaderText^Edit^EditActionHeaderText^'
                },
                'Delete': {
                    HeaderText: '^DeleteActionHeaderText^Delete^DeleteActionHeaderText^',
                    Confirmation: '^DeleteActionConfirmation^Delete?^DeleteActionConfirmation^',
                    Notify: '^Deleted^{$selected} deleted^Deleted^'
                }
            }
        }
    };

    _dvr.Editor = {
        Undo: '^Undo^Undo^Undo^',
        Redo: '^Redo^Redo^Redo^',
        Bold: '^Bold^Bold^Bold^',
        Italic: '^Italic^Italic^Italic^',
        Underline: '^Underline^Underline^Underline^',
        Strikethrough: '^StrikeThrough^Strike Through^StrikeThrough^',
        Subscript: '^Subscript^Sub Script^Subscript^',
        Superscript: '^Superscript^Super Script^Superscript^',
        JustifyLeft: '^JustifyLeft^Justify Left^JustifyLeft^',
        JustifyCenter: '^JustifyCenter^Justify Center^JustifyCenter^',
        JustifyRight: '^JustifyRight^Justify Right^JustifyRight^',
        JustifyFull: '^JustifyFull^Justify Full^JustifyFull^',
        InsertOrderedList: '^InsertOrderedList^Insert Ordered List^InsertOrderedList^',
        InsertUnorderedList: '^InsertUnorderedList^Insert Unordered List^InsertUnorderedList^',
        CreateLink: '^CreateLink^Create Link^CreateLink^',
        UnLink: '^UnLink^Unlink^UnLink^',
        RemoveFormat: '^RemoveFormat^Remove Format^RemoveFormat^',
        SelectAll: '^SelectAll^Select All^SelectAll^',
        UnSelect: '^UnSelect^Unselect^UnSelect^',
        Delete: '^Delete^Delete^Delete^',
        Cut: '^Cut^Cut^Cut^',
        Copy: '^Copy^Copy^Copy^',
        Paste: '^Paste^Paste^Paste^',
        BackColor: '^BackColor^Back Color^BackColor^',
        ForeColor: '^ForeColor^Fore Color^ForeColor^',
        FontName: '^FontName^Font Name^FontName^',
        FontSize: '^FontSize^Font Size^FontSize^',
        Indent: '^Indent^Indent^Indent^',
        Outdent: '^Outdent^Outdent^Outdent^',
        InsertHorizontalRule: '^InsertHorizontalRule^Insert Horizontal Rule^InsertHorizontalRule^',
        HorizontalSeparator: '^Separator^Separator^Separator^',
        Format: '^Format^Format^Format^',
        FormatBlock: {
            p: '^Paragraph^Paragraph^Paragraph^',
            blockquote: '^Quotation^Quotation^Quotation^',
            h1: '^Heading1^Heading 1^Heading1^',
            h2: '^Heading2^Heading 2^Heading2^',
            h3: '^Heading3^Heading 3^Heading3^',
            h4: '^Heading4^Heading 4^Heading4^',
            h5: '^Heading5^Heading 5^Heading5^',
            h6: '^Heading6^Heading 6^Heading6^'
        },
        Rtf: {
            editor: '^Fullscreen^Fullscreen^Fullscreen^'
        }
    };

    _dvr.Draw = {
        Draw: '^Draw^Draw^Draw^',
        Pen: '^Pen^Pen^Pen^',
        Highlighter: '^Highlighter^Highlighter^Highlighter^',
        Blur: '^Blur^Blur^Blur^',
        Eraser: '^Eraser^Eraser^Eraser^'
    };

    _dvr.Mobile = {
        UpOneLevel: '^UpOneLevel^Up One Level^UpOneLevel^',
        Back: '^Back^Back^Back^',
        BatchEdited: '^BatchEdited^{0} updated^BatchEdited^',
        Sort: '^Sort^Sort^Sort^',
        Sorted: '^Sorted^Sorted^Sorted^',
        SortedDefault: '^SortedDefault^Default sort order.^SortedDefault^',
        SortByField: '^SortByField^Select a field to change the sort order of <b>{0}</b>.^SortByField^',
        SortByOptions: '^SortByOptions^Select the sort order of <b>{0}</b> by the field <b>{1}</b> in the list of options below.^SortByOptions^',
        DefaultOption: '^DefaultOption^Default^DefaultOption^',
        Auto: '^Auto^Auto^Auto^',
        Filter: '^Filter^Filter^Filter^',
        List: '^ListViewStyle^List^ListViewStyle^',
        Cards: '^Cards^Cards^Cards^',
        Grid: '^Grid^Grid^Grid^',
        Map: '^Map^Map^Map^',
        Calendar: '^Calendar^Calendar^Calendar^',
        ZoomIn: '^ZoomIn^Zoom in^ZoomIn^',
        ZoomOut: '^ZoomOut^Zoom out^ZoomOut^',
        Directions: '^Directions^Directions^Directions^',
        AlternativeView: '^AlternativeView^Select an alternative view of data.^AlternativeView^',
        PresentationStyle: '^PresentationStyle^Select a data presentation style.^PresentationStyle^',
        LookupViewAction: '^View^View^View^',
        LookupSelectAction: '^SelectActionHeaderText^Select^SelectActionHeaderText^',
        LookupClearAction: '^FilterLabelClear^Clear^FilterLabelClear^',
        LookupNewAction: '^NewActionHeaderText^New^NewActionHeaderText^',
        LookupInstruction: '^LookupInstruction^Please select <b>{0}</b> in the list. ^LookupInstruction^',
        LookupOriginalSelection: '^LookupOriginalSelection^The original selection is <b>"{0}"</b>. ^LookupOriginalSelection^',
        EmptyContext: '^EmptyContext^Actions are not available.^EmptyContext^',
        Favorites: '^Favorites^Favorites^Favorites^',
        History: '^History^History^History^',
        FilterSiteMap: '^FilterSiteMap^Filter site map...^FilterSiteMap^',
        ResumeLookup: '^ResumeLookup^Resume Lookup^ResumeLookup^',
        ResumeEntering: '^ResumeEntering^Resume Entering^ResumeEntering^',
        ResumeEditing: '^ResumeEditing^Resume Editing^ResumeEditing^',
        ResumeBrowsing: '^ResumeBrowsing^Resume Browsing^ResumeBrowsing^',
        ResumeViewing: '^ResumeViewing^Resume Viewing^ResumeViewing^',
        Menu: '^Menu^Menu^Menu^',
        Home: '^Home^Home^Home^',
        Settings: '^Settings^Settings^Settings^',
        Sidebar: '^Sidebar^Sidebar^Sidebar^',
        Landscape: '^Landscape^Landscape^Landscape^',
        Portrait: '^Portrait^Portrait^Portrait^',
        Never: '^Never^Never^Never^',
        Always: '^Always^Always^Always^',
        ShowSystemButtons: '^ShowSystemButtons^Show System Buttons^ShowSystemButtons^',
        OnHover: '^OnHover^On Hover^OnHover^',
        ButtonShapes: '^ButtonShapes^Button Shapes^ButtonShapes^',
        PromoteActions: '^PromoteActions^Promote Actions^PromoteActions^',
        ConfirmReload: '^ConfirmReload^Reload?^ConfirmReload^',
        ClearText: '^ClearText^Clear^ClearText^',
        SeeAll: '^SeeAll^See All^SeeAll^',
        More: '^More^More^More^',
        TouchUINotSupported: '^TouchUINotSupported^Touch UI is not supported in this browser.^TouchUINotSupported^',
        ShowingItemsInfo: '^ShowingItemsInfo^Showing {0} items.^ShowingItemsInfo^',
        FilterByField: '^FilterByField^Select a field to apply a filter to <b>{0}</b>.^FilterByField^',
        Apply: '^Apply^Apply^Apply^',
        FilterByOptions: '^FilterByOptions^Select one or more options in the list below and press <b>{2}</b> to filter <b>{0}</b> by the field <b>{1}</b>.^FilterByOptions^',
        Suggestions: '^Suggestions^Suggestions^Suggestions^',
        UnSelect: '^UnSelect^Unselect^UnSelect^',
        AdvancedSearch: '^AdvancedSearch^Advanced Search^AdvancedSearch^',
        QuickFindScope: '^QuickFindScope^Search in...^QuickFindScope^',
        QuickFindDescription: '^QuickFindDescription^Search in {0}^QuickFindDescription^',
        AddMatchingGroup: '^AddMatchingGroup^Add matching group^AddMatchingGroup^',
        MatchAll: '^MatchAll^Match all conditions^MatchAll^',
        MatchAny: '^MatchAny^Match any conditions^MatchAny^',
        DoNotMatchAll: '^DoNotMatchAll^Do not match all conditions^DoNotMatchAll^',
        DoNotMatchAny: '^DoNotMatchAny^Do not match any conditions^DoNotMatchAny^',
        MatchAllPastTense: '^MatchAllPastTense^Matched all conditions^MatchAllPastTense^',
        MatchAnyPastTense: '^MatchAnyPastTense^Matched any conditions^MatchAnyPastTense^',
        DoNotMatchAllPastTense: '^DoNotMatchAllPastTense^Did not match all conditions^DoNotMatchAllPastTense^',
        DoNotMatchAnyPastTense: '^DoNotMatchAnyPastTense^Did not match any conditions^DoNotMatchAnyPastTense^',
        In: '^In^in^In^',
        Recent: '^Recent^Recent^Recent^',
        Matched: '^Matched^Matched^Matched^',
        DidNotMatch: '^DidNotMatch^Did not match^DidNotMatch^',
        ClearFilter: '^ClearFilter2^Clear Filter^ClearFilter2^',
        ResetSearchConfirm: '^ResetSearchConfirm^Reset search conditions?^ResetSearchConfirm^',
        FilterCleared: '^FilterCleared^Cleared all filters.^FilterCleared^',
        AdvancedSearchInstruction: '^AdvancedSearchInstruction^Enter conditions that must be matched and press search button.^AdvancedSearchInstruction^',
        Refreshed: '^Refreshed^Refreshed^Refreshed^',
        Group: '^Group^Group^Group^',
        Grouped: '^Grouped^Grouped^Grouped^',
        UnGrouped: '^UnGrouped^Grouping has been removed^UnGrouped^',
        GroupedBy: '^GroupedBy^Grouped by^GroupedBy^',
        GroupByField: '^GroupByField^Select a field to group <b>{0}</b>.^GroupByField^',
        Show: '^Show^Show^Show^',
        Hide: '^Hide^Hide^Hide^',
        None: '^TransitionNone^None^TransitionNone^',
        Next: '^Next2^Next^Next2^',
        Prev: '^Prev2^Prev^Prev2^',
        FitToWidth: '^FitToWidth^Fit To Width^FitToWidth^',
        MultiSelection: '^MultiSelection^Multi Selection^MultiSelection^',
        InlineEditing: '^InlineEditing^Inline Editing^InlineEditing^',
        ItemsSelectedOne: '^ItemsSelectedOne^{0} item selected^ItemsSelectedOne^',
        ItemsSelectedMany: '^ItemsSelectedMany^{0} items selected^ItemsSelectedMany^',
        TypeToSearch: '^TypeToSearch^Type to Search^TypeToSearch^',
        NoMatches: '^NoMatches^No matches.^NoMatches^',
        ShowingItemsRange: '^ShowingItemsRange^Showing {0} of {1} items^ShowingItemsRange^',
        Finish: '^Finish^Finish^Finish^',
        ShowOptions: '^ShowOptions^Show Options^ShowOptions^',
        ConfirmContinue: '^ConfirmContinue^Continue?^ConfirmContinue^',
        AddAccount: '^AddAccount^Add Account^AddAccount^',
        Fullscreen: '^Fullscreen^Fullscreen^Fullscreen^',
        ExitFullscreen: '^ExitFullscreen^Exit Fullscreen^ExitFullscreen^',
        Apps: '^Apps^Apps^Apps^',
        Forget: '^Forget^Forget^Forget^',
        ManageAccounts: '^ManageAccounts^Manage Accounts^ManageAccounts^',
        SignedOut: '^SignedOut^Signed Out^SignedOut^',
        Submit: '^Submit^Submit^Submit^',
        Error: '^Error^Error^Error^',
        Line: '^Line^Line^Line^',
        Download: '^Download^Download^Download^',
        Orientation: '^Orientation^Orientation^Orientation^',
        Device: '^Device^Device^Device^',
        ShowMore: '^ShowMore^Show More^ShowMore^',
        ShowLess: '^ShowLess^Show Less^ShowLess^',
        WithSpecifiedFilters: '^WithSpecifiedFilters^With Specified Filters^WithSpecifiedFilters^',
        WithSelectedValues5: '^WithSelectedValues5^With Selected Values (Top 5)^WithSelectedValues5^',
        WithSelectedValues10: '^WithSelectedValues10^With Selected Values (Top 10)^WithSelectedValues10^',
        ReadOnly: '^ReadOnly^{0} is read-only.^ReadOnly^',
        ScanToConfirm: '^ScanToConfirm^Please scan again to confirm.^ScanToConfirm^',
        Reading: '^Reading^Reading...^Reading^',
        ReadingPane: '^ReadingPane^Reading Pane^ReadingPane^',
        AutoOpenNextItem: '^AutoOpenNextItem^Auto-open next item^AutoOpenNextItem^',
        From: '^From^from^From^',
        Verify: '^Verify^Verify^Verify^',
        Enable: '^Enable^Enable^Enable^',
        Generate: '^Generate^Generate^Generate^',
        Wait: '^Wait^Please wait...^Wait^',
        InlineCommands: {
            List: {
                Select: '^SelectItem^Select Item^SelectItem^',
                Edit: '^EditItem^Edit Item^EditItem^',
                New: '^NewItem^New Item^NewItem^',
                Duplicate: '^DuplicateItem^Duplicate Item^DuplicateItem^',
            },
            Grid: {
                Select: '^SelectRow^Select Row^SelectRow^',
                Edit: '^EditRow^Edit Row^EditRow^',
                New: '^NewRow^New Row^NewRow^',
                Duplicate: '^DuplicateRow^Duplicate Row^DuplicateRow^',
            }
        },
        DisplayDensity: {
            Label: '^DisplayDensity^Display Density^DisplayDensity^',
            List: {
                Tiny: '^Tiny^Tiny^Tiny^',
                Condensed: '^Condensed^Condensed^Condensed^',
                Compact: '^Compact^Compact^Compact^',
                Comfortable: '^Comfortable^Comfortable^Comfortable^'
            }
        },
        Files: {
            KB: '^FilesKB^KB^FilesKB^',
            MB: '^FilesMB^MB^FilesMB^',
            Bytes: '^FilesBytes^bytes^FilesBytes^',
            Drop: '^FilesDrop^Drop a file here^FilesDrop^',
            DropMany: '^FilesDropMany^Drop files here^FilesDropMany^',
            Tap: '^FilesTap^Tap to select a file^FilesTap^',
            TapMany: '^FilesTapMany^Tap to select files^FilesTapMany^',
            Click: '^FilesClick^Click to select a file^FilesClick^',
            ClickMany: '^FilesClickMany^Click to select files^FilesClickMany^',
            Clear: '^FilesClear^Clear^FilesClear^',
            ClearConfirm: '^FilesClearConfirm^Clear?^FilesClearConfirm^',
            Sign: '^Sign^Sign here^Sign^',
            Cleared: '^FileCleared^Value will be cleared on save^FileCleared^'
        },
        Import: {
            SelectFile: '^ImportSelectFile^Select a data file in CSV, XLS, or XLSX format.^ImportSelectFile^',
            NotSupported: '^ImportNotSupported^Data format of "{0}" is not supported.^ImportNotSupported^',
            NotMatched: '^NotMatched^(not matched)^NotMatched^',
            FileStats: '^ImportFileStats^There are <b>{0}</b> records in the file <b>{1}</b> ready to be processed. Please match the field names.^ImportFileStats^',
            Importing: '^Importing^Importing^Importing^',
            Into: '^Into^into^Into^',
            StartImport: '^StartImport^Start Import^StartImport^',
            InsertingRecords: '^InsertingRecords^Inserting records^InsertingRecords^',
            TestingRecords: '^TestingRecords^Testing records^TestingRecords^',
            ResolvingReferences: '^ResolvingReferences^Resolving references^ResolvingReferences^',
            Complete: '^ImportComplete^complete^ImportComplete^',
            Expected: '^ImportExpected^Expected to complete^ImportExpected^',
            Remaining: '^ImportRemaining^Remaining^ImportRemaining^',
            Done: '^ImportDone^Completed importing^ImportDone^',
            Duplicates: '^ImportDuplicates^Duplicates^ImportDuplicates^'
        },
        Themes: {
            Label: '^Theme^Theme^Theme^',
            Accent: '^Accent^Accent^Accent^',
            List: {
                None: '^None^None^None^',
                Light: '^LightTheme^Light^LightTheme^',
                Dark: '^DarkTheme^Dark^DarkTheme^',
                Aquarium: '^Aquarium^Aquarium^Aquarium^',
                Azure: '^Azure^Azure^Azure^',
                Belltown: '^Belltown^Belltown^Belltown^',
                Berry: '^Berry^Berry^Berry^',
                Bittersweet: '^Bittersweet^Bittersweet^Bittersweet^',
                Cay: '^Cay^Cay^Cay^',
                Citrus: '^Citrus^Citrus^Citrus^',
                Classic: '^Classic^Classic^Classic^',
                Construct: '^Construct^Construct^Construct^',
                Convention: '^Convention^Convention^Convention^',
                DarkKnight: '^DarkKnight^Dark Knight^DarkKnight^',
                Felt: '^Felt^Felt^Felt^',
                Graham: '^Graham^Graham^Graham^',
                Granite: '^Granite^Granite^Granite^',
                Grapello: '^Grapello^Grapello^Grapello^',
                Gravity: '^Gravity^Gravity^Gravity^',
                Lacquer: '^Lacquer^Lacquer^Lacquer^',
                Laminate: '^Laminate^Laminate^Laminate^',
                Lichen: '^Lichen^Lichen^Lichen^',
                Mission: '^Mission^Mission^Mission^',
                Modern: '^Modern^Modern^Modern^',
                ModernRose: '^ModernRose^Modern Rose^ModernRose^',
                Municipal: '^Municipal^Municipal^Municipal^',
                Petal: '^Petal^Petal^Petal^',
                Pinnate: '^Pinnate^Pinnate^Pinnate^',
                Plastic: '^Plastic^Plastic^Plastic^',
                Ricasso: '^Ricasso^Ricasso^Ricasso^',
                Simple: '^Simple^Simple^Simple^',
                Social: '^Social^Social^Social^',
                Summer: '^Summer^Summer^Summer^',
                Vantage: '^Vantage^Vantage^Vantage^',
                Verdant: '^Verdant^Verdant^Verdant^',
                Viewpoint: '^Viewpoint^Viewpoint^Viewpoint^',
                WhiteSmoke: '^WhiteSmoke^White Smoke^WhiteSmoke^',
                Yoshi: '^Yoshi^Yoshi^Yoshi^'
            }
        },
        Transitions: {
            Label: '^Transitions^Transitions^Transitions^',
            List: {
                none: '^TransitionNone^None^TransitionNone^',
                slide: '^TransitionSlide^Slide^TransitionSlide^',
                fade: '^TransitionFade^Fade^TransitionFade^',
                pop: '^TransitionPop^Pop^TransitionPop^',
                flip: '^TransitionFlip^Flip^TransitionFlip^',
                turn: '^TransitionTurn^Turn^TransitionTurn^',
                flow: '^TransitionFlow^Flow^TransitionFlow^',
                slideup: '^TransitionSlideUp^Slide Up^TransitionSlideUp^',
                slidedown: '^TransitionSlideDown^Slide Down^TransitionSlideDown^'
            }
        },
        LabelsInList: {
            Label: '^LabelsInList^Labels In List^LabelsInList^',
            List: {
                DisplayedAbove: '^DisplayedAbove^Displayed Above^DisplayedAbove^',
                DisplayedBelow: '^DisplayedBelow^Displayed Below^DisplayedBelow^'
            }
        },
        InitialListMode: {
            Label: '^InitialListMode^Initial List Mode^InitialListMode^',
            List: {
                SeeAll: '^SeeAll^See All^SeeAll^',
                Summary: '^Summary^Summary^Summary^'
            }
        },
        Dates: {
            SmartDates: '^DatesSmart^Smart Dates^DatesSmart^',
            Yesterday: '^DatesYesterday^Yesterday^DatesYesterday^',
            Last: '^DatesLast^Last^DatesLast^',
            Today: '^DatesToday^Today^DatesToday^',
            OneHour: '^DatesOneHour^an hour ago^DatesOneHour^',
            MinAgo: '^DatesMinAgo^{0} min ago^DatesMinAgo^',
            AMinAgo: '^DatesAMinAgo^a minute ago^DatesAMinAgo^',
            InHour: '^DatesInHour^in an hour^DatesInHour^',
            InMin: '^DatesInMin^in {0} min^DatesInMin^',
            InAMin: '^DatesInAMin^in a minute^DatesInAMin^',
            Now: '^DatesNow^Now^DatesNow^',
            JustNow: '^JustDatesNow^Just now^JustDatesNow^',
            Tomorrow: '^DatesTomorrow^Tomorrow^DatesTomorrow^',
            Next: '^DatesNext^Next^DatesNext^'
        },
        Sync: {
            Uploading: '^Uploading^Uploading {0}...^Uploading^'
        },
        Develop: {
            Tools: '^DevelopTools^Developer Tools^DevelopTools^',
            Explorer: '^DevelopExplorer^Project Explorer^DevelopExplorer^',
            FormLayout: '^DevelopFormLayout^Form Layout^DevelopFormLayout^',
            FormLayoutInstr: '^DevelopFormLayoutInstr^Select screen sizes to be included in the layout.^DevelopFormLayoutInstr^'
        },
        Keyboard: {
            TelHints: {
                Key1: '^TelHints1^ ^TelHints1^',
                Key2: '^TelHints2^abc^TelHints2^',
                Key3: '^TelHints3^def^TelHints3^',
                Key4: '^TelHints4^ghi^TelHints4^',
                Key5: '^TelHints5^jkl^TelHints5^',
                Key6: '^TelHints6^mno^TelHints6^',
                Key7: '^TelHints7^pqrs^TelHints7^',
                Key8: '^TelHints8^tuv^TelHints8^',
                Key9: '^TelHints9^wxyz^TelHints9^'
            }
        }
    };

    _dvr.ODP = {
        Initializing: '^OdpInitializing^Initializing...^OdpInitializing^',
        Status: '^OdpStatus^Status^OdpStatus^',
        Sync: '^OdpSync^Synchronize^OdpSync^',
        Synced: '^OdpSynced^Synchronized^OdpSynced^',
        SyncLong: '^OdpSyncLong^Synchronize to upload changes.^OdpSyncLong^',
        SyncLast: '^OdpSyncLast^Last Sync^OdpSyncLast^',
        Committing: '^OdpCommitting^Uploading transactions...^OdpCommitting^',
        SyncUploadingFiles: '^OdpSyncUploadingFiles^Uploading {0} ...^OdpSyncUploadingFiles^',
        SyncUploadFailed: '^OdpSyncUploadFailed^Failed to upload {0} files.^OdpSyncUploadFailed^',
        UploadingFiles: '^OdpUploadingFiles^Uploading {0} files...^OdpUploadingFiles^',
        UploadFailed: '^OdpUploadFailed^Failed to upload files.^OdpUploadFailed^',
        Pending: '^OdpPending^Pending Changes^OdpPending^',
        DownloadingData: '^OdpDownloadingData^Downloading data for {0}...^OdpDownloadingData^',
        DownloadingBlob: '^OdpDownloadingBlob^Downloading binary data for {0}...^OdpDownloadingBlob^',
        UnableToExec: '^OdpUnableToExec^Unable to execute.^OdpUnableToExec^',
        UnableToProcess: '^OdpUnableToProcess^Unable to process transactions.^OdpUnableToProcess^',
        UnableToSave: '^OdpUnableToSave^Unable to save changes.^OdpUnableToSave^',
        UnableToDelete: '^OdpUnableToDelete^Unable to delete. {1} dependent items in {0}.^OdpUnableToDelete^',
        Save: '^OdpSave^Please save all changes.^OdpSave^',
        SaveAndSync: '^OdpSaveAndSync^Save all changes and choose the Synchronize option in the context menu.^OdpSaveAndSync^',
        OnlineRequired: '^OdpOnlineRequired^Online connection is required.^OdpOnlineRequired^',
        OfflineState: '^OdpOfflineState^You are working in offline mode.^OdpOfflineState^',
        InvalidResponse: '^OdpInvalidResponse^Invalid response from the server.^OdpInvalidResponse^',
        ReconRequired: '^OdpReconRequired^Reconciliation is required^OdpReconRequired^',
        ReconTxDelete: '^OdpReconTxDelete^Delete this change from the log?^OdpReconTxDelete^',
        ReconTxDeleted: '^OdpReconTxDeleted^Deleted first pending transaction in the log.^OdpReconTxDeleted^',
        NotRefreshed: '^OdpNotRefreshed^Data has not been refreshed.^OdpNotRefreshed^',
        LastRefresh: '^OdpLastRefresh^Last refresh: {0}.^OdpLastRefresh^',
        ServerUnavailable: '^OdpServerUnavailable^Application server is not available.^OdpServerUnavailable^',
        Refresh: '^OdpRefresh^Refresh Data^OdpRefresh^',
        RefreshLast: '^OdpRefreshLast^Data Refreshed^OdpRefreshLast^',
        RefreshData: '^OdpRefreshData^Refresh Data^OdpRefreshData^',
        Done: '^OdpDone^Done.^OdpDone^'
    };

    _dvr.Device = {
        Exit: '^Exit^Exit^Exit^',
        DeviceLoginPrompt: '^DeviceLoginPrompt^Please log in to authorize access on this device.^DeviceLoginPrompt^'
    };

    _dvr.TwoFA = {
        Text: '^TwoFaText^2-Factor Authentication^TwoFaText^',
        AuthenticatorApp: '^TwoFaAuthenticatorApp^Authenticator App^TwoFaAuthenticatorApp^',
        VerificationCode: '^TwoFaVerificationCode^Verification Code^TwoFaVerificationCode^',
        Method: '^TwoFaMethod^Method^TwoFaMethod^',
        TrustThisDevice: '^TwoFaTrustThisDevice^Trust this device^TwoFaTrustThisDevice^',
        Consent: '^TwoFaConsent^Consent^TwoFaConsent^',
        EnterPassword: '^TwoFaEnterPassword^Enter your password^TwoFaEnterPassword^',
        Messages: {
            InvalidVerificationCode: '^TwoFaMsgInvalidVerificationCode^Invalid verification code.^TwoFaMsgInvalidVerificationCode^',
            InvalidPassword: '^TwoFaMsgInvalidPassword^Invalid password.^TwoFaMsgInvalidPassword^',
            EnterCode: '^TwoFaMsgEnterCode^Please enter the {0}-digit verification code.^TwoFaMsgEnterCode^',
            YourCode: '^TwoFaMsgYourCode^000000 is your {0} verification code.^TwoFaMsgYourCode^',
            DisableQuestion: '^TwoFaMsgDisableQuestion^Disable two-factor authenticaton?^TwoFaMsgDisableQuestion^',
            Enabled: '^TwoFaMsgEnabled^2-Factor Authentication has been enabled.^TwoFaMsgEnabled^',
            Disabled: '^TwoFaMsgDisabled^2-Factor Authentication has been disabled.^TwoFaMsgDisabled^',
            Changed: '^TwoFaMsgChanged^2-Factor Authentication has been changed.^TwoFaMsgChanged^'
        },
        BackupCode: {
            Text: '^TwoFaBackupCodeText^Backup Code^TwoFaBackupCodeText^',
            Placeholder: '^TwoFaBackupCodePlaceholder^one-time code^TwoFaBackupCodePlaceholder^',
            Footer: '^TwoFaBackupCodeFooter^If you are unable to provide the verification code, then enter the backup code instead.^TwoFaBackupCodeFooter^'
        },
        Actions: {
            GetVerificationCode: '^TwoFaActionsGetVerificationCode^Get Verification Code^TwoFaActionsGetVerificationCode^'
        },
        VerifyVia: {
            email: '^TwoFaVerifyViaEmail^The verification code will be delivered via email.^TwoFaVerifyViaEmail^',
            sms: '^TwoFaVerifyViaSms^The verification code will be delivered via text message.^TwoFaVerifyViaSms^',
            call: '^TwoFaVerifyViaCall^I will receive an automated call on my phone.^TwoFaVerifyViaCall^',
            app: '^TwoFaVerifyViaApp^I will use an authenticator app to get the verification code.^TwoFaVerifyViaApp^'
        },
        Setup: {
            Consent: '^TwoFaSetupConsent^I will enter a verification code after the successful sign in.^TwoFaSetupConsent^',
            Methods: '^TwoFaSetupMethods^Verification Methods^TwoFaSetupMethods^',
            AppConfigScanQrCode: '^TwoFaSetupAppConfigScanQrCode^I have an authenticator app on a mobile device.^TwoFaSetupAppConfigScanQrCode^',
            AppConfigEnterSetupKey: '^TwoFaSetupAppConfigEnterSetupKey^I can\u0027t scan the QR code.^TwoFaSetupAppConfigEnterSetupKey^',
            AppConfigInstallApp: '^TwoFaSetupAppConfigInstallApp^I need help installing authenticator app.^TwoFaSetupAppConfigInstallApp^',
            ScanQrCode: '^TwoFaSetupScanQrCode^Scan the QR code in the app^TwoFaSetupScanQrCode^',
            EnterSetupKey: '^TwoFaSetupEnterSetupKey^Enter the setup key in the app^TwoFaSetupEnterSetupKey^',
            ScanAppQrCode: '^TwoFaSetupScanAppQrCode^Scan the QR code with the camera^TwoFaSetupScanAppQrCode^',
            BackupCodes: {
                Text: '^TwoFaSetupBackupCodesText^Backup Codes^TwoFaSetupBackupCodesText^',
                Footer: '^TwoFaSetupBackupCodesFooter^The one-time use backup codes will let you to sign in if you are unable to provide a verification code.^TwoFaSetupBackupCodesFooter^'
            }
        },
        GetCode: {
            call: '^TwoFaGetCodeCall^Call me at^TwoFaGetCodeCall^',
            sms: '^TwoFaGetCodeSms^Text me at^TwoFaGetCodeSms^',
            email: '^TwoFaGetCodeEmail^Email me to^TwoFaGetCodeEmail^',
            dial: '^TwoFaGetCodeDial^I will call^TwoFaGetCodeDial^'
        },
        CodeSent: {
            call: '^TwoFaCodeSentCall^Call was placed to^TwoFaCodeSentCall^',
            sms: '^TwoFaCodeSentSms^Text message was sent to^TwoFaCodeSentSms^',
            email: '^TwoFaCodeSentEmail^Email was sent to^TwoFaCodeSentEmail^'
        }
    };

    _dvr.OAuth2 = {
        Allow: '^Allow^Allow^Allow^',
        Deny: '^Deny^Deny^Deny^',
        AccountAccess: '^AccountAccess^Account Access^AccountAccess^',
        Connect: '^OAuth2Connect^The app XXXXX by YYYYY would like to connect to your account.^OAuth2Connect^',
        SignedInAs: '^SignedInAs^Signed in as^SignedInAs^',
        SwitchAccount: '^SwitchAccount^Switch Account^SwitchAccount^',
        Continue: '^Continue^Continue^Continue^',
        UseAnotherAccount: '^UseAnotherAccount^Use another account^UseAnotherAccount^',
        ChooseAccMsg: '^ChooseAccMsg^Choose an account to continue to XXXXX^ChooseAccMsg^',
        WantsTo: '^OAuth2WantsTo^XXXX wants to^OAuth2WantsTo^',
        Scopes: {
            profile: '^OAuth2ScopeProfile^XXXX wants to know your last and first name, birthdate, gender, picture, and preferred language^OAuth2ScopeProfile^',
            email: '^OAuth2ScopeEmail^XXXX wants to view your email address^OAuth2ScopeEmail^',
            address: '^OAuth2ScopeAddress^XXXX wants to view your preferred postal address^OAuth2ScopeAddress^',
            phone: '^OAuth2ScopePhone^XXXX wants to view your phone number^OAuth2ScopePhone^',
            offline_access: '^OAuth2ScopeOfflineAccess^XXXX wants to access your data anytime^OAuth2ScopeOfflineAccess^'
        }
    };

    _dvr.Presenters = {
        Charts: {
            Text: '^Charts^Charts^Charts^',
            DataWarning: '^DataWarning^The maximum number of items to process is {0:d}. Please apply a filter to reduce the number of items.^DataWarning^',
            ShowData: '^ShowData^Show Data^ShowData^',
            ShowChart: '^ShowChart^Show Chart^ShowChart^',
            Sizes: {
                Label: '^SizeLabel^Size^SizeLabel^',
                Small: '^Small^Small^Small^',
                Medium: '^Medium^Medium^Medium^',
                Large: '^Large^Large^Large^'
            },
            ChartLabels: {
                By: '^By^by^By^',
                Top: '^Top^top^Top^',
                Other: '^Other^Other^Other^',
                Blank: '^Blank^Blank^Blank^',
                GrandTotals: '^GrandTotals^Grand Totals^GrandTotals^',
                CountOf: '^CountOf^Count of^CountOf^',
                SumOf: '^SumOf^Total of^SumOf^',
                AvgOf: '^AverageOf^Average of^AverageOf^',
                MinOf: '^MinimumOf^Minimum of^MinimumOf^',
                MaxOf: '^MaximumOf^Maximum of^MaximumOf^',
                Quarter: '^Quarter^Quarter^Quarter^',
                Week: '^Week^Week^Week^'
            }
        },
        Calendar: {
            Text: '^Calendar^Calendar^Calendar^',
            Today: '^Today^Today^Today^',
            Noon: '^Noon^Noon^Noon^',
            Year: '^Year^Year^Year^',
            Month: '^Month^Month^Month^',
            Week: '^Week^Week^Week^',
            Day: '^Day^Day^Day^',
            Agenda: '^Agenda^Agenda^Agenda^',
            Sync: '^Sync^Sync^Sync^',
            Less: '^Less^Less^Less^'
        }
    };

    // membership resources

    var _mr = Web.MembershipResources = {};

    _mr.Bar = {
        LoginLink: '^LoginLink^Login^LoginLink^',
        LoginText: ' ^ToThisWebsite^to this website^ToThisWebsite^',
        HelpLink: '^Help^Help^Help^',
        UserName: '^UserName^User Name^UserName^:',
        Password: '^Password^Password^Password^:',
        RememberMe: '^RememberMe^Remember me next time^RememberMe^',
        ForgotPassword: '^ForgotYourPassword^Forgot your password?^ForgotYourPassword^',
        SignUp: '^SignUpNow^Sign up now^SignUpNow^',
        LoginButton: '^LoginButton^Login^LoginButton^',
        MyAccount: '^MyAccount^My Account^MyAccount^',
        LogoutLink: '^Logout^Logout^Logout^',
        HelpCloseButton: '^HelpClose^Close^HelpClose^',
        HelpFullScreenButton: '^HelpFullScreen^Full Screen^HelpFullScreen^',
        UserIdle: '^IdleUser^Are you still there? Please login again.^IdleUser^',
        History: '^History^History^History^',
        Permalink: '^Permalink^Permalink^Permalink^',
        AddToFavorites: '^AddToFavorites^Add to Favorites^AddToFavorites^',
        RotateHistory: '^Rotate^Rotate^Rotate^',
        Welcome: '^Welcome1^Welcome^Welcome1^ <b>{0}</b>, ^Welcome2^Today is^Welcome2^ {1:D}',
        ChangeLanguageToolTip: '^ChangeYourLanguage^Change your language^ChangeYourLanguage^',
        PermalinkToolTip: '^PermalinkToolTip^Create a permanent link for selected record^PermalinkToolTip^',
        HistoryToolTip: '^HistoryToolTip^View history of previously selected records^HistoryToolTip^',
        AutoDetectLanguageOption: 'Auto Detect'
    };

    _mr.Messages = {
        InvalidUserNameAndPassword: '^InvalidUserNameAndPassword^Your user name and password are not valid.^InvalidUserNameAndPassword^',
        BlankUserName: '^BlankUserName^User name cannot be blank.^BlankUserName^',
        BlankPassword: '^BlankPassword^Password cannot be blank.^BlankPassword^',
        PermalinkUnavailable: '^PermalinkUnavailable^Permalink is not available. Please select a record.^PermalinkUnavailable^',
        HistoryUnavailable: '^HistoryUnavailable^History is not available.^HistoryUnavailable^'
    };

    _mr.Manager = {
        UsersTab: '^UsersTab^Users^UsersTab^',
        RolesTab: '^RolesTab^Roles^RolesTab^',
        UsersInRole: '^UsersInRole^Users in Role^UsersInRole^'
    };

    if (typeof Sys !== 'undefined') Sys.Application.notifyScriptLoaded();
})();