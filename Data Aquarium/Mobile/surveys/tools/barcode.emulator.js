({
    cache: false,
    text: 'Emulator',
    text2: 'Barcodes, QR Codes, RFID ',
    description: 'Design application responsed to the barcode, QR code, and RFID input.',
    questions: [
        {
            name: 'Name',
            placeholder: 'The name of this automation.',
            tooltip: 'The name of the barcode automation.',
            options: {
                spellCheck: false
            }
        },
        {
            name: 'Execute', rows: 5, required: true,
            placeholder: 'Enter automation instructions.',
            tooltip: 'A list of Touch UI automation commands.',
            options: {
                focus2: 'auto',
                spellCheck: false,
                selectOnFocus: false
            }
        },
        {
            name: 'UseIdentifiers', text: false, value: null, placeholder: 'text identifiers',
            items: {
                style: 'DropDownList',
                list: [
                    { value: null, text: 'text identifiers' },
                    { value: true, text: 'programmatic identifiers' }
                ]
            },
            options: {
                lookup: {
                    openOnTap: true,
                    nullValue: false
                }
            },
            visibleWhen: '!($row.Execute && $row.Execute.match(/\<.+\>/))'
        },
        {
            name: 'Command',
            text: false,
            placeholder: '(add automation command)',
            causesCalculate: true,
            tooltip: 'Add an automation command to execute.',
            items: {
                style: 'DropDownList',
                list: $app.input.barcode.commands(true)
            },
            options: {
                lookup: {
                    openOnTap: true,
                    nullValue: false
                    //autoCompleteAnywhere: true
                }
            },
            visibleWhen: '!($row.Execute && $row.Execute.match(/\<.+\>/)) && $row.UseIdentifiers'
        },
        {
            name: 'TextCommand',
            text: false,
            placeholder: '(add automation command)',
            causesCalculate: true,
            tooltip: 'Add an automation command to execute.',
            items: {
                style: 'DropDownList',
                list: $app.input.barcode.commands(false)
            },
            options: {
                lookup: {
                    openOnTap: true,
                    nullValue: false
                    //autoCompleteAnywhere: true
                }
            },
            visibleWhen: '!($row.Execute && $row.Execute.match(/\<.+\>/)) && !$row.UseIdentifiers'
        },
        {
            name: 'WhenController', text: 'When', placeholder: 'controller', tooltip: 'The text or name of the data controller.'
        },
        {
            name: 'WhenViewId', text: false, placeholder: 'view', visibleWhen: '$row.WhenController!=null', tooltip: 'The text or ID of the data controller view.'
        },
        {
            name: 'WhenPage', text: false, placeholder: 'page', tooltip: 'The title or name of the page.'
        },
        {
            name: 'WhenBarcode', text: false, placeholder: 'pattern of code', tooltip: 'This regular expression must match the text of the scanned code.'
        },
        {
            name: 'WhenCount', type: 'Int32', text: false, placeholder: 'number of codes', tooltip: 'The minimal number of scanned codes rquired for this automation.'
        },
        {
            name: 'SampleCodes', rows: 3, required: true,
            placeholder: 'Scan or enter a few sample barcodes.',
            tooltip: 'Sample barcodes, QR codes, or RFID.',
            options: {
                spellCheck: false,
                selectOnFocus: false
            }
        }
        //{
        //    name: 'NewContent',
        //    value: '$custom',
        //    required: true,
        //    items: {
        //        style: 'ListBox',
        //        list: $app.cms.items()
        //    }
        //}

    ],
    options: {
        materialIcon: 'center_focus_strong',
        modal: {
            fitContent: true,
            max: 'xs',
            always: true,
            autoGrow: true
        },
        contentStub: false
    },
    calculate: 'barcodeemulatorcalculate.app',
    submit: 'barcodeemulatorsubmit.app',
    submitText: 'Run'
});