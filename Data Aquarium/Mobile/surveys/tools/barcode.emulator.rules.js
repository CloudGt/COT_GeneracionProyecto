/*eslint eqeqeq: ["error", "smart"]*/
(function () {
    var commandList = [
        { scopeId: '@<PageName>', scopeText: '<Page Label>', suffix: 'navigate', text: 'Select a page.' },
        { scopeId: '@<FieldName>', scopeText: '<Field Label>', suffix: 'find', text: 'Find item with the field value equal to the code.' },
        { scopeId: '@<FieldName>', scopeText: '<Field Label>', suffix: 'filter', text: 'Filter item with the field value equal to the code.' },
        { scopeId: '@<FieldName>', scopeText: '<Field Label>', suffix: 'select', text: 'Select item with the field value equal to the code.' }
    ];

    $(document).on('barcodescan.app', function (e) {
        var dataView = $app.touch.dataView(),
            data, sampleCodes;
        if (dataView && dataView._controller === 'tools_barcode_emulator' && !$app.input.barcode().calibrating) {
            data = dataView.data();
            sampleCodes = data.SampleCodes == null ? e.text : data.SampleCodes + '\n' + e.text;
            $app.input.execute({ values: { SampleCodes: sampleCodes } });
            $app.touch.notify({ text: 'New sample: ' + e.text, force: true });
            return false;

        }
    }).on('barcodeemulatorsubmit.app', function (e) {
        var dataView = e.dataView;
        dataView.tag('discard-changes-prompt-none');
    }).on('barcodeemulatorcalculate.app', function (e) {
        var data = e.dataView.data(),
            command = data.Command || data.TextCommand;
        if (command) {
            $app.input.execute({
                values: {
                    Execute: data.Execute == null ? command : data.Execute + '\n' + command,
                    Command: null,
                    TextCommand: null
                }
            });
            $app.input.focus({ field: 'Execute' });
        }
    }).on('afterfocus.input.app', '[data-input-container="tools-barcode-emulator"] [data-field="Execute"]', function (e) {
        var execute = e.inputElement.val(),
            template;
        if (execute) {
            template = execute.match(/(\<(.+)\>)/);
            if (template)
                e.inputElement[0].setSelectionRange(template.index, template.index + template[1].length);
        }
    });

    $app.input.barcode.commands = function (useIdentifiers) {
        var result = [];
        commandList.forEach(function (c) {
            result.push({ value: c[useIdentifiers ? 'scopeId' : 'scopeText'] + (c.suffix ? ' : ' + c.suffix : ''), text: c.text });
        });
        return result;
    };

})();