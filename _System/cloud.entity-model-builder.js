/*eslint eqeqeq: ["error", "smart"]*/
/*!
* Cloud On Time - Model Builder
* Copyright 2008-2020 Code On Time LLC; Licensed MIT; http://codeontime.com/license
*/

// SVG resources http://tutorials.jenkov.com/svg/marker-element.html

(function () {
    var _window = window,
        $window = $(_window),
        $body = $(document.body),
        nsSVG = 'http://www.w3.org/2000/svg',
        diagramMargin = 20,
        tableSpacing = 60,
        mouseX, mouseY,
        tooltipDelay = 500,
        tooltip, tooltipTimeout, keepTooltip,
        addColumnHoverTimeout,
        highlightTimeout,
        trackingTimeout,
        scrollTimeout,
        resizeTimeout,
        scrollbarInfo,
        pendingDragEvent,
        dependencyTimeout,
        dragEvent, dragScrollInterval, dragScrollDistance = 30, skipClickAfterDrop,
        preventMouseEnter;

    var dummy = $('<div class="app-scrollbar-info"><div></div></div>').appendTo($body);
    scrollbarInfo = { width: dummy[0].offsetWidth - dummy[0].clientWidth, height: dummy[0].offsetWidth - dummy[0].clientWidth };
    dummy.remove();

    function closeListPopup() {
        if ($('.cloud-model-menu').length)
            $('.cloud-model-modal-background').trigger('click');
    }

    function allowContextMenu(event) {
        return !$(event.target).closest('[data-input]').find('.cloud-model-input').length;
    }

    function allowDragging(event) {
        return event.which === 1 && allowContextMenu(event);
    }

    function htmlEncode(s) {
        if (s != null && typeof s != 'string')
            s = s.toString();
        return s ? s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;') : s;
    };

    function isNullOrEmpty(s) {
        return s == null || !s.length;
    };

    function showTooltip(x, y, text) {
        var lines = text.split(/\n/g),
            tbl;
        y += 23;
        if (!tooltip)
            tooltip = $('<div class="cloud-tooltip"></div>').appendTo(document.body).hide();
        tooltip.text(text);
        if (lines)
            if (text.match(/\t/)) {
                tbl = $('<table/>').appendTo(tooltip.empty());
                $(lines).each(function () {
                    var cells = this.split(/\t/g),
                        tr = $('<tr/>').appendTo(tbl);
                    $(cells).each(function () {
                        var s = this,
                            td = $('<td/>').appendTo(tr);
                        if (s.match(/\"/))
                            td.html(s.replace(/"(.+?)"/g, '<b>$1</b>'));
                        else
                            td.text(s);
                    });
                });
            }
            else {
                tooltip.empty();
                $(lines).each(function (index) {
                    var s = this;
                    if (index)
                        $('<br/>').appendTo(tooltip);
                    if (s.match(/\"/))
                        s = s.replace(/"(.+?)"/g, '<b>$1</b>');
                    $('<span/>').appendTo(tooltip).html(s);
                });
            }
        tooltip.css({ left: 0, top: 0 }).show();
        if ($window.scrollLeft() + x + tooltip.outerWidth() >= $window.scrollLeft() + $window.width())
            x = $window.scrollLeft() + $window.width() - tooltip.outerWidth() - 16;
        if ($window.scrollTop() + y + tooltip.outerHeight() >= $window.scrollTop() + $window.height())
            y = mouseY - 5 - tooltip.outerHeight();
        tooltip.css({ 'left': x - 5, 'top': y });
    }

    // showListPopup({ anchor: that, iconPos: 'left', title: 'Glyphicon', items: items });
    function listPopup(options) {
        var background = $('<div class="cloud-model-modal-background cloud-model-noselect"></div>').appendTo($body),
            popup = $('<div class="cloud-model-menu"></div>').appendTo($body),
            list = $('<ul/>').appendTo(popup),
            arrow = $('<div class="cloud-model-popup-arrow"></div>').insertBefore(list),
            popupWidth, popupHeight, deltaX, deltaY;
        if (options.title)
            $('<h1/>').insertBefore(list).text(options.title);
        else
            popup.addClass('cloud-model-menu-notitle');
        $(options.items).each(function () {
            var item = this,
                li = $('<li/>').appendTo(list);
            li.text(item.text).data('item', item);
        });

        function closePopup() {
            list.off().find('li').removeData();
            popup.remove();
            background.off().remove();
            $('.cloud-model-inspected').removeClass('cloud-model-inspected');
            svgRemoveClass('.cloud-model-inspected', 'cloud-model-inspected');
        }

        popup.on('contextmenu', function () {
            return false;
        });

        background.on('click contextmenu', function () {
            setTimeout(closePopup, 10);
            return false;
        });
        list.on('click', function (event) {
            var li = $(event.target).closest('li'),
                item = li.data('item');
            setTimeout(function () {
                if (item) {
                    closePopup();
                    if (item.callback)
                        item.callback(item.context);
                }
            }, 10);
        });
        popupWidth = popup.outerWidth(true);
        if (options.hideArrow)
            options.y -= arrow.outerHeight(true) + 2;
        else
            options.x -= popupWidth / 2;
        if (options.x < 0) {
            deltaX = -options.x;
            options.x = 1;
        }
        popupHeight = popup.outerHeight(true);
        if (options.x + popupWidth > $window.width() - 1) {
            deltaX = options.x - ($window.width() - popupWidth - 1);
            options.x -= deltaX;
            deltaX = -1 * deltaX;
        }
        if (options.y + popupHeight > $window.height() - 1) {
            deltaY = popupHeight;
            if (options.hideArrow)
                deltaY -= arrow.outerHeight() - 2;
            else
                popup.addClass('cloud-model-menu-above');
            options.y -= deltaY;
            deltaY = -1 * deltaY;
        }
        else
            options.y++;
        if (options.y < 0) {
            deltaY = -options.y;
            options.y = 1;
            arrow.remove();
        }
        if (options.hideArrow)
            arrow.remove();

        popup.css({ left: options.x, top: options.y });
        if (arrow.length)
            arrow.css({ marginLeft: parseInt(arrow.css('marginLeft')) - deltaX });
    }

    function clearHtmlSelection(delay) {
        var result = true;
        if (delay)
            setTimeout(function () {
                clearHtmlSelection();
            }, 5);
        else
            try {
                if (_window.getSelection) {
                    var range = _window.getSelection();
                    if (range && range.rangeCount > 0)
                        range.removeAllRanges();
                }
                else if (document.selection)
                    document.selection.empty();
            }
            catch (ex) {
                result = false;
            }
        return result;
    }

    function builderInstance() {
        return $('.cloud-model-diagram').data('builder');
    }


    function refreshFormulaPanel() {
        $('.cloud-model-panel-formula:visible').each(function () {
            var editor = $(this).data('editor');
            editor.refresh();
        });
    }

    _window.modelBuilder_moveField = function (field, targetField, position) {
        var builder = builderInstance();
        if (position == 'before')
            builder.moveFieldBefore(field, targetField);
        else
            builder.moveFieldAfter(field, targetField);
    }

    _window.modelBuilder_focusDiagram = function () {
        $('.cloud-model-container').focus();
    }

    _window.modelBuilder_scaleDiagram = function (scale) {
        builderInstance().scale(scale)
        modelBuilder_focusDiagram();
    }

    _window.modelBuilder_entityIdentityFieldName = function () {
        var builder = builderInstance(),
            fieldName, hasPK;
        builder._fieldGrid._tableBody.find('[data-column="Spec"]').each(function (index) {
            var td = $(this);
            if (td.text().match(/\bV?PK\b/i))
                hasPK = true;
            else {
                fieldName = td.parent().find('[data-column="FieldName"]').text();
                return false;
            }
        });
        return hasPK ? fieldName : null;
    }

    _window.modelBuilder_JsonDataModel = function () {
        return JSON.stringify(builderInstance().finalDataModel());
    }

    _window.modelBuilder_hideTooltip = function () {
        $(tooltip).hide();
        clearTimeout(tooltipTimeout);
    }

    _window.modelBuilder_pauseMouseEvents = function () {
        preventMouseEnter = true;
        modelBuilder_hideTooltip();
        setTimeout(function () {
            preventMouseEnter = false;
        }, 500);
    }

    _window.modelBuilder_arrangeTables = function () {
        builderInstance().arrange();
    }

    _window.modelBuilder_addTable = function (enable) {
        var builder = builderInstance();
        return builder ? builder.addTable(enable) : false;
    }

    _window.modelBuilder_formulaField = function (enable) {
        var builder = builderInstance();
        return builder ? builder.formulaField(enable) : false;
    }

    _window.modelBuilder_whereClause = function (enable) {
        var builder = builderInstance();
        return builder ? (arguments.length ? builder.whereClause(enable) : builder.whereClause()) : false;
    }

    _window.modelBuilder_masterDetail = function (enable) {
        var builder = builderInstance();
        return builder ? builder.masterDetail(enable) : false;
    }


    function highlightField(fieldName, container) {
        $('.cloud-model-highlight').removeClass('cloud-model-highlight');
        if (arguments.length) {
            var selector = (container || builderInstance()._fieldGrid)._grid.find('[data-field="' + fieldName + '"] [data-column="FieldName"]').addClass('cloud-model-highlight');
            clearTimeout(highlightTimeout);
            highlightTimeout = setTimeout(function () {
                selector.removeClass('cloud-model-highlight');
            }, 1500);
        }
    }

    function toPhysicalTableName(schema, name) {
        var s = schema;
        if (s)
            s += '.';
        else
            s = '';
        s += name;
        return s;
    }

    function toDataType(column, includeExtendedInfo) {
        var columnType = column.type;
        if (column.length != null && column.length != 1073741823 && column.length != 2147483647)
            columnType += '(' + column.length + ')';
        if (column.identity && includeExtendedInfo != false)
            columnType += ' identity';
        return columnType;
    }

    function toFormat(column) {
        var columnType = column.type,
            dataType = column.dataType;
        if (columnType.match(/money/i) || !dataType.match(/date|string/i) && column.name.match(/price|cost|salary/i))
            return 'c';
        if (dataType == 'DateTime')
            return 'g';
        return null;
    }

    function svgAddClass(selector, className) {
        $(selector).each(function () {
            var element = this,
                classList = element.getAttribute('class').split(/\s+/g);
            if (classList.indexOf(className) == -1) {
                classList.push(className);
                element.setAttribute('class', classList.join(' '));
            }
        });
    }

    function toggleOptionalTableColumns(table, enforceMaxVisibileCount) {
        var maxVisibleColumns = 0,
            builder = builderInstance(),
            container,
            hiddenColumnCount,
            toggleButton,
            hiddenColumns = table.find('.cloud-model-column-hidden'),
            selectedColumns = table.find('.cloud-model-column-selected'),
            minimalOptionalColumnCount = enforceMaxVisibileCount && selectedColumns.length == 1 ? maxVisibleColumns : 0,
            optionalColumns = table.find('.cloud-model-column:not(.cloud-model-column-selected):not(.cloud-model-column-pk):not(.cloud-model-column-fk)');
        if (optionalColumns.length > minimalOptionalColumnCount) {
            // show at least "+2..."
            hiddenColumnCount = selectedColumns.length > 1 ? optionalColumns.length : Math.min(optionalColumns.length, optionalColumns.length - maxVisibleColumns);
            if (hiddenColumnCount <= 0)
                hiddenColumnCount = optionalColumns.length;
            if (enforceMaxVisibileCount && hiddenColumnCount == 1)
                return;
            // create footer
            if (enforceMaxVisibileCount)
                $('<tr class="cloud-model-column-visibility"><td></td><td colspan="2"><span class="cloud-model-column-visibility-toggle"></span></td></tr>').appendTo(table);
            toggleButton = table.find('.cloud-model-column-visibility-toggle');
            if (hiddenColumns.length) {
                hiddenColumns.removeClass('cloud-model-column-hidden');
                toggleButton.text('less').attr('title', 'Show Less Columns');
            }
            else if (toggleButton.length) {
                optionalColumns.slice(-hiddenColumnCount).addClass('cloud-model-column-hidden');
                toggleButton.text('+' + hiddenColumnCount + ' more').attr('title', 'Show More Columns');;
            }
        }
        else if (!enforceMaxVisibileCount) {
            hiddenColumns.removeClass('cloud-model-column-hidden');
            table.find('.cloud-model-column-visibility').remove();
        }
        if (!enforceMaxVisibileCount) {
            modelBuilder_hideTooltip();
            container = builder._diagram.closest('.cloud-model-container');
            builder.diagramHeight(container.scrollTop() + table.offset().top + table.outerHeight() - container.offset().top + diagramMargin);
            requestAnimationFrame(function () {
                builder.scale(false);
                builder.updateConnectors();
                builder.scale(true);
            });
        }
    }

    function svgRemoveClass(selector, className) {
        $(selector).each(function () {
            var element = this,
                classList = element.getAttribute('class').split(/\s+/g),
                index = classList.indexOf(className);
            if (index != -1) {
                classList.splice(index, 1);
                element.setAttribute('class', classList.join(' '));
            }
        });
    }

    function svg(options) {
        var element,
            existing;
        if (options) {
            element = options['element'];
            if (element)
                existing = true;
            else {
                element = options['type'];
                if (element)
                    element = document.createElementNS(nsSVG, element);
            }
            if (element)
                for (key in options) {
                    switch (key) {
                        case 'type':
                        case 'element':
                            break;
                        case 'parent':
                            options.parent.appendChild(element);
                            break;
                        case 'children':
                            var children = options[key];
                            if (children)
                                $(children).each(function () {
                                    var childOptions = this,
                                        child;
                                    childOptions.parent = element;
                                    child = svg(childOptions);
                                    element.appendChild(child);
                                });
                            break;
                        default:
                            element.setAttribute(key, options[key]);
                            break;
                    }
                }
        }
        if (existing)
            element.parentNode.insertBefore(element, element);
        return element;
    }

    function revealAllDependencies() {
        clearTimeout(dependencyTimeout);
        if ($('.cloud-model-has-dependency').length) {
            svgRemoveClass('.cloud-model-connector.cloud-model-dependency', 'cloud-model-dependency');
            $('.cloud-model-has-dependency').removeClass('cloud-model-has-dependency');
            $('.cloud-model-dependency').removeClass('cloud-model-dependency');
        }
    }

    function hideTracking() {
        clearTimeout(trackingTimeout);
        $('.cloud-model-dependency,.cloud-model-tracking').removeClass('cloud-model-dependency cloud-model-tracking');
    }

    _window.modelBuilder_showFieldOnDiagram = function (elem) {
        var builder,
            fieldGrid,
            tr, trOffset,
            row, rowIndex;
        // elem = elem.text(); /* simulate selection field name */
        if (typeof elem == 'string') {
            hideTracking();
            builder = builderInstance();
            fieldGrid = builder._fieldGrid;
            rowIndex = fieldGrid.findRowIndex({ FieldName: elem });
            elem = fieldGrid._fixedTableBody.find('tr:eq(' + rowIndex + ') [data-column="FieldName"]');
            row = fieldGrid._options.rows[rowIndex];
            if (!$('.cloud-model-inspected').length)
                builder.scrollFieldIntoView(row.SqlFormula ? { fieldName: row.FieldName } : { tableAlias: row.TableAlias, tableName: row.TableName, columnName: row.ColumnName });
        }
        fieldGrid = elem.closest('.cloud-grid');
        if (fieldGrid.length) {
            var pos = elem.offset(),
                scrollable,
                scrollableOffset,
                scrollableHeight,
                trOffset,
                trBounds,
                newScrollLeft,
                newScrollTop,
                fk;
            if (!builder)
                builder = fieldGrid.closest('.cloud-model-list').data('builder');
            row = builder._fieldGrid._options.rows[elem.parent().index()];
            fk = row['TableAlias'];
            tr = builder._diagram.find((fk != builder._model.alias ? '[data-foreign-key="' + fk + '"]' : '.cloud-model-table-base') + ' [data-column="' + row['ColumnName'] + '"]');
            if (tr.length) {
                scrollable = tr.closest('.cloud-model-container');
                scrollableOffset = scrollable.offset();
                scrollableHeight = scrollable.height();
                scrollableWidth = scrollable.width();
                trOffset = tr.offset();
                trBounds = tr[0].getBoundingClientRect();
                // show tracking outline outline 
                tr.addClass('cloud-model-tracking');
                builder._fieldGrid._fixedTableBody.find('tr:eq(' + elem.closest('tr').index() + ')').addClass('cloud-model-dependency');
                builder._fieldGrid._tableBody.find('tr:eq(' + elem.closest('tr').index() + ')').addClass('cloud-model-dependency');
                //elem.addClass('cloud-model-tracking');
                if (trOffset.top < scrollableOffset.top || trOffset.top + trBounds.height > scrollableOffset.top + scrollableHeight)
                    newScrollTop = scrollable.scrollTop() + trOffset.top - scrollableOffset.top - (scrollableHeight - trBounds.height) / 2;
                if (trOffset.left < scrollableOffset.left || trOffset.left + trBounds.width > scrollableOffset.left + scrollableWidth)
                    newScrollLeft = scrollable.scrollLeft() + trOffset.left - scrollableOffset.left - (scrollableWidth - trBounds.width) / 2;
                if (newScrollLeft != null || newScrollTop != null)
                    scrollable.animate({ scrollTop: newScrollTop, scrollLeft: newScrollLeft }, { duration: 300, queue: false });
            }
        }
    }

    //$(document).on('dblclick', function () {
    //    modelBuilder_JsonDataModel();
    //});
    $(document).on('contextmenu', '.cloud-model-container,.cloud-model-list', function (event) {
        if (!allowContextMenu(event)) return;
        pendingDragEvent = null;
        builderInstance().showContextMenu(event);
        return false;
    }).on('mousemove', function (event) {
        if (event.pageX != null) {
            mouseX = event.pageX;
            mouseY = event.pageY;
        }
        if (pendingDragEvent && (Math.abs(mouseX - pendingDragEvent.x) > 5 || Math.abs(mouseY - pendingDragEvent.y))) {
            dragEvent = pendingDragEvent;
            dragEvent.element.addClass('cloud-model-dragging');
            pendingDragEvent = null;
            hideTracking();
            revealAllDependencies();
            modelBuilder_hideTooltip();
        }
        if (!dragEvent) return;
        // auto-scroll 
        if (event.pageX != null) {
            clearTimeout(dragScrollInterval);
            var scrollContainer = $(dragEvent.element).closest('.cloud-model-container,.cloud-grid'),
                scrollContainerOffset, deltaX = 0, deltaY = 0;
            if (scrollContainer.length) {
                scrollContainerOffset = scrollContainer.offset();
                if (mouseX - scrollContainerOffset.left <= dragScrollDistance)
                    deltaX = -dragScrollDistance;
                if (scrollContainerOffset.left + scrollContainer.width() - mouseX < dragScrollDistance)
                    deltaX = dragScrollDistance;
                if (mouseY - scrollContainerOffset.top <= dragScrollDistance)
                    deltaY = -dragScrollDistance;
                if (scrollContainerOffset.top + scrollContainer.height() - mouseY < dragScrollDistance)
                    deltaY = dragScrollDistance;
                if (deltaX != 0 || deltaY != 0) {
                    dragScrollInterval = setInterval(function () {
                        var scrollLeft = scrollContainer.scrollLeft(),
                            scrollTop = scrollContainer.scrollTop();
                        if (scrollLeft + deltaX < 0)
                            deltaX = scrollLeft;
                        if (scrollTop + deltaY < 0)
                            deltaY = 0;
                        if (deltaX != scrollTop)
                            dragEvent.offsetX -= deltaX;
                        if (deltaY != 0)
                            dragEvent.offsetY -= deltaY;
                        if (deltaX != 0 || deltaY != 0)
                            $(document).trigger('mousemove');
                        if (deltaX != 0)
                            scrollContainer.scrollLeft(scrollLeft + deltaX);
                        if (deltaY != 0)
                            scrollContainer.scrollTop(scrollTop + deltaY);
                    }, 100);
                }
            }
        }
        // drag divider
        if (dragEvent.type == 'divider') {
            event.preventDefault();
            var newGridHeight = dragEvent.canceled ? dragEvent.originalY : ((event.originalEvent ? event.originalEvent.pageY : 10000) - 17 - 2),
                windowHeight = $window.height(),
                grid,
                newDividerTop,
                divider;
            if (newGridHeight < 101)
                newGridHeight = 101;
            else if (windowHeight - newGridHeight < 150)
                newGridHeight = windowHeight - 150;
            grid = dragEvent.data.css('height', newGridHeight);
            newDividerTop = grid.offset().top + grid.outerHeight(true);
            divider = dragEvent.element.css('top', newDividerTop);
            dragEvent.element.next().css('top', newDividerTop + divider.outerHeight(true));
            grid.parent().find('.cloud-model-panel').height(grid.outerHeight(true));
            refreshFormulaPanel();
        }
        // drag model table
        if (dragEvent.type == 'table') {
            event.preventDefault();
            event.stopPropagation();
            var builder = builderInstance(),
                ratio = builder._scaleRatio;
            if (ratio != 1)
                builder.scale(false);
            var
                table = dragEvent.element,
                fk = builder._foreignKeyMap[table.attr('data-foreign-key')],
                newX = mouseX - dragEvent.data.left - dragEvent.offsetX,
                newY = mouseY - dragEvent.data.top - dragEvent.offsetY,
                newDiagramWidth = Math.ceil(newX / ratio + table.outerWidth() + diagramMargin),
                newDiagramHeight = Math.ceil(newY / ratio + table.outerHeight() + diagramMargin);
            if (dragEvent.canceled) {
                table.css({ left: dragEvent.originalX / ratio, top: dragEvent.originalY / ratio });
                table.closest('.cloud-model-container').scrollLeft(dragEvent.originalScrollLeft).scrollTop(dragEvent.originalScrollTop);
            }
            else {
                builder.diagramWidth(newDiagramWidth);
                //if (newDiagramRight > builder._right) {
                //    builder._right = newDiagramRight;
                //    builder._diagram.width(newDiagramRight);
                //    svg({
                //        element: builder._canvas,
                //        width: newDiagramRight
                //    });
                //}
                builder.diagramHeight(newDiagramHeight);
                //if (newDiagramBottom > builder._bottom) {
                //    builder._bottom = newDiagramBottom;
                //    builder._diagram.height(newDiagramBottom);
                //    svg({
                //        element: builder._canvas,
                //        height: newDiagramBottom
                //    });
                //}
                newX /= ratio;
                newY /= ratio;
                table.css({ left: newX, top: newY });
                if (fk) {
                    fk.x = newX;
                    fk.y = newY;
                }
                else {
                    builder._model.x = newX;
                    builder._model.y = newY;
                }
            }
            builder.updateConnectors([table.attr('data-foreign-key') || '']);
            if (ratio != 1)
                builder.scale(true)
        };
    }).on('mouseup', function (event) {
        pendingDragEvent = null;
        if (!dragEvent) return;
        var dropped;
        if (dragEvent.type == 'divider') {
            preventMouseEnter = false;
            dropped = true;
            $('.cloud-model-container svg').css('visibility', '');
        }
        if (dragEvent.type == 'table')
            dropped = true;
        if (dropped) {
            event.preventDefault();
            skipClickAfterDrop = true;
            setTimeout(function () {
                skipClickAfterDrop = false;
            }, 100);
        }
        $(document).trigger('dragend');
    }).on('keypress', function (event) {
        var escapeKey = event.which == 27;
        if (escapeKey)
            closeListPopup();
        if (!dragEvent) return;
        if (escapeKey) {
            dragEvent.canceled = true;
            $(document).trigger('mousemove', event).trigger('mouseup', event);
            event.preventDefault();
        }
    }).on('click', '.cloud-model-table-list li', function (event) {
        var target = $(event.target).closest('li'),
            tableInfo = { name: target.attr('data-table'), schema: target.attr('data-schema') };
        event.preventDefault();
        setTimeout(function () {
            builderInstance().addTable(tableInfo);
        });

    }).on('click', '.cloud-model-column-name', function (event) {
        modelBuilder_hideTooltip();
        var target = $(event.target),
            columnRow = target.closest('tr'),
            input = $(this).find(':input'),
            newState = input.prop('checked'),
            builder = columnRow.closest('.cloud-model-diagram').data('builder'),
            table = columnRow.closest('.cloud-model-table'),
            foreignKey = table.attr('data-foreign-key'),
            column = columnRow.attr('data-column'),
            connectors,
            rowOptions = {
                columnName: column,
                tableAlias: foreignKey,
                tableName: table.attr('data-table'),
                schema: table.attr('data-schema')
            };
        if (target.is(':input'))
            newState = input.prop('checked');
        else
            newState = !newState;
        setTimeout(function () {
            if (newState)
                builder.addField(rowOptions);
            else
                builder.removeField(rowOptions);
        }, 10);
    }).on('click', '.cloud-model-column-visibility-toggle', function (event) {
        setTimeout(function () {
            toggleOptionalTableColumns($(event.target).closest('.cloud-model-table'));
        }, 100);
    }).on('mouseenter mousemove', '[title]', function (event, delay) {
        if (dragEvent) return;
        var elem = $(this),
            title = elem.attr('title'),
            originalMouseX = mouseX,
            originalMouseY = mouseY;
        if (!title) return;
        if (preventMouseEnter) {
            if (title) {
                elem.attr('title', null);
                setTimeout(function () {
                    elem.attr('title', title);
                }, 1000);
            }
            return;
        }
        elem.attr('title', '').data('title', title);
        clearTimeout(tooltipTimeout);
        tooltipTimeout = setTimeout(function () {
            var pos = elem.offset();
            if ((elem[0].namespaceURI == nsSVG && Math.abs(originalMouseX - mouseX) <= 11 && Math.abs(originalMouseY - mouseY) <= 11) || (mouseX >= pos.left && mouseX < (pos.left + elem.outerWidth(true)) && mouseY >= pos.top && (mouseY < pos.top + elem.outerHeight(true)))) {
                showTooltip(mouseX, mouseY, title);
                // show dependencies on diagram
                var diagram = elem.closest('.cloud-model-diagram'),
                    builder = diagram.data('builder'),
                    dataConnector = elem.attr('data-connector'),
                    dataConnectorForeignKey,
                    parentTable,
                    childTable;


                if (dataConnector) {
                    revealAllDependencies();
                    dataConnectorForeignKey = builder._foreignKeyMap[dataConnector],
                        parentTable = diagram.find('[data-foreign-key="' + dataConnector + '"]');
                    childTable = dataConnectorForeignKey.baseForeignKey ?
                        diagram.find('[data-table][data-foreign-key="' + dataConnectorForeignKey.baseForeignKey + '"]') :
                        diagram.find('[data-table="' + builder._model.baseTable + '"][data-schema="' + builder._model.baseSchema + '"]');
                    svgAddClass(elem, 'cloud-model-dependency');
                    parentTable.addClass('cloud-model-dependency');
                    childTable.addClass('cloud-model-dependency');
                    diagram.addClass('cloud-model-has-dependency');
                }
                // show dependencies in field list
                else {
                    var tableModelRow = elem.closest('.cloud-model-column'),
                        tableModel = tableModelRow.closest('.cloud-model-table');
                    if (tableModelRow.length)
                        builder.scrollFieldIntoView({
                            tableAlias: tableModel.attr('data-foreign-key') || builder._model.alias,
                            tableName: toPhysicalTableName(tableModel.attr('data-schema'), tableModel.attr('data-table')),
                            columnName: tableModelRow.attr('data-column')
                        });
                }
            }
            else
                $(tooltip).hide();
        }, delay != null ? delay : tooltipDelay);

    }).on('mouseleave', '[title]', function (event) {
        if (dragEvent) return;
        var elem = $(this),
            title = elem.data('title');
        if (title)
            elem.attr('title', title);
        modelBuilder_hideTooltip();
    }).on('mouseenter', '[data-table][data-foreign-key]', function (event) {
        if (preventMouseEnter || dragEvent) return;
        var tableElement = $(this);
        clearTimeout(dependencyTimeout);
        revealAllDependencies();
        $(tooltip).hide();
        dependencyTimeout = setTimeout(function () {
            var builder = tableElement.addClass('cloud-model-dependency').closest('.cloud-model-diagram').addClass('cloud-model-has-dependency').data('builder'),
                container = builder._diagram,
                fkName = tableElement.attr('data-foreign-key'),
                fk = builder._foreignKeyMap[fkName],
                fkKeyColumns = fk.foreignKey,
                fkBase = fk.baseForeignKey,
                tbl;
            svgAddClass(container.find('[data-connector="' + fkName + '"]'), 'cloud-model-dependency');
            while (fkBase) {
                tbl = container.find('[data-table][data-foreign-key="' + fkBase + '"]').addClass('cloud-model-dependency');
                $(fkKeyColumns).each(function () {
                    tbl.find('[data-column="' + this.columnName + '"]').addClass('cloud-model-dependency');
                });
                fkBase = fk.baseForeignKey;
                if (fkBase) {
                    fkKeyColumns = fk.foreignKey;
                    fk = builder._foreignKeyMap[fkBase];
                    svgAddClass(container.find('[data-connector="' + fkBase + '"]'), 'cloud-model-dependency');
                }
            }
            if (fk) {
                tbl = container.find('.cloud-model-table-base').addClass('cloud-model-dependency');
                $(fk.foreignKey).each(function () {
                    tbl.find('[data-column="' + this.columnName + '"]').addClass('cloud-model-dependency');
                });
            }
        }, 1000);
    }).on('mouseleave', '[data-table][data-foreign-key]', function (event) {
        if (dragEvent) return;
        revealAllDependencies();
    }).on('mouseenter', '.cloud-grid tbody td', function (event) {
        if (preventMouseEnter || dragEvent) return;
        var td = $(this),
            columnName = td.attr('data-column');
        if (columnName == 'RowNumber' || columnName == 'FieldName') {
            clearTimeout(trackingTimeout);
            trackingTimeout = setTimeout(function () {
                var tdOffset = td.offset();
                if (tdOffset.left <= mouseX && mouseX < tdOffset.left + td.outerWidth() && tdOffset.top <= mouseY && mouseY <= tdOffset.top + td.outerHeight())
                    modelBuilder_showFieldOnDiagram(td);
            }, tooltipDelay);
        }
    }).on('click', '.cloud-grid tbody td', function (event) {
        var target = $(this),
            row,
            builder;
        if (target.is('[data-column="SqlFormula"]')) {
            builder = builderInstance();
            row = builder._fieldGrid.findRow({ FieldName: target.parent().attr('data-field') });
            if (row.SqlFormula)
                builder.formulaField({ fieldName: row.FieldName, formula: row.SqlFormula });
        }
        else
            modelBuilder_showFieldOnDiagram(target);
    }).on('mouseleave', '[data-column]', function (event) {
        if (dragEvent) return;
        var elem = $(this),
            builder = elem.closest('.cloud-model-diagram,.cloud-model-list').data('builder'),
            dependencies,
            trackings;
        if (builder) {
            dependencies = builder._fieldGrid._grid.find('.cloud-model-dependency');
            trackings = builder._diagram.find('.cloud-model-tracking');
            setTimeout(function () {
                dependencies.removeClass('cloud-model-dependency');
                if (!$('.cloud-model-inspected').length)
                    trackings.removeClass('cloud-model-tracking');
            }, 500);
        }
    }).on('mousedown', '.cloud-model-table th', function (event) {
        //if (event.which == 3) return;
        if (!allowDragging(event)) return;
        clearHtmlSelection(true);
        var target = $(this).closest('.cloud-model-table'),
            container = target.closest('.cloud-model-container'),
            containerOffset = container.offset(),
            tableOffset = target.offset(),
            scrollTop = container.scrollTop(),
            scrollLeft = container.scrollLeft(),
            pageX = event.pageX,
            pageY = event.pageY;
        pendingDragEvent = {
            type: 'table',
            element: target,
            data: target.closest('.cloud-model-container').offset(),
            x: pageX,
            offsetX: pageX - tableOffset.left - scrollLeft,
            y: pageY,
            offsetY: pageY - tableOffset.top - scrollTop,
            originalScrollLeft: scrollLeft,
            originalScrollTop: scrollTop,
            originalX: tableOffset.left - containerOffset.left + scrollLeft,
            originalY: tableOffset.top - containerOffset.top + scrollTop
        };
    }).on('mousedown', '.cloud-divider-horizontal', function (event) {
        if (!allowDragging(event)) return;
        clearHtmlSelection(true);
        var target = $(this).addClass('cloud-model-dragging');
        dragEvent = {
            type: 'divider',
            element: target,
            data: target.prev().find('.cloud-grid'),
            originalY: target.offset().top
        };
        event.preventDefault();
        preventMouseEnter = true;
        // Internet Explorer 11 crashes when divider is moved quickly due to some issues with SVG
        if (builderInstance().hosted() || true)
            $('.cloud-model-container svg').css('visibility', 'hidden');
    }).on('dragstart', '.cloud-model-list [data-column="FieldName"],.cloud-model-table .cloud-model-column-name', function (event) {
        if (!clearHtmlSelection()) {
            clearHtmlSelection(true);
            return;
        }
        hideTracking();
        highlightField();
        var target = $(this),
            dt = event.originalEvent.dataTransfer,
            tableElement = target.closest('.cloud-model-table'),
            columnElement = target.closest('.cloud-model-column-name');

        if (columnElement.length)
            target = columnElement;

        if (columnElement.length) {
            //dt.effectAllowed = 'link';
            dragEvent = {
                type: 'column',
                data: {
                    column: target.closest('.cloud-model-column').attr('data-column'),
                    alias: tableElement.attr('data-foreign-key'),
                    table: tableElement.attr('data-table'),
                    schema: tableElement.attr('data-schema')
                },
                element: target
            };

            revealAllDependencies();
            modelBuilder_hideTooltip();
        }
        else {
            dt.effectAllowed = 'move';
            dragEvent = {
                type: 'field',
                data: target.text(),
                element: target
            };
        }
        dragEvent.element.addClass('cloud-model-dragging');
    }).on('dragstart', '.cloud-model-table-list [data-table]', function (event) {
        var target = $(this),
            targetOffset = target.offset(),
            originalEvent = event.originalEvent,
            scaleRatio = builderInstance()._scaleRatio;
        dragEvent = {
            type: 'tableName',
            data: {
                name: target.attr('data-table'), schema: target.attr('data-schema'),
                x: -(originalEvent.pageX - targetOffset.left) * scaleRatio,
                y: -(originalEvent.pageY - targetOffset.top) * scaleRatio
            }
        }
        event.originalEvent.dataTransfer.effectAllowed = 'copy';
        modelBuilder_hideTooltip();
    }).on('dragover', '.cloud-model-list td', function (event) {
        if (dragEvent && dragEvent.type == 'field' && $(event.target).parent().attr('data-field') != dragEvent.data) {
            event.originalEvent.dataTransfer.dropEffect = 'copy';
            event.preventDefault();
        }
    }).on('dragover', '.cloud-model-list', function (event) {
        if (dragEvent && dragEvent.type == 'column') {
            event.originalEvent.dataTransfer.dropEffect = 'move';
            event.preventDefault();
        }
    }).on('dragover', '.cloud-model-container', function (e) {
        if (dragEvent)
            if (dragEvent.type == 'column') {
                if (builderInstance().linkTables(e.target, e.ctrlKey)) {
                    e.originalEvent.dataTransfer.dropEffect = 'link';
                    e.preventDefault();
                }
            }
            else if (dragEvent.type == 'tableName') {
                e.originalEvent.dataTransfer.dropEffect = 'copy';
                e.preventDefault();
            }
    }).on('dragover', '.CodeMirror', function (event) {
        if (dragEvent && dragEvent.type == 'column') {
            event.originalEvent.dataTransfer.dropEffect = 'link';
            event.preventDefault();
        }
    }).on('drop', '.CodeMirror', function (event) {
        if (dragEvent && dragEvent.type == 'column') {
            var formulaPanel = $(event.target).closest('.cloud-model-panel-formula'),
                editor = formulaPanel.data('editor'),
                doc = editor.getDoc();
            doc.replaceRange((dragEvent.data.alias || builderInstance()._model.alias) + '.' + dragEvent.data.column, doc.getCursor('from'), doc.getCursor('to'));
            editor.focus();
            event.stopPropagation();
        }
    }).on('drop', '.cloud-model-table', function () {
        if (dragEvent && dragEvent.type == 'column') {
            dragEvent.data.rollback = null;
            if (dragEvent.data.commit)
                dragEvent.data.commit();
        }
    }).on('drop', '.cloud-model-list td', function (event) {
        if (!dragEvent || dragEvent.type != 'field') return;
        var target = $(event.target).parent(),
            pageY = event.originalEvent.pageY,
            fieldName = dragEvent.data,
            beforeFieldName = target.attr('data-field'),
            targetMiddleY = target.offset().top + target.outerHeight() / 2;
        if (isNullOrEmpty(fieldName)) {
            //$('input:visible').trigger($.Event('keydown', { keyCode: 27 }));
            return false;
        }
        setTimeout(function () {
            if (pageY < targetMiddleY)
                builderInstance().moveFieldBefore(fieldName, beforeFieldName);
            else
                builderInstance().moveFieldAfter(fieldName, beforeFieldName);
        }, 50);
        event.preventDefault();
    }).on('drop', '.cloud-model-list', function (event) {
        if (dragEvent && dragEvent.type == 'column') {
            var builder = builderInstance(),
                tableAlias = dragEvent.data.alias || builder._model.alias,
                options = { newFieldName: tableAlias + (tableAlias.match(/\_/) ? '_' : '') + dragEvent.data.column, formula: tableAlias + '.' + builder.quotedName(dragEvent.data.column) };
            setTimeout(function () {
                builder.formulaField(options);
            }, 100);
        }
    }).on('drop', '.cloud-model-container', function (event) {
        if (dragEvent && dragEvent.type == 'tableName') {
            var container = $(this),
                containerOffset = container.offset(),
                eventData = dragEvent.data,
                originalEvent = event.originalEvent,
                builder = builderInstance();
            eventData.x += originalEvent.pageX - containerOffset.left + container.scrollLeft();
            eventData.y += originalEvent.pageY - containerOffset.top + container.scrollTop();
            builder.addTable(eventData);
            toggleOptionalTableColumns(builder._diagram.find('.cloud-model-table').last());

        }
    }).on('dragend', function () {
        if (!dragEvent) return;
        clearTimeout(dragScrollInterval);
        if (dragEvent.data.rollback) {
            dragEvent.data.rollback();
            dragEvent.data.rollback = null;
        }
        dragEvent.data.commit = null;
        dragEvent.data = null;
        dragEvent.element = null;
        dragEvent = null;
        $('.cloud-model-dragging,.cloud-model-drop-target').removeClass('cloud-model-dragging cloud-model-drop-target');
    }).on('getvalue.input.app', '.cloud-model-table th', function (event) {
        var target = $(event.target),
            table = target.closest('[data-table]');
        event.inputValue = table.is('.cloud-model-table-base') ? builderInstance()._model.alias : table.attr('data-foreign-key');
    }).on('setvalue.input.app', '.cloud-model-table th', function (event) {
        var result = builderInstance().changeTableAlias({ newTableAlias: event.inputValue, tableAlias: event.inputOriginalValue });
        if (result != true) {
            event.inputValid = false;
            event.inputError = result;
        }
    }).on('beforefocus.input.app', '.cloud-grid [data-column]', function (event) {
        var target = $(event.target),
            grid = target.closest('.cloud-grid'),
            header = grid.find('.cloud-grid-header'),
            targetOffset = target.offset(),
            gridOffset = grid.offset(),
            deltaX = 0,
            hscrollbar;
        grid.find('.cloud-grid-header [data-column="' + target.attr('data-column') + '"]').addClass('cloud-grid-focus');
        target.parent().addClass('cloud-grid-focus');
        if (targetOffset.top < gridOffset.top + header.outerHeight())
            grid.scrollTop(grid.scrollTop() + targetOffset.top - (gridOffset.top + header.outerHeight()));
        if (gridOffset.left + grid.width() - scrollbarInfo.width < targetOffset.left + target.outerWidth(true))
            deltaX = (targetOffset.left + target.outerWidth(true)) - (gridOffset.left + grid.width() - scrollbarInfo.width);
        else if (targetOffset.left < gridOffset.left)
            deltaX = targetOffset.left - gridOffset.left - 1;
        if (deltaX != 0) {
            hscrollbar = grid.find('.cloud-grid-hscrollbar');
            hscrollbar.scrollLeft(hscrollbar.scrollLeft() + deltaX);
            hscrollbar.trigger('scroll');
        }
    }).on('getvalue.input.app', '.cloud-grid [data-column]', function (event) {
        var target = $(event.target),
            column = target.attr('data-column'),
            row = builderInstance()._fieldGrid.rows()[target.parent().index()];
        event.inputValue = row[column];
    }).on('setvalue.input.app', '.cloud-grid [data-column]', function (event) {
        var target = $(event.target),
            options = {
                name: target.attr('data-column'),
                value: event.inputValue,
                fieldName: target.parent().attr('data-field'),
                textInput: target
            },
            result = builderInstance().changeFieldProperty(options);
        if (result != true) {
            event.inputValid = false;
            event.inputError = result;
        }
        else
            event.inputValidCallback = options.success;
    });

    $window.on('resize', function (event) {
        closeListPopup();
        clearTimeout(resizeTimeout);
        setTimeout(function () {
            try {
                builderInstance().scale();
                var fieldList = $('.cloud-model-list'),
                    hDivider = $('.cloud-divider-horizontal');
                if (fieldList.outerHeight() < 101 || $window.height() - fieldList.outerHeight() + fieldList.next().outerHeight() < 150) {
                    dragEvent = {
                        type: 'divider',
                        element: hDivider,
                        data: fieldList.find('.cloud-grid')
                    };
                    hDivider.trigger('mousemove', event).trigger('dragend', event);
                }
                refreshFormulaPanel();
            }
            catch (ex) {
                // nothing
            }
        }, 200);
    });

    if (typeof CloudOnTime == 'undefined')
        _window.CloudOnTime = {};
    if (typeof _window.CloudOnTime.Models == 'undefined')
        _window.CloudOnTime.Models = {};
    if (typeof _window.CloudOnTime.Utilities == 'undefined')
        _window.CloudOnTime.Utilities = {};

    // class CloudOnTime.Utitlities.input

    function activateTextInput(target) {
        if (skipClickAfterDrop)
            return false;
        var dataInput = target.closest('[data-input]'),
            contents = dataInput.contents(),
            inputHeight = dataInput.outerHeight(),
            textContainer,
            textInput, text,
            getValueEvent,
            beforeFocusEvent;
        if (dataInput.find('[data-input-hotspot]').length && !target.is('[data-input-hotspot]') || $('.cloud-model-input').length)
            return false;
        textContainer = $('<div class="cloud-model-input-container"></div>'),
            textInput = $('<input type="text" class="cloud-model-input"/>').appendTo(textContainer);
        contents.css('visibility', 'hidden');
        textContainer.appendTo(dataInput).height(inputHeight - 1);
        getValueEvent = $.Event('getvalue.input.app', { inputValue: null, inputElement: textInput.get(0) });
        dataInput.trigger(getValueEvent);
        getValueEvent.inputElement = null;
        text = getValueEvent.inputValue || '';
        textInput.val(text).data('original', text);
        beforeFocusEvent = $.Event('beforefocus.input.app', { inputElement: textInput.get(0) });
        dataInput.trigger(beforeFocusEvent);
        beforeFocusEvent.inputElement = null;
        textInput.focus().select();
        return true;
    }

    $(document).on('click', '[data-input]', function (event) {
        if (activateTextInput($(event.target)))
            event.preventDefault();
    }).on('blur', '.cloud-model-input', function (event) {
        var textInput = $(event.target),
            dataInput = textInput.closest('[data-input]'),
            originalValue = textInput.data('original'),
            value = textInput.val().trim(),
            container = textInput.parent(),
            parent = container.parent(),
            setValueEvent;

        function focusTextInput(message, callback) {
            setTimeout(function () {
                textInput.focus();
                if (message) {
                    textInput.attr('title', message)
                    showTooltip(textInput.offset().left + 1, textInput.offset().top + 1, message);
                }
                if (callback)
                    callback(dataInput);
            }, 10);
        }

        function removeTextInput(callback) {
            setTimeout(function () {
                if (textInput.attr('title'))
                    modelBuilder_hideTooltip();
                textInput.remove();
                container.remove();
                parent.contents().css('visibility', '');
                if (callback)
                    callback(dataInput);
                $('.cloud-grid-focus').removeClass('cloud-grid-focus');
            }, 10);
        }

        if ($(event.relatedTarget).is('.cloud-model-input-container'))
            focusTextInput();
        else if (value == originalValue)
            removeTextInput();
        else {
            setValueEvent = $.Event('setvalue.input.app', { inputValue: value, inputOriginalValue: originalValue, inputElement: textInput.get(0), inputValid: true, inputError: null });
            dataInput.trigger(setValueEvent);
            setValueEvent.inputElement = null;
            if (setValueEvent.inputValid)
                removeTextInput(setValueEvent.inputValidCallback);
            else {
                event.preventDefault();
                focusTextInput(setValueEvent.inputError, setValueEvent.inputErrorCallback);
            }
        }
    }).on('keydown', '.cloud-model-input', function (event) {
        var code = event.keyCode || event.which,
            key = event.key,
            selectionStart, selectionEnd,
            textInput = $(event.target),
            moveDir,
            inputContainer, nextTextInputList,
            textInputList, selectedTextInputIndex;

        function blurTextInput(nextInputText) {
            setTimeout(function () {
                textInput.blur();
                if (nextInputText)
                    setTimeout(function () {
                        var input = $(nextInputText),
                            hotSpot = input.find('[data-input-hotspot]');
                        activateTextInput(hotSpot.length ? hotSpot : input);
                    }, 10);
            }, 10);
        }

        function findNextTextInputList(dir) {
            var inputContainerList,
                selectedInputContainerIndex,
                result,
                changed;
            inputContainerList = inputContainer.data('active', true).parent().find('[data-input-container]');
            $(inputContainerList).each(function (index) {
                var c = $(this);
                if (c.data('active')) {
                    selectedInputContainerIndex = index;
                    c.removeData('active');
                    return false;
                }
            });
            if (dir == 'up')
                result = selectedInputContainerIndex == 0 ? null : $(inputContainerList.get(selectedInputContainerIndex - 1));
            else
                result = selectedInputContainerIndex < inputContainerList.length - 1 ? $(inputContainerList.get(selectedInputContainerIndex + 1)) : null;
            return result ? result.find('[data-input]') : null;
        }

        if (code == 27) {
            changed = textInput.val() != textInput.data('original');
            if (changed)
                textInput.val(textInput.data('original'));
            else
                blurTextInput();
            event.preventDefault();
        }

        if (code == 13 && event.ctrlKey) {
            blurTextInput(textInput.closest('[data-input]'));
            event.preventDefault();
            return;
        }


        // Tab
        if (code == 9)
            moveDir = event.shiftKey ? 'left' : 'right';
        // Left
        if (code == 37 && this.selectionStart == 0 && this.selectionEnd == 0)
            moveDir = 'left';

        // Right
        if (code == 39 && this.selectionStart == this.value.length)
            moveDir = 'right';
        // Up 
        if (code == 38 || code == 13 && event.shiftKey)
            moveDir = 'up';
        // Down
        if (code == 40 || code == 13 && !event.shiftKey)
            moveDir = 'down';

        if (moveDir && textInput.closest('[data-input]').is('[data-input-tab-stop="false"]')) {
            if (code == 13 || code == 9) {
                blurTextInput();
                event.preventDefault();
            }
            return;
        }


        if (moveDir) {
            // locate position of input in the current container
            inputContainer = textInput.closest('[data-input-container]');
            if (!inputContainer.length)
                inputContainer = $body;
            textInput.closest('[data-input]').data('active', true);
            textInputList = inputContainer.find('[data-input]').each(function (index) {
                var textInputContainer = $(this);
                if (textInputContainer.data('active')) {
                    selectedTextInputIndex = index;
                    textInputContainer.removeData('active');
                    return false;
                }
            });
            // select another input according to user choice
            if (moveDir == 'left')
                if (selectedTextInputIndex) {
                    // move to the previous input
                    blurTextInput(textInputList.get(selectedTextInputIndex - 1));
                }
                else {
                    if (code == 9) {
                        // move to the last input of previous container
                        nextTextInputList = findNextTextInputList('up');
                        if (nextTextInputList && nextTextInputList.length)
                            blurTextInput(nextTextInputList.get(nextTextInputList.length - 1));
                    }
                }
            else if (moveDir == 'right')
                if (selectedTextInputIndex < textInputList.length - 1) {
                    // move to the next input
                    blurTextInput(textInputList.get(selectedTextInputIndex + 1));
                }
                else {
                    if (code == 9) {
                        // move the the first input of the next  container
                        nextTextInputList = findNextTextInputList('down');
                        if (nextTextInputList && nextTextInputList.length)
                            blurTextInput(nextTextInputList.get(0));
                    }
                }
            else if (moveDir == 'up' || moveDir == 'down') {
                // move to the input with the same index in the previous container
                nextTextInputList = findNextTextInputList(moveDir);
                if (nextTextInputList)
                    blurTextInput(nextTextInputList.get(nextTextInputList.length > selectedTextInputIndex ? selectedTextInputIndex : nextTextInputList.length - 1));
                else if (moveDir === 'down')
                    blurTextInput(textInput.closest('[data-input]'));

            }
            event.preventDefault();
        }

        // F2
        if (code == 113) {
            selectionStart = this.selectionStart;
            selectionEnd = this.selectionEnd;
            if (selectionStart == 0 && selectionEnd == this.value.length)
                this.selectionStart = selectionEnd;
            else {
                this.selectionStart = 0;
                this.selectionEnd = this.value.length;
            }
            event.preventDefault();
        }

        // how to select text

    });

    // class CloudOnTime.Utilities.grid

    CloudOnTime.Utilities.grid = function (options) {
        this._options = options;
        if (options.showRowNumber) {
            options.columns.splice(0, 0, {
                name: 'RowNumber', text: '#',
                fixed: options.columns[0].fixed,
                value: function (row) {
                    return { text: options.rows.indexOf(row) + 1 + '.' };
                }
            });
        }
    }

    CloudOnTime.Utilities.grid.prototype = {
        attach: function () {
            var that = this,
                options = that._options,
                table,
                headerRow,
                header,
                tableBody,
                fixedColumns = [],
                fixedTableBody;
            that._grid = $('<div class="cloud-grid"></div>').appendTo(options.container)
                .on('mouseenter', 'tbody tr', function () {
                    var tr = $(this).addClass('cloud-grid-hover'),
                        index = tr.index(),
                        trContainer;
                    if (tr.closest('.cloud-grid-fixed-columns').length)
                        trContainer = that._tableBody;
                    else
                        trContainer = that._fixedTableBody;
                    trContainer.find('tr:eq(' + index + ')').addClass('cloud-grid-hover');
                }).on('mouseleave', 'tbody tr', function () {
                    that._grid.find('.cloud-grid-hover').removeClass('cloud-grid-hover');
                }).on('scroll', function () {
                    if (!keepTooltip)
                        $(tooltip).hide();
                });
            // create header and body placeholders
            header = that._header = $('<div class="cloud-grid-header"></div>').appendTo(that._grid).css({ 'right': scrollbarInfo.width /*'margin-right': -scrollbarInfo.width */ });
            that._body = $('<div class="cloud-grid-body"></div>').appendTo(that._grid);
            // render table body
            that._table = table = $('<table class="cloud-grid-table"/>').appendTo(that._body);
            headerRow = that._headerRow = $('<tr/>').appendTo($('<thead/>').appendTo(table));
            that._fixedColumns = fixedColumns;
            $(options.columns).each(function () {
                var c = this;
                if (c.fixed)
                    fixedColumns.push(c);
                $('<th/>').appendTo(headerRow).attr('data-column', c.name).html(c.text || c.name);
            });
            tableBody = that._tableBody = $('<tbody/>').appendTo(table);

            fixedTableBody = $('<table class="cloud-grid-fixed-columns"/>').appendTo(that._body);
            that._fixedTableBody = $('<tbody/>').appendTo(fixedTableBody);

            that._renderRows();

            // render header
            $(options.columns).each(function () {
                var c = this,
                    th = headerRow.find('[data-column="' + c.name + '"]'),
                    w = c.width || th.width() + 1;
                $('<span/>').appendTo(header).attr('data-column', c.name).html(c.text || c.name).attr('title', c.tooltip);

                tableBody.find('[data-column="' + c.name + '"]');
            });
            // render fixed columns
            if (fixedColumns.length) {
                var fixedHeader = $('<thead/>').appendTo(fixedTableBody),
                    fixedHeaderRow = that._fixedHeaderRow = $('<tr/>').appendTo(fixedHeader),
                    fixedHeader = that._fixedHeader = $('<div class="cloud-grid-header cloud-grid-header-fixed"></div>').insertBefore(that._body);
                $(fixedColumns).each(function () {
                    var c = this,
                        w = c.width;
                    $('<th/>').appendTo(fixedHeaderRow).attr('data-column', c.name).html(c.text || c.name).attr('title', c.tooltip);
                });

                $(fixedColumns).each(function () {
                    var c = this,
                        w = c.width;
                    $('<span/>').appendTo(fixedHeader).attr('data-column', c.name).html(c.text || c.name).attr('title', c.tooltip);
                });
            }
            // TODO: need to remove fixed header
            that._fixedHeader.hide();
            that._fixedTableBody.parent().hide();
            that._configureColumnWidth();
            // create horizontal scrollbar
            that._grid.css('margin-bottom', scrollbarInfo.height);
            that._hscrollbar = $('<div class="cloud-grid-hscrollbar"></div>').appendTo(that._grid).css({ height: scrollbarInfo.height + 1, right: scrollbarInfo.width }).on('scroll', function () {
                $(tooltip).hide();
                var distance = -that._hscrollbar.scrollLeft(),
                    fixedColumns = $(fixedTableBody);
                header.css('margin-left', distance);
                that._body.css('margin-left', distance);
                fixedColumns.css('margin-left', -distance);
                if (distance == 0)
                    fixedColumns.removeClass('cloud-grid-fixed-shadow');
                else
                    fixedColumns.addClass('cloud-grid-fixed-shadow');
            });
            that._hscrollable = $('<div></div>').appendTo(that._hscrollbar).css({ height: scrollbarInfo.height });
            that.hscrollbar();
        },
        fit: function () {
            var that = this,
                dataCells = that._tableBody.find('tr:first td'),
                headerCells = that._header.find('[data-column]'),
                changed;
            $(dataCells).each(function (index) {
                var cell = $(this),
                    w = Math.ceil(cell.width()),
                    headerCell = $(headerCells[index]),
                    hw = headerCell.width();

                if (w != hw) {
                    headerCell.css({ 'min-width': w, 'max-width': w, 'width': w });
                    changed = true;
                }
            });
            if (changed)
                that.hscrollbar();
        },
        refresh: function () {
            var that = this;
            that._renderRows();
            that._configureColumnWidth();
            that.hscrollbar();
        },
        hscrollbar: function () {
            var that = this;
            that._hscrollable.css('width', that._tableBody.outerWidth());
        },
        _configureColumnWidth: function () {
            var that = this,
                options = that._options;
            $(options.columns).each(function (index) {
                var c = this,
                    th = that._headerRow.find('[data-column="' + c.name + '"]'),
                    w = th.css({ 'min-width': '', 'max-width': '', 'width': '' }).width() + 1;
                th.width(w);
                that._header.find('[data-column="' + c.name + '"]').css({ 'min-width': w, 'max-width': w });
                that._tableBody.find('[data-column="' + c.name + '"]:first').css({ 'min-width': w, 'max-width': w });
                if (index < that._fixedColumns.length) {
                    that._fixedHeader.find('[data-column="' + c.name + '"]').css({ 'min-width': w, 'max-width': w });
                    that._fixedTableBody.find('[data-column="' + c.name + '"]:first').css({ 'min-width': w, 'max-width': w });
                }
            });
        },
        _renderRows: function () {
            var that = this,
                grid = that._grid,
                scrollTop = grid.scrollTop(),
                options = that._options,
                tableBody = that._tableBody,
                fixedTableBody = that._fixedTableBody,
                fixedColumns = that._fixedColumns;

            function renderRow(columns, row, tr, index) {
                tr.attr('data-input-container', 'row');
                $(columns).each(function () {
                    var c = this,
                        td = $('<td/>').appendTo(tr).attr('data-column', c.name),
                        v = c.value ? c.value(row) : row[c.name],
                        className = c.className ? c.className(row) : null,
                        readOnly = c.readOnly ? (typeof c.readOnly == 'function' ? c.readOnly(row) : c.readOnly) : false,
                        cornerInfo;
                    if (v)
                        if (c.value)
                            td.text(v.text).attr('title', v.tooltip);
                        else
                            td.text(v)
                    if (c.corner) {
                        cornerInfo = c.corner(row);
                        if (cornerInfo)
                            $('<span class="cloud-grid-corner"/>').appendTo(td).attr('title', cornerInfo.text).addClass(cornerInfo.className);
                    }
                    if (className)
                        td.addClass(className);
                    if (c.draggable)
                        td.attr('draggable', 'true');
                    if (c.maxWidth)
                        td.css('max-width', c.maxWidth);
                    if (c.minWidth)
                        td.css('min-width', c.minWidth);
                    if (!readOnly)
                        td.attr({ 'data-input': 'text' });
                });
            }

            tableBody.find('tr').remove();
            fixedTableBody.find('tr').remove();
            grid.find('[data-column]').css({ 'min-width': '', 'max-width': '' });
            $(options.rows).each(function (index) {
                var r = this,
                    tr = $('<tr/>').appendTo(tableBody);
                if (options.setupRow)
                    options.setupRow(tr, r);
                renderRow(options.columns, r, tr, index);
            });
            $(options.rows).each(function (index) {
                var r = this,
                    tr = $('<tr/>').appendTo(fixedTableBody);
                if (options.setupRow)
                    options.setupRow(tr, r);
                renderRow(fixedColumns, r, tr, index);
            });
            grid.scrollTop(scrollTop);
        },
        detach: function () {
        },
        findRowIndex: function (fieldValues) {
            var that = this,
                result = -1;
            $(that._options.rows).each(function (index) {
                var row = this,
                    fieldName,
                    match = true;
                for (fieldName in fieldValues)
                    if (row[fieldName] != fieldValues[fieldName]) {
                        match = false;
                        break;
                    }
                if (match) {
                    result = index;
                    return false;
                }
            });
            return result;
        },
        rows: function () {
            return this._options.rows;
        },
        findRow: function (fieldValues) {
            var fieldIndex = this.findRowIndex(fieldValues);
            return this.rows()[fieldIndex];
        },
        column: function (name) {
            var result;
            $(this._options.columns).each(function () {
                if (this.name == name) {
                    result = this;
                    return false;
                }
            });
            return result
        }
    }

    // class CloudOnTime.Models.builder

    CloudOnTime.Models.builder = function (options) {
        var that = this,
            model = options.model.dataModel,
            database = options.database,
            schemas = [];
        that._options = options;
        that._model = model;
        that._database = database;
        that._masterDetail = options.masterDetail;
        var virtualPrimaryKey = [];
        $(model.columns).each(function () {
            var column = this;
            if (column.primaryKey)
                virtualPrimaryKey.push(column.name);
        });
        $(that._database.dataModel).each(function () {
            if (!this.schema)
                this.schema = '';
        });
        that._right = 0;
        that._scaleRatio = 1;
        that._bottom = 0;
        // map database properties for caching
        that.setupMappings();
        // init static mappings
        that._modelMap = {};
        that._columnMap = {};
        $(database.dataModel).each(function () {
            var tableModel = this,
                primaryKey = {},
                foreignKeys = {};
            if (!tableModel.primaryKey)
                tableModel.primaryKey = [];
            if (!tableModel.primaryKey.length && tableModel.schema == model.baseSchema && tableModel.name == model.baseTable)
                $(virtualPrimaryKey).each(function () {
                    tableModel.primaryKey.push({
                        _type: 'primaryKeyColumn',
                        columnName: this,
                        isVirtual: true
                    });
                });
            $(tableModel.primaryKey).each(function () {
                primaryKey[this.columnName] = this;
            });
            $(tableModel.foreignKeys).each(function (fkIndex) {
                var fk = this;
                $(this.foreignKey).each(function () {
                    foreignKeys[this.columnName] = {
                        index: fkIndex, info: fk
                    };
                });
            });
            that._modelMap[tableModel.schema + '_' + tableModel.name] = {
                tableModel: tableModel,
                primaryKey: primaryKey,
                foreignKeys: foreignKeys
            };
            $(tableModel.columns).each(function () {
                var column = this;
                that._columnMap[tableModel.schema + '_' + tableModel.name + '_' + column.name] = column;
            });
            if (schemas.indexOf(tableModel.schema) === -1)
                schemas.push(tableModel.schema);
            that._schemas = schemas;
        });
    }

    CloudOnTime.Models.builder.prototype = {
        model: function () {
            return this._options.model.dataModel;
        },
        hosted: function () {
            return this._options.hosted;
        },
        setupMappings: function () {
            var that = this,
                model = that._options.model.dataModel;
            that._fieldMap = {};
            $(model.columns).each(function () {
                that._fieldMap[(this.foreignKey || that._model.alias) + '_' + this.name] = this;
            });
            that._foreignKeyMap = {};
            that._aliasMap = {};
            that._aliasedMap = {};
            $(model.foreignKeys).each(function () {
                that._foreignKeyMap[this.id] = this;
            });
            $(model.columns).each(function () {
                if (this.aliasColumnName) {
                    that._aliasedMap[(this.aliasForeignKey || model.alias) + '_' + this.aliasColumnName] = this;
                    that._aliasMap[(this.aliasForeignKey || model.alias) + '_' + this.aliasColumnName] = that._fieldMap[(this.aliasForeignKey || model.alias) + '_' + this.aliasColumnName];
                }
            });
        },
        finalDataModel: function () {
            var that = this,
                model = that.model(),
                foreignKeys,
                i;
            // clone the model
            eval('model=' + JSON.stringify(model))
            foreignKeys = model.foreignKeys;
            // validate foreign keys
            var fkMap = {};
            $(model.columns).each(function () {
                var c = this;
                fkMap[c.foreignKey] = true;
            });

            function validateKey(fk) {
                var result;
                if (fkMap[fk.id])
                    result = true;
                else
                    $(foreignKeys).each(function () {
                        var fk2 = this;
                        if (fk2.baseForeignKey == fk.id) {
                            if (validateKey(fk2))
                                result = true;
                        }
                    });
                return result;
            }

            var i = 0;
            while (i < foreignKeys.length)
                if (validateKey(foreignKeys[i]))
                    i++;
                else
                    foreignKeys.splice(i, 1);

            // persist coordinates of tables on the diagram
            var ratio = that._scaleRatio,
                minX = 100000, minY = minX, deltaX, deltaY,
                diagramOffset = that._diagram.offset(),
                diagramContainer = that._diagram.parent(),
                horizontalOffset = diagramOffset.left + diagramContainer.scrollLeft(),
                verticalOffset = diagramOffset.top + diagramContainer.scrollTop();

            function saveTablePos(table, saveTo) {
                var tableOffset = table.offset(),
                    x, y;
                saveTo.x = x = Math.ceil((tableOffset.left - horizontalOffset) / ratio);
                saveTo.y = y = Math.ceil((tableOffset.top - verticalOffset) / ratio);
                if (x < minX)
                    minX = x;
                if (y < minY)
                    minY = y;
            }

            saveTablePos(that._diagram.find('.cloud-model-table-base'), model);
            $(foreignKeys).each(function () {
                var fk = this;
                saveTablePos(that._diagram.find('[data-foreign-key="' + fk.id + '"]'), fk);
            });

            // align table positions to diagram margin
            deltaX = diagramMargin - minX;
            deltaY = diagramMargin - minY;
            model.x += deltaX;
            model.y += deltaY;
            $(foreignKeys).each(function () {
                var fk = this;
                fk.x += deltaX;
                fk.y += deltaY;
            });

            return model;
        },
        scrollFieldIntoView: function (options) {
            var builder = this,
                rowIndex,
                tr, trOffset,
                scrollable, scrollableOffset,
                fixedHeaderHeight;
            rowIndex = builder._fieldGrid.findRowIndex(
                options.fieldName ? { FieldName: options.fieldName } :
                    {
                        TableAlias: options.tableAlias,
                        TableName: options.tableName,
                        ColumnName: options.columnName
                    });
            if (rowIndex != -1) {
                /*tr = */builder._fieldGrid._fixedTableBody.find('tr:eq(' + rowIndex + ')').addClass('cloud-model-dependency');
                tr = builder._fieldGrid._tableBody.find('tr:eq(' + rowIndex + ')').addClass('cloud-model-dependency');
                scrollable = builder._fieldGrid._grid;
                trOffset = tr.offset();
                fixedHeaderHeight = builder._fieldGrid._header.outerHeight(),
                    scrollableOffset = scrollable.offset();
                scrollableOffset.top += fixedHeaderHeight,
                    scrollableHeight = scrollable.height() - fixedHeaderHeight;
                if (trOffset.top < scrollableOffset.top || trOffset.top + tr.outerHeight() > scrollableOffset.top + scrollableHeight) {
                    keepTooltip = true;
                    scrollable.animate(
                        { scrollTop: scrollable.scrollTop() + trOffset.top - scrollableOffset.top - (scrollableHeight - tr.outerHeight()) / 2 },
                        300,
                        function () {
                            setTimeout(function () { keepTooltip = false; }, 200);
                        }
                    );
                }
            }
        },
        findDiagramColumn: function (tableAlias, columnName) {
            return this._diagram.find(tableAlias ? ('[data-foreign-key="' + tableAlias + '"]') : '.cloud-model-table-base').find('[data-column="' + columnName + '"]');
        },
        clearnIdentifier: function (name) {
            var s = name.replace(/[^\w]/g, "");
            if (!s.length || s.match(/^\d/))
                s = "n" + s;
            return s;
        },
        validateFieldName: function (name, exceptions) {
            var result = true,
                details = this._model.details;
            if (!name)
                return 'A field name is required.';
            name = name.toLowerCase();
            if (!name.match(/^[a-z]/i))
                return 'The name must begin with a letter.';
            if (!name.match(/^([a-z0-9_])+$/i))
                return 'Only alpha-numeric characters and \'_\' are allowed.';
            if (name.length > this._database.nameMaxLength)
                return 'The name is too long.';
            if (exceptions)
                $(exceptions).each(function (index) {
                    exceptions[index] = this.toLowerCase();
                });
            else
                exceptions = [];
            $(this._model.columns).each(function () {
                var fieldName = this.fieldName;
                if (exceptions.indexOf(fieldName.toLowerCase()) === -1 && fieldName.toLowerCase() === name) {
                    result = 'Duplicate field name.';
                    return false;
                }
            });
            if (details)
                details.every(function (detail) {
                    var fieldName = detail.fieldName;
                    if (exceptions.indexOf(fieldName.toLowerCase()) === -1 && fieldName.toLowerCase() === name)
                        result = 'Duplicate field name.';
                    return result === true;
                });
            return result;
        },
        nameToParts: function (name, parts) {
            if (name.match(/_/))
                name = name.replace(/(_+)/g, ' $1');
            else
                name = name.replace(/([A-Z]+)/g, ' $1');

            name = name.replace(/([0-9]+)/g, ' $1');

            $(name.split(/\s+/)).each(function () {
                var n = this.toString();
                if (n) {
                    n = n.replace(/\_+/, '');
                    if (n.length > 2)
                        n = n.substring(0, 1).toUpperCase() + n.substring(1).toLowerCase();
                    if (!parts.length || parts[parts.length - 1] != n)
                        parts.push(n);
                }
            });
        },
        fieldNameToLabel: function (name) {
            var parts = [];
            this.nameToParts(name, parts);
            return parts.join(' ');
        },
        forEachField: function (id, action) {
            var that = this,
                fk = that._foreignKeyMap[id],
                tableModel = fk ? that.findTableModel(fk.parentTableSchema, fk.parentTableName) : that.findTableModel(that._model.baseSchema, that._model.baseTable);
            $(tableModel.columns).each(function () {
                var column = this,
                    fieldOptions = {
                        columnName: column.name,
                        tableAlias: id,
                        tableName: tableModel.name,
                        schema: tableModel.schema,
                        silent: true
                    };
                if (action == 'add')
                    that.addField(fieldOptions);
                else
                    that.removeField(fieldOptions);

            });
            /*
            rowOptions = {
            columnName: column,
            tableAlias: foreignKey,
            tableName: table.attr('data-table'),
            schema: table.attr('data-schema'),
            };
            */
            if (id)
                that.reAssignAliasColumn(id);
            //that.setupMappings();
            that._fieldGrid.refresh();
            that.updateStateOfConnectors();
        },
        addField: function (options) {
            var that = this,
                fieldGrid = that._fieldGrid,
                rows = fieldGrid.rows(),
                columnModel = that.findColumnModel(options.schema, options.tableName, options.columnName),
                tableModel = that.findTableModel(options.schema, options.tableName),
                tableName = toPhysicalTableName(options.schema, options.tableName),
                diagramColumn = that.findDiagramColumn(options.tableAlias, options.columnName),
                diagramColumnName,
                fieldName = options.tableAlias || '',
                fieldNameParts = [],
                fieldNameIndex = 0,
                fieldLabel,
                nameMaxLength = that._database.nameMaxLength,
                newColumn, newColumnRow,
                columnSpec, dataFormatString,
                lastAliasRowIndex;

            function connectedToBaseTable(fk) {
                var connected = true;
                if (!fk.foreignKey.length)
                    connected = false;
                if (fk.baseForeignKey)
                    $(that._model.foreignKeys).each(function () {
                        var cfk = this;
                        if (cfk.id == fk.baseForeignKey && !connectedToBaseTable(cfk))
                            connected = false;
                    });
                return connected;
            }

            if (options.tableAlias && !connectedToBaseTable(that._foreignKeyMap[options.tableAlias])/* !that._foreignKeyMap[options.tableAlias].foreignKey.length*/) {
                diagramColumn.find(':input').prop('checked', false);
                return false;
            }

            if (diagramColumn.is('.cloud-model-column-selected'))
                return false;

            function removeVowels(name) {
                var newName = [];

                $(name.replace(/([A-Z0-9_]+)/g, ' $1').split(/\s+/g)).each(function () {
                    var n = this,
                        m = n.match(/[^aeiouy]/i),
                        s = m && m.index > 0 ? n.substring(0, m.index) : '',
                        s2 = m && m.index > 0 ? n.substring(m.index) : n;
                    if (n && n.length)
                        newName.push(s + s2.replace(/[aeiouy]/gi, ''));
                });

                return newName.join('');
            }

            if (fieldName) {
                if (fieldName.match(/[a-z0-9]$/) && options.columnName.match(/^[A-Z]/))
                    fieldName = fieldName + options.columnName;
                else
                    fieldName = fieldName + '_' + options.columnName;

            }
            else
                fieldName = options.columnName;

            that.nameToParts(fieldName, fieldNameParts);

            fieldName = fieldNameParts.join('');
            fieldLabel = fieldNameParts.join(' ');


            // validate field name
            if (fieldName.length > nameMaxLength)
                fieldName = removeVowels(fieldName);

            fieldName = that.clearnIdentifier(fieldName);
            while (that.validateFieldName(fieldName, null, true) != true) {
                var columnName = that.clearnIdentifier(options.columnName);
                fieldName = (columnName.length < nameMaxLength - 1 ? columnName : 'Field') + (fieldNameIndex ? fieldNameIndex : '');
                fieldNameIndex++;
            }

            // update field list
            newColumn = {
                _type: 'column',
                name: options.columnName,
                fieldName: fieldName,
                label: fieldLabel,
                foreignKey: options.tableAlias
            };

            dataFormatString = toFormat(columnModel);
            if (dataFormatString)
                newColumn.format = dataFormatString;

            newColumnRow = {
                'FieldName': fieldName,
                'AliasFieldName': null,
                'TableAlias': options.tableAlias || that._model.alias,
                'TableName': tableName,
                'ColumnName': options.columnName,
                'Label': fieldLabel,
                'Type': toDataType(columnModel),
                'Format': dataFormatString,
                _tableName: options.tableName,
                _schema: options.schema,
                _type: columnModel.dataType
            }
            if (that._model.alias != newColumnRow.TableAlias)
                $(rows).each(function (index) {
                    if (this['TableAlias'] == newColumnRow.TableAlias)
                        lastAliasRowIndex = index;
                });

            if (lastAliasRowIndex != null) {
                that._model.columns.splice(lastAliasRowIndex + 1, 0, newColumn);
                rows.splice(lastAliasRowIndex + 1, 0, newColumnRow);
            }
            else {
                that._model.columns.push(newColumn);
                rows.push(newColumnRow);
            }

            that.reAssignAliasColumn(options.tableAlias);
            that.setupMappings();

            if (!options.silent) {
                fieldGrid.refresh();

                highlightField(fieldName, fieldGrid);
            }

            columnSpec = that.columnSpec(newColumnRow._schema, newColumnRow._tableName, options.columnName, options.tableAlias);
            diagramColumnName = diagramColumn.find('.cloud-model-column-name').attr('title', columnSpec.nameTooltip).data('title', columnSpec.nameTooltip);
            clearTimeout(addColumnHoverTimeout);
            diagramColumn.find('.cloud-model-column-spec').attr('title', columnSpec.tooltip).text(columnSpec.text);
            diagramColumn.addClass('cloud-model-column-selected').find(':input').prop('checked', true);
            if (!options.silent) {
                addColumnHoverTimeout = setTimeout(function () {
                    diagramColumnName.trigger('mouseenter', 200);
                }, 50);
                that.updateStateOfConnectors();
            }
            return true;
        },
        removeField: function (options) {
            var that = this,
                fieldGrid = that._fieldGrid,
                diagramColumn = that.findDiagramColumn(options.tableAlias, options.columnName),
                diagramTable,
                tableForeignKey,
                rows = fieldGrid.rows(),
                columnSpec,
                rowIndex, r,
                newAliasColumn;
            rowIndex = fieldGrid.findRowIndex(
                options.fieldName ? { FieldName: options.fieldName } :
                    {
                        ColumnName: options.columnName,
                        _schema: options.schema,
                        _tableName: options.tableName,
                        TableAlias: options.tableAlias || that._model.alias
                    });
            if (rowIndex >= 0) {
                r = rows[rowIndex];
                $(rows).each(function () {
                    if (this.AliasFieldName == r.FieldName)
                        this.AliasFieldName = null;
                });
                $(that._model.columns).each(function () {
                    var c = this;
                    if (c.aliasColumnName == r.ColumnName && c.aliasForeignKey == r.TableAlias) {
                        delete c.aliasColumnName;
                        delete c.aliasForeignKey;
                    }

                });
                diagramColumn.find('.cloud-model-column-name').data('title', '').attr('title', null);
                rows.splice(rowIndex, 1);
                that._model.columns.splice(rowIndex, 1);
                newAliasColumn = that.reAssignAliasColumn(r.TableAlias);
                that.setupMappings();
                // update removed column
                if (r.TableAlias) {
                    columnSpec = that.columnSpec(r._schema, r._tableName, r.ColumnName, r.TableAlias);
                    diagramColumn.find('.cloud-model-column-spec').text(columnSpec.text).attr('title', columnSpec.tooltip);
                    diagramColumn.removeClass('cloud-model-column-selected').find(':input').prop('checked', false);
                }
                // update re-assigned alias column
                if (newAliasColumn) {
                    columnSpec = that.columnSpec(r._schema, r._tableName, newAliasColumn, r.TableAlias);
                    that.findDiagramColumn(options.tableAlias, newAliasColumn).find('.cloud-model-column-spec').text(columnSpec.text).attr('title', columnSpec.tooltip);
                }
                if (!options.silent) {
                    fieldGrid.refresh();
                    diagramTable = diagramColumn.closest('.cloud-model-table');
                    if (!diagramTable.find('.cloud-model-column-selected').length) {
                        tableForeignKey = diagramTable.attr('data-foreign-key');
                        $(that._model.foreignKeys).each(function () {
                            var fk = this;
                            if (fk.baseForeignKey == tableForeignKey)
                                diagramTable = null;
                        });
                        if (diagramTable)
                            setTimeout(function () {
                                diagramTable.addClass('cloud-model-inspected');
                                if (confirm('Delete "' + tableForeignKey + '"?'))
                                    that.removeTable(tableForeignKey);
                                else
                                    diagramTable.removeClass('cloud-model-inspected');
                            }, 500);
                    }
                }
            }
            if (!options.silent)
                that.updateStateOfConnectors();
        },
        moveFieldBefore: function (fieldName, beforeFieldName) {
            this._moveField(fieldName, beforeFieldName, 0);
        },
        moveFieldAfter: function (fieldName, afterFieldName) {
            this._moveField(fieldName, afterFieldName, 1);
        },
        _moveField: function (fieldName, targetFieldName, shiftBy) {
            var that = this,
                fieldGrid = that._fieldGrid,
                rows = fieldGrid.rows(),
                columns = that._model.columns,
                rowIndex, rowIndex2,
                r, c;
            // remove row from array
            rowIndex = fieldGrid.findRowIndex({ FieldName: fieldName });
            r = rows[rowIndex];
            rows.splice(rowIndex, 1);
            c = columns[rowIndex];
            columns.splice(rowIndex, 1);
            // insert row into new position
            rowIndex2 = fieldGrid.findRowIndex({ FieldName: targetFieldName });
            rows.splice(rowIndex2 + shiftBy, 0, r);
            columns.splice(rowIndex2 + shiftBy, 0, c);
            fieldGrid.refresh();
            // indicate "dropped" status
            highlightField(fieldName, fieldGrid);
            modelBuilder_pauseMouseEvents();
        },
        reAssignAliasColumn: function (tableAlias) {
            var that = this,
                model = that._model,
                baseTableAlias = model.alias,
                fk = that._foreignKeyMap[tableAlias],
                rows = that._fieldGrid.rows(),
                fkColumns = [],
                fkRows = [],
                fkAliasField,
                tableAliasFields = [],
                tableAliasRows = [],
                c, c2, columnSpec,
                rowIndex, rowIndex2;
            if (tableAlias === baseTableAlias || !fk || fk.baseForeignKey || fk.type === '1-to-1')
                return;
            $(fk.foreignKey).each(function () {
                fkColumns.push(this.columnName);
            });
            $(rows).each(function () {
                var r = this;
                if (r.TableAlias == baseTableAlias && fkColumns.indexOf(r.ColumnName) != -1) {
                    fkRows.push(r);
                    if (r.AliasFieldName)
                        fkAliasField = r.AliasFieldName;
                }
                if (r.TableAlias == tableAlias) {
                    tableAliasFields.push(r.FieldName);
                    tableAliasRows.push(r);
                }
            });
            if (!fkColumns.length || !tableAliasFields.length || tableAliasFields.lastIndexOf(fkAliasField) != -1 || !fkRows.length)
                return;
            fkRows[0].AliasFieldName = tableAliasFields[0];
            rowIndex = rows.indexOf(fkRows[0]);
            c = model.columns[rowIndex];
            c.aliasColumnName = tableAliasRows[0].ColumnName;
            c.aliasForeignKey = tableAlias;
            if (tableAliasFields.length == 1) {
                // move the alias field next to the foreign key field
                rowIndex2 = rows.indexOf(tableAliasRows[0]);
                c2 = model.columns[rowIndex2];
                rows.splice(rowIndex2, 1);
                model.columns.splice(rowIndex2, 1);
                rows.splice(rowIndex + 1, 0, tableAliasRows[0]);
                model.columns.splice(rowIndex + 1, 0, c2);
            }
            return c.aliasColumnName;
        },
        updateStateOfConnectors: function () {
            var that = this,
                diagram = that._diagram;

            function yieldsField(foreignKey) {
                var result,
                    table = diagram.find('[data-foreign-key="' + foreignKey + '"]'),
                    connectors = diagram.find('[data-connector="' + foreignKey + '"]'),
                    hasColumns = table.find(':input:checked').length;
                if (hasColumns)
                    result = true;
                else
                    $(that._model.foreignKeys).each(function () {
                        var fk = this;
                        if (fk.baseForeignKey == foreignKey)
                            if (yieldsField(fk.id))
                                result = true;
                    });
                if (hasColumns)
                    table.removeClass('cloud-model-table-disabled');
                else
                    table.addClass('cloud-model-table-disabled');
                $(connectors).each(function () {
                    if (result)
                        svgRemoveClass(this, 'cloud-model-connector-disabled');
                    else
                        svgAddClass(this, 'cloud-model-connector-disabled');
                });
                return result;
            }

            $(that._model.foreignKeys).each(function () {
                yieldsField(this.id);
            });
        },
        attach: function (container) {
            $(container).addClass('cloud-model-container').attr({ 'tabindex': 1, 'data-input-container': 'diagram' });
            var that = this,
                containerOffset,
                //x, y,
                originalMouseX,
                originalMouseY;

            function scrolled() {
                containerOffset = container.offset();
                if (containerOffset.left < originalMouseX && originalMouseX < containerOffset.left + container.width() && containerOffset.top < originalMouseY && originalMouseY < containerOffset.top + container.height())
                    $(container).find('[data-table][data-foreign-key]').each(function () {
                        var table = $(this),
                            offset = table.offset();

                        if (offset.left <= mouseX && offset.top <= mouseY && mouseX < (offset.left + table.outerWidth()) && mouseY < (offset.top + table.outerHeight())) {
                            table.trigger('mousemove');
                            return false;
                        }
                    });
            }

            $(container).on('scroll', function (event) {
                revealAllDependencies();
                container.find('[title=""]').trigger('mouseleave');
                $(tooltip).hide();
                originalMouseX = mouseX,
                    originalMouseY = mouseY;
                clearTimeout(scrollTimeout);
                scrollTimeout = setTimeout(scrolled, 300);
            });
            that._diagram = $('<div class="cloud-model-diagram"></div>').appendTo(container).data('builder', that);
            var model = this._model,
                //primaryTable = this.findTableModel(model.baseSchema, model.baseTable),
                t;

            if (model.x == null)
                model.x = diagramMargin;
            if (model.y == null)
                model.y = diagramMargin;

            //x = model.x != null ? model.x : diagramMargin;
            //y = model.y != null ? model.y : diagramMargin;
            t = that.renderBaseTable();
            //t = that.renderTable(primaryTable, model.alias, true);
            //t.css({ left: x, top: y });
            this._right = model.x + t.outerWidth() + tableSpacing;
            this._autoRight = diagramMargin + t.outerWidth() + tableSpacing;
            this._bottom = model.y + t.outerHeight() + tableSpacing;
            this.renderMasterTables(null);
            this._right += -tableSpacing + diagramMargin;
            //this._bottom += -tableSpacing + diagramMargin;
            that._diagram.width(that._right).height(that._bottom);
            // attach SVG canvas
            var canvas = svg({
                type: 'svg',
                width: this._right,
                height: this._bottom,
                children: [
                    {
                        type: 'defs',
                        children: [
                            {
                                type: 'marker',
                                id: 'arrow',
                                markerWidth: 13,
                                markerHeight: 13,
                                refX: 12,
                                refY: 6,
                                orient: 'auto',
                                children: [
                                    {
                                        type: 'path',
                                        d: 'M2,2 L2,11 L10,6 L2,2',
                                        style: 'fill: black'
                                    }
                                ]
                            }/*,
                            {
                                type: 'marker',
                                id: 'arrow-disabled',
                                markerWidth: 13,
                                markerHeight: 13,
                                refX: 12,
                                refY: 6,
                                orient: 'auto',
                                children: [
                                    {
                                        type: 'path',
                                        d: 'M2,2 L2,11 L10,6 L2,2',
                                        style: 'fill: #aaa'
                                    }
                                ]
                            }*/
                        ]
                    }
                ]
            });
            that._diagram[0].appendChild(canvas);
            that._canvas = canvas;
            $(that._model.foreignKeys).each(function () {
                that.connector(this, true);
                //var foreignKey = this;
                //$(foreignKey.foreignKey).each(function () {
                //    var foreignKeyColumn = this,
                //        childTable = foreignKey.baseForeignKey ?
                //            container.find('[data-table][data-foreign-key="' + foreignKey.baseForeignKey + '"]') :
                //            container.find('[data-table="' + that._model.baseTable + '"][data-schema="' + that._model.baseSchema + '"]');
                //    svg({
                //        type: 'path',
                //        parent: canvas,
                //        'data-connector': foreignKey.id,
                //        'class': 'cloud-model-connector',
                //        //style: 'stroke: black;fill:none',
                //        'marker-end': 'url(#arrow)',
                //        title: 'Child Table\t' + toPhysicalTableName(childTable.attr('data-schema'), childTable.attr('data-table')) + '\n' +
                //        'Child Column\t' + foreignKeyColumn.columnName + '\n' +
                //        'Parent Table\t' + toPhysicalTableName(foreignKey.parentTableSchema, foreignKey.parentTableName) + '\n' +
                //        'Parent Column\t' + foreignKeyColumn.parentColumnName + '\n'
                //    })
                //});
            });
            that.updateConnectors();
            // render output columns of the data model
            var list = that._list = $('<div class="cloud-model-list"></div>').insertBefore(container).data('builder', that),
                gOptions = {
                    container: list,
                    showRowNumber: false,
                    setupRow: function (tr, row) {
                        tr.attr('data-field', row.FieldName);
                    },
                    columns: [
                        {
                            name: 'FieldName', text: 'Field', fixed: true, draggable: true, tooltip: 'Provides an identifier for the corresponding table column in the output of SELECT statement.',
                            className: function (row) {
                                var result = '',
                                    tr;
                                if (row['TableAlias'] === that._model.alias && that.findTableModel(row._schema, row._tableName).primaryKey) {
                                    tr = that._diagram.find('.cloud-model-table-base [data-column="' + row.ColumnName + '"]');
                                    if (tr.is('.cloud-model-column-pk'))
                                        result += 'cloud-model-list-field-pk';
                                    if (tr.is('.cloud-model-column-required'))
                                        result += ' cloud-model-list-field-required';
                                }
                                else if ((that._foreignKeyMap[row.TableAlias] || {}).type === '1-to-1') {
                                    tr = that._diagram.find('.cloud-model-table[data-table="' + row._tableName + '"][data-schema="' + row._schema + '"] [data-column="' + row.ColumnName + '"]');
                                    if (tr.is('.cloud-model-column-required'))
                                        result += ' cloud-model-list-field-required';
                                }
                                return result;
                            },
                            // this function is not being used
                            corner2: function (row) {
                                var text,
                                    color,
                                    aliasInfo = that._aliasedMap[row['TableAlias'] + '_' + row['ColumnName']];
                                if (row['TableAlias'] !== that._model.alias) {
                                    text = 'The value of this field is borrowed from "' + row['TableAlias'] + '".';
                                    color = 'cloud-grid-corner-borrowed';
                                }
                                if (aliasInfo) {
                                    text += ' It provides a user-friendly alias for "' + aliasInfo.fieldName + '" field.';
                                    color = 'cloud-grid-corner-alias';
                                }
                                if (text) {
                                    text += ' Borrowed fields are read-only.';
                                    return { text: text, className: color };
                                }
                                return null;
                            }
                        },
                        { name: 'Type', text: 'Data Type', readOnly: true, tooltip: 'Specifies the physical data type of the table column.' },
                        {
                            name: 'Spec', text: 'Spec', readOnly: true, tooltip: 'Provides an abbreviated specification of the data processing properties of the field.',
                            value: function (row) {
                                var text = '',
                                    tooltip = '',
                                    isWritable,
                                    tableAlias = row.TableAlias,
                                    columnName = row.ColumnName,
                                    aliasInfo = that._aliasedMap[tableAlias + '_' + columnName],
                                    tableModel, columnInfo,
                                    modelInfoCell = that._diagram.find('.cloud-model-table-base [data-column="' + columnName + '"] td:first');
                                if (modelInfoCell.length) {
                                    text += modelInfoCell.text();
                                    tooltip += modelInfoCell.attr('title') || '';
                                }
                                if (!tooltip && tableAlias)
                                    tooltip = 'Table\t' + row['TableName'] + '\nColumn\t' + columnName;
                                if (tableAlias == that._model.alias) {
                                    tableModel = that.findTableModel(row._schema, row._tableName);
                                    if (tableModel.primaryKey) {
                                        columnInfo = that.findColumnModel(row._schema, row._tableName, columnName);
                                        if (!columnInfo.readOnly) {
                                            if (text)
                                                text += ', ';
                                            text += 'W';
                                            tooltip += '\nW\tThis field is writeable. Its value will be persisted to the table column in the row matched with the primary key.';
                                        }
                                    }
                                }
                                else if ((that._foreignKeyMap[row.TableAlias] || {}).type === '1-to-1') {
                                    columnInfo = that.findColumnModel(row._schema, row._tableName, columnName);
                                    if (!columnInfo.readOnly) {
                                        isWritable = true;
                                        if (text)
                                            text += ', ';
                                        text += 'W';
                                        tooltip += '\nW\tThis field is writeable. Its value will be persisted to the table column in the row matched with the primary key.';
                                    }
                                }

                                if (!tableAlias && row.SqlFormula) {
                                    if (text)
                                        text += ', ';
                                    text += 'F';
                                    if (tooltip)
                                        tooltip += '\n';
                                    tooltip += 'F\tThe read-only value of this field is a computed SQL formula.';
                                }
                                else if (tableAlias != that._model.alias) {
                                    if (text)
                                        text += ', ';
                                    text += 'B';
                                    if (tooltip)
                                        tooltip += '\n';
                                    tooltip += 'B\tThe ' + (isWritable ? '' : 'read-only ') + 'value of this field is borrowed from "' + tableAlias + '".';
                                }
                                if (aliasInfo && (!text || !text.match(/\bA\b/))) {
                                    if (text)
                                        text += ', ';
                                    text += 'A';
                                    if (tooltip)
                                        tooltip += '\n';
                                    tooltip += 'A\tProvides a user-friendly alias for "' + aliasInfo.fieldName + '" field.';
                                }
                                return text || tooltip ? { text: text, tooltip: tooltip } : null;
                            }
                        },
                        { name: 'Label', text: 'Label', tooltip: 'Defines a user-friendly label assigned to the field.' },
                        { name: 'Format', text: 'Format', tooltip: 'Defines a data format string for the field value.' },
                        { name: 'SortType', text: 'Sort Type', tooltip: 'Defines an optional ascending or descending sort type for the field.', minWidth: 80 },
                        { name: 'SortOrder', text: 'Sort Order', tooltip: 'Defines a position of the field in an optional sort expression.' },
                        { name: 'AliasFieldName', text: 'Alias', tooltip: 'Defines an alternative field that will have its value presented to a user instead of the physical field value.', minWidth: 80 },
                        {
                            name: 'SqlFormula', text: 'SQL Formula', maxWidth: 300,
                            readOnly: function (row) {
                                return true;
                                //return !!row.TableAlias;
                            },
                            tooltip: 'Defines an optional SQL expression that will be evaluated by the database engine to produce a field value.'
                        },
                        { name: 'TableAlias', text: 'Table Alias', readOnly: true, tooltip: 'Specifies the alias name of the database table in the SELECT statement that contains the base column of the field.' },
                        { name: 'TableName', text: 'Table Name', readOnly: true, tooltip: 'Specifies the name of the database table that contains the base column of the field.' },
                        { name: 'ColumnName', text: 'Column', readOnly: true, tooltip: 'Specifies the name of the column in the database table that provides the field value.' }
                    ],
                    rows: []
                },
                grid;


            $(model.columns).each(function (index) {
                var c = this,
                    fieldName = c.fieldName || c.name,
                    aliasColumn = c.aliasColumnName ? that._aliasMap[(c.aliasForeignKey || model.alias) + '_' + c.aliasColumnName] : null,
                    aliasFieldName = aliasColumn && (aliasColumn.fieldName || aliasColumn.name),
                    foreignKey = that._foreignKeyMap[c.foreignKey],
                    tableName = foreignKey ? toPhysicalTableName(foreignKey.parentTableSchema, foreignKey.parentTableName) : toPhysicalTableName(model.baseSchema, model.baseTable),
                    tableAlias = (foreignKey ? foreignKey.id : model.alias),
                    aliasedTableName = (foreignKey ? foreignKey.id : model.alias) + ' (' + tableName + ')',
                    tname = foreignKey ? foreignKey.parentTableName : model.baseTable,
                    tschema = foreignKey ? foreignKey.parentTableSchema : model.baseSchema,
                    tableModel = that.findTableModel(tschema, tname),
                    row,
                    columnModel = that.findColumnModel(tschema, tname, c.name),
                    columnLen;
                row = columnModel ?
                    {
                        'FieldName': fieldName,
                        'AliasFieldName': aliasFieldName,
                        'TableAlias': tableAlias,
                        'TableName': tableName,
                        'ColumnName': c.name,
                        'Type': toDataType(columnModel),
                        //_type: columnModel.dataType,
                        _tableName: tname,
                        _schema: tschema
                    } :
                    {
                        'FieldName': fieldName,
                        'AliasFieldName': aliasFieldName,
                        'Type': c.type,
                        'SqlFormula': c.formula
                    };
                row.Label = c.label;
                if (c.format)
                    row.Format = c.format;
                if (c.sortOrder)
                    row.SortOrder = c.sortOrder;
                if (c.sortType)
                    row.SortType = c.sortType;

                gOptions.rows.push(row);
            });

            grid = new CloudOnTime.Utilities.grid(gOptions)
            that._fieldGrid = grid;
            grid.attach();
            grid._grid.attr('tabindex', 1);

            // create draggable divider
            var listHeight = list.outerHeight(true),
                divider = $('<div class="cloud-divider-horizontal"></div>').insertBefore(container).css('top', listHeight);
            container.css('top', listHeight + divider.outerHeight(true));
            that.masterDetail(that._masterDetail)
        },
        connector: function (foreignKey, enable) {
            var that = this,
                removeList = [],
                connectorElement = that._diagram.find('[data-connector="' + foreignKey.id + '"]');
            $(foreignKey.foreignKey).each(function () {
                var foreignKeyColumn = this,
                    //childTable = foreignKey.baseForeignKey ?
                    //    diagram.find('[data-table][data-foreign-key="' + foreignKey.baseForeignKey + '"]') :
                    //    diagram.find('[data-table="' + that._model.baseTable + '"][data-schema="' + that._model.baseSchema + '"]'),
                    baseFK = foreignKey.baseForeignKey ? that._foreignKeyMap[foreignKey.baseForeignKey] : null,
                    schema = baseFK ? baseFK.parentTableSchema : that._model.baseSchema/* childTable.attr('data-schema')*/,
                    tableName = baseFK ? baseFK.parentTableName : that._model.baseTable/*childTable.attr('data-table')*/;
                if (!enable)
                    connectorElement.remove();
                else if (!connectorElement.length)
                    svg({
                        type: 'path',
                        parent: that._canvas,
                        'data-connector': foreignKey.id,
                        'data-parent-column': foreignKeyColumn.parentColumnName,
                        'class': 'cloud-model-connector',
                        //style: 'stroke: black;fill:none',
                        'marker-end': 'url(#arrow)',
                        title: 'Child Table\t' + toPhysicalTableName(schema, tableName) + '\n' +
                            'Child Column\t' + foreignKeyColumn.columnName + '\n' +
                            'Parent Table\t' + toPhysicalTableName(foreignKey.parentTableSchema, foreignKey.parentTableName) + '\n' +
                            'Parent Column\t' + foreignKeyColumn.parentColumnName + '\n'
                    })
            });
        },
        scale: function (scale) {
            var that = this,
                diagram = that._diagram;
            if (typeof scale == 'boolean')
                diagram.css('transform', scale ? ('scale(' + that._scaleRatio + ')') : '')
            else {
                var detailsPanel = $('.cloud-model-panel-masterdetail'),
                    windowWidth = $window.width() - (detailsPanel.is(':visible') ? detailsPanel.outerWidth(true) : 0),
                    diagramWidth = that._right;
                if (scale)
                    that._scale = scale;
                else
                    scale = that._scale || 'Auto Scale';
                if (scale && scale !== '100%' && !(scale === 'Auto Scale' && windowWidth > diagramWidth)) {
                    if (scale === 'Fit Width' || scale === 'Auto Scale' || !scale)
                        scale = (windowWidth - diagramMargin) / diagramWidth;
                    else
                        scale = parseInt(scale.toString()) / 100;
                    that._scaleRatio = scale;
                    that.scale(true);
                }
                else {
                    that._scaleRatio = 1;
                    that.scale(false);
                }
            }
        },
        updateConnectors: function (filter) {
            var that = this,
                queue = [];

            function r(value) {
                return Math.ceil(value);
            }

            $(that._model.foreignKeys).each(function () {
                var foreignKey = this,
                    foreignKeyId = foreignKey.id,
                    foreignKeyBase = foreignKey.baseForeignKey;
                if (!filter || (filter.indexOf(foreignKeyBase || '') >= 0 || filter.indexOf(foreignKeyId) >= 0)) {
                    var
                        dragData = dragEvent && dragEvent.data.connectors,
                        container = that._diagram,
                        parentTable,
                        childTable,
                        lines,
                        horizontalOffset = container.offset().left,
                        verticalOffset = container.scrollTop() - container.offset().top;

                    if (dragEvent && !dragData)
                        dragData = dragEvent.data.connectors = {
                            parentTables: {},
                            parentTableColumns: {},
                            childTables: {},
                            childTableColumns: {},
                            lines: {}
                        }

                    if (dragEvent) {
                        parentTable = dragData.parentTables[foreignKeyId];
                        childTable = dragData.childTables[foreignKeyBase || '__base'];
                        if (dragEvent.type != 'column')
                            lines = dragData.lines[foreignKeyId];
                    }
                    if (!parentTable) {
                        parentTable = container.find('.cloud-model-table[data-foreign-key="' + foreignKeyId + '"]');
                        if (dragData) {
                            dragData.parentTables[foreignKeyId] = parentTable;
                            dragData.parentTableColumns[foreignKeyId] = {};
                        }
                    }
                    if (!childTable) {
                        childTable = container.find(foreignKeyBase ? ('.cloud-model-table[data-foreign-key="' + foreignKeyBase + '"]') : '.cloud-model-table-base');
                        if (dragData) {
                            dragData.childTables[foreignKeyBase || '__base'] = childTable;
                            dragData.childTableColumns[foreignKeyBase || '__base'] = {};
                        }
                    }
                    if (!lines) {
                        lines = container.find('[data-connector="' + foreignKeyId + '"]');
                        if (dragData)
                            dragData.lines[foreignKeyId] = lines;
                    }

                    $(foreignKey.foreignKey).each(function (index) {
                        var foreignKeyColumn = this,
                            line = lines.get(index),
                            childColumn = dragData ? dragData.childTableColumns[foreignKeyBase || '__base'][foreignKeyColumn.columnName] : null,
                            childColumnOffset,
                            parentColumn = dragData ? dragData.parentTableColumns[foreignKeyId][foreignKeyColumn.parentColumnName] : null,
                            parentColumnOffset,
                            pathInfo,
                            x1, y1, x2, y2,
                            path;

                        if (!childColumn) {
                            childColumn = childTable.find('[data-column="' + foreignKeyColumn.columnName + '"]');
                            if (dragData)
                                dragData.childTableColumns[foreignKeyBase || '__base'][foreignKeyColumn.columnName] = childColumn;
                        }
                        childColumnOffset = childColumn.offset();

                        if (!parentColumn) {
                            parentColumn = parentTable.find('[data-column="' + foreignKeyColumn.parentColumnName + '"]');
                            if (dragData)
                                dragData.parentTableColumns[foreignKeyId][foreignKeyColumn.parentColumnName] = parentColumn;
                        }
                        parentColumnOffset = parentColumn.offset();

                        if ((childColumnOffset.left + childColumn.outerWidth() / 2) < parentColumnOffset.left)
                            pathInfo = { start: 'right', end: 'left' };
                        else if ((parentColumnOffset.left + parentColumn.outerWidth() / 2) < childColumnOffset.left)
                            pathInfo = { start: 'left', end: 'right' };
                        else
                            pathInfo = { start: 'left', end: 'left' };

                        x1 = pathInfo.start == 'right' ? (childColumnOffset.left + childColumn.outerWidth() - horizontalOffset) : (childColumnOffset.left - 1 - horizontalOffset);
                        y1 = childColumnOffset.top + verticalOffset + childColumn.outerHeight() / 2;
                        x2 = pathInfo.end == 'left' ? (parentColumnOffset.left - 1 - horizontalOffset) : (parentColumnOffset.left + parentColumn.outerWidth() - horizontalOffset);
                        y2 = parentColumnOffset.top + verticalOffset + parentColumn.outerHeight() / 2;
                        path = 'M' + r(x1) + ',' + r(y1) + ' L' + r(x1 + (pathInfo.start == 'right' ? 8 : -8)) + ',' + r(y1) + ' L' + r(x2 + (pathInfo.end == 'left' ? -20 : 20)) + ',' + r(y2) + ' L' + r(x2) + ',' + r(y2);
                        queue.push({
                            element: line,
                            d: path
                        });
                    });
                }
            });

            function drawQueue() {
                that.scale(false);
                $(queue).each(function () {
                    svg(this);
                });
                that.scale(true);
            }

            if (dragEvent && dragEvent.type == 'column')
                drawQueue();
            else
                requestAnimationFrame(drawQueue);

            if (!filter)
                that.updateStateOfConnectors();
        },
        columnSpec: function (schema, tableName, columnName, tableAlias) {
            var that = this,
                text = '',
                tooltip = '',
                nameTooltip,
                tableData = that._modelMap[schema + '_' + tableName],
                primaryKey = tableData.primaryKey,
                foreignKeys = tableData.foreignKeys,
                fkInfo, fk, fkParentColumnName, a, c, fkColumns, primaryKeyFlag, foreignKeyFlag,
                pkColumn = primaryKey[columnName];
            if (pkColumn) {
                text = pkColumn.isVirtual ? 'VPK' : 'PK';
                tooltip = pkColumn.isVirtual ? 'VPK\tDefines the virtual primary key.' : 'PK\tDefines the primary key.';
                primaryKeyFlag = true;
            }
            fk = foreignKeys[columnName];
            if (fk) {
                foreignKeyFlag = true;
                if (text.length)
                    text += ', ';
                fktext = 'FK' + (fk.index + 1);
                text += fktext;
                if (tooltip)
                    tooltip += '\n';
                $(fk.info.foreignKey).each(function () {
                    if (this.columnName == columnName) {
                        fkParentColumnName = this.parentColumnName;
                        return false;
                    }
                });
                tooltip += fktext + '\tDefines the foreign key referencing "' +
                    fkParentColumnName + '" column of "'
                    + toPhysicalTableName(fk.info.parentTableSchema, fk.info.parentTableName) + '" table.\n';
            }
            a = that._aliasedMap[tableAlias + '_' + columnName];
            if (a) {
                if (text.length)
                    text += ', ';
                text += 'A';
                if (tooltip)
                    tooltip += '\n';
                tooltip += 'A\t' + 'Provides a user-friendly alias for ';
                var afk = that._foreignKeyMap[a.aliasForeignKey];
                if (afk) {
                    fkColumns = afk.foreignKey;
                    $(fkColumns).each(function (index) {
                        if (index > 0)
                            if (index == fkColumns.length - 1)
                                tooltip += ' and ';
                            else
                                tooltip += ', ';
                        tooltip += '"' + this.columnName + '"';
                    });

                    tooltip += ' column' + (fkColumns.length > 1 ? 's' : '');
                    tooltip += ' of "' + (a.foreignKey || that._model.alias) + '".\n'
                }
                else
                    tooltip += '"' + a.fieldName + '" field.';
            }

            c = that._fieldMap[(tableAlias || that._model.alias) + '_' + columnName];
            if (c)
                nameTooltip = 'Table\t' + toPhysicalTableName(schema, tableName) + '\nColumn\t' + columnName + '\nField\t' + (c.fieldName || c.name);
            if (text)
                tooltip = 'Table\t' + toPhysicalTableName(schema, tableName) + '\nColumn\t' + columnName + '\n' + tooltip;
            return { text: text, tooltip: tooltip, pk: primaryKeyFlag, fk: foreignKeyFlag, nameTooltip: nameTooltip };
        },
        renderBaseTable: function () {
            var that = this,
                model = that._model,
                primaryTable = that.findTableModel(model.baseSchema, model.baseTable),
                existingTable = that._diagram.find('.cloud-model-table-base'),
                t = existingTable.length ? existingTable : that.renderTable(primaryTable, model.alias, true);
            t.css({ left: model.x, top: model.y });
            return t;
        },
        renderMasterTables: function (baseForeignKey) {
            var that = this,
                processedKeys = [],
                x = that._autoRight,
                y = diagramMargin,
                w = 0;
            $(that._model.foreignKeys).each(function () {
                var fk = this;
                if (this.baseForeignKey == baseForeignKey) {
                    if (y > 1000) {
                        y = diagramMargin;
                        x = that._autoRight + tableSpacing;
                    }
                    var existingTable = that._diagram.find('[data-foreign-key="' + fk.id + '"]'),
                        t = existingTable.length ? existingTable : that.renderTable(that.findTableModel(fk.parentTableSchema, fk.parentTableName), fk.id),
                        newRight, newBottom;
                    if (fk.x == null)
                        fk.x = x;
                    else
                        x = fk.x;
                    if (fk.y != null)
                        y = fk.y;
                    t.css({ left: x, top: y }).attr('data-foreign-key', fk.id);
                    y += t.outerHeight() + tableSpacing;
                    newRight = x + t.outerWidth() + tableSpacing;
                    if (newRight > that._right)
                        that._right = newRight;
                    newBottom = y;
                    that._autoRight = Math.max(that._autoRight, x + t.outerWidth() + tableSpacing);
                    that._bottom = Math.max(that._bottom, y - tableSpacing + diagramMargin);
                    processedKeys.push(this.id);
                }
            });
            $(processedKeys).each(function () {
                that.renderMasterTables(this);
            });
        },
        findTableModelInfo: function (schema, name) {
            return this._modelMap[schema + '_' + name];
        },
        findTableModel: function (schema, name) {
            return this.findTableModelInfo(schema, name).tableModel;
        },
        findColumnModel: function (schema, tableName, columnName) {
            return this._columnMap[schema + '_' + tableName + '_' + columnName];
        },
        renderTable: function (tableModel, foreignKey, isPrimary) {
            var that = this,
                tableName,
                tableNameSpan,
                tableFkList = [],
                t = $('<table class="cloud-model-table"></table>').appendTo(this._diagram).attr({
                    'data-table': tableModel.name,
                    'data-schema': tableModel.schema
                }),
                primaryKey = that.findTableModelInfo(tableModel.schema, tableModel.name).primaryKey,
                pkColumns = [],
                dataColumns = [];
            tableName = tableModel.schema;

            if (tableName == 'dbo')
                tableName = '';
            else if (tableName)
                tableName += '.'
            tableName += tableModel.name;
            var tableHeader = $('<th colspan="3" data-input="text" data-input-tab-stop="false"/>').appendTo($('<tr/>').appendTo(t)),
                tableNameSpan = $('<span data-input-hotspot="true"/>').appendTo(tableHeader).text(tableName);
            if (foreignKey && foreignKey != tableName) {
                tableHeader.css('maxWidth', tableHeader.width() * 1.1);
                tableName = foreignKey + ' (' + tableName + ')';
                tableNameSpan.text(tableName);
            }
            if (isPrimary)
                t.addClass('cloud-model-table-base');

            tableHeader.attr({
                'title': ('Table:\t' + toPhysicalTableName(tableModel.schema, tableModel.name)) + (foreignKey ? ('\nAlias:\t' + foreignKey) : '')
            });

            function renderTableColumn(column) {
                var tr = $('<tr class="cloud-model-column"/>').appendTo(t).attr('data-column', column.name),
                    td,
                    spec = that.columnSpec(tableModel.schema, tableModel.name, column.name, foreignKey);

                td = $('<td class="cloud-model-column-spec"/>').appendTo(tr);
                if (spec.pk)
                    tr.addClass('cloud-model-column-pk');
                if (spec.fk)
                    tr.addClass('cloud-model-column-fk');
                if (spec.text) {
                    td.text(spec.text);
                    td.attr('title', spec.tooltip);
                }
                td = $('<td class="cloud-model-column-name" draggable="true"/>').appendTo(tr);
                var checked = that._fieldMap[(isPrimary ? that._model.alias : foreignKey) + '_' + column.name] != null,
                    input = $('<input type="checkbox" />').appendTo(td);
                if (checked) {
                    tr.addClass('cloud-model-column-selected');
                    input.prop('checked', true);
                }
                $('<span/>').appendTo(td).text(column.name);
                if (spec.nameTooltip)
                    td.attr('title', spec.nameTooltip);
                var columnType = toDataType(column);
                $('<td  class="cloud-model-column-type"/>').appendTo(tr).text(columnType);
                if (column.allowNulls == false)
                    tr.addClass('cloud-model-column-required');
                $(t);
                return tr;
            }

            $(tableModel.columns).each(function (index) {
                if (primaryKey[this.name])
                    pkColumns.push(renderTableColumn(this));
            });
            if (tableModel.primaryKey && tableModel.primaryKey.length && tableModel.primaryKey.length < tableModel.columns.length)
                $('<tr class="cloud-model-column-separator"><td colspan="3"/></tr>').appendTo(t);
            $(tableModel.columns).each(function () {
                if (!primaryKey[this.name])
                    dataColumns.push(renderTableColumn(this));
            });

            toggleOptionalTableColumns(t, true);

            return t;
        },
        arrange: function () {
            var that = this,
                model = that._model,
                diagram = that._diagram,
                primaryTable = diagram.find('.cloud-model-table-base');
            that.scale(false);
            primaryTable.css({ left: diagramMargin, top: diagramMargin });
            that._autoRight = that._right = diagramMargin + primaryTable.outerWidth() + tableSpacing;
            that._bottom = diagramMargin + primaryTable.outerHeight();
            model.x = diagramMargin;
            model.y = diagramMargin;
            $(model.foreignKeys).each(function () {
                var fk = this;
                fk.x = null;
                fk.y = null;
            });
            that.renderMasterTables();
            that.updateConnectors();
            that.scale(true);
            diagram.parent().scrollLeft(0).scrollTop(0);
        },
        findTableElement: function (options) {
            return this._diagram.find(options.name ? ('.cloud-model-table[data-schema="' + options.schema + '"][data-table="' + options.name + '"]') : ('[data-foreign-key="' + options.foreignKey + '"]'));
        },
        quotedName: function (name) {
            if (name.match(/\s/)) {
                var quote = this._database.quote;
                name = quote + name + quote;
            }
            return name;
        },
        field: function (name) {
            name = name.toLowerCase();
            var that = this,
                result = { row: null, column: null, index: -1 };
            $(that._model.columns).each(function (index) {
                var c = this;
                if (c.fieldName.toLowerCase() == name) {
                    result.index = index;
                    result.column = c;
                    result.row = that._fieldGrid.rows()[index];
                    return false;
                }
            });
            return result;
        },
        whereClause: function (enable) {
            var that = this;
            if (arguments.length)
                if (enable)
                    that.formulaField({ fieldName: '_where_clause_', formula: that._model.where });
                else
                    that.formulaField(false);
            else
                return !!that._model.where;
        },
        formulaField: function (options) {
            var that = this,
                listContainer = that._list,
                fieldGrid = listContainer.find('.cloud-grid'),
                formulaPanel = listContainer.find('.cloud-model-panel-formula'),
                formulaText, formulaInfo,
                editor, hints = {}, fieldName, fieldIndex;

            function fieldNameInput() {
                return formulaPanel.find('.cloud-model-formula-field :text');
            }

            function formulaEditor() {
                return formulaPanel.data('editor');
            }

            function isWhereClause() {
                var options = formulaPanel.data('options'),
                    fieldName = options && options.fieldName;
                return fieldName && fieldName == '_where_clause_';
            }

            function verify() {
                var result = true,
                    input = fieldNameInput(),
                    text = input.val().trim(),
                    editor = formulaEditor(),
                    formula = editor.getDoc().getValue(),
                    options = formulaPanel.data('options'),
                    success = that.validateFieldName(text, options && options.fieldName ? [options.fieldName] : null);
                if (success != true) {
                    alert(success);
                    result = false;
                    input.focus();
                }
                else if (!formula) {
                    result = false;
                    alert('SQL forumula cannot be blank.');
                    editor.focus();
                }
                if (result == true)
                    if (that.hosted()) {
                        formulaInfo = window.external.ValidateFormula(formula);
                        if (formulaInfo.match(/^success,/)) {
                            result = true;
                            formulaInfo = formulaInfo.split(/,/g);
                        }
                        else {
                            alert(formulaInfo);
                            editor.focus();
                            result = false;
                        }
                    }
                    else
                        formulaInfo = ['success', 'Decimal*', 'money*']; //['success', 'String', '<formula>'];
                return result;
            }

            if (!arguments.length)
                return formulaPanel.length > 0 && formulaPanel.is(':visible');


            if (typeof options == 'boolean' || options.newFieldName || options.fieldName) {
                if (!formulaPanel.length) {
                    if (options === false)
                        return;
                    formulaPanel = $('<div class="cloud-model-panel cloud-model-panel-formula"></div>').appendTo(listContainer).height(fieldGrid.outerHeight(true))
                        .on('click', '.cloud-model-formula-cancel', function () {
                            that.formulaField(false);
                        }).on('click', '.cloud-model-formula-verify', function () {
                            if (verify() == true) {
                                alert('Success.');
                                editor.focus();
                            }
                        })
                        .on('click', '.cloud-model-formula-save', function () {
                            if (isWhereClause()) {
                                var editor = formulaEditor(),
                                    whereClause = editor.getDoc().getValue().trim(),
                                    originalWhereClause = whereClause,
                                    paramRegex = new RegExp(that._database.parameterMarker + '([\\w\\d\\_]+?)\\b', 'g'),
                                    paramMatch, paramList = [];
                                if (!whereClause) {
                                    delete that._model.where;
                                    that.formulaField(false);
                                }
                                else {
                                    paramMatch = paramRegex.exec(whereClause);
                                    if (paramMatch) {
                                        while (paramMatch) {
                                            if (paramList.indexOf(paramMatch[0]) == -1)
                                                paramList.push(paramMatch[0]);
                                            paramMatch = paramRegex.exec(whereClause);
                                        }
                                        $(paramList).each(function () {
                                            var p = this,
                                                r = new RegExp('\\n-- ' + p + ' = .+(\\n|$)');
                                            if (!whereClause.match(r)) {
                                                if (!whereClause.match(/\n-- .+$/))
                                                    whereClause += '\n';
                                                whereClause += '\n-- ' + p + ' = null';
                                            }
                                        });
                                    }
                                    if (whereClause != originalWhereClause) {
                                        alert('Please define parameter values by editing the values in the comment.');
                                        editor.getDoc().setValue(whereClause);
                                        editor.focus();
                                    }
                                    else {
                                        var whereTest = !that.hosted() || window.external.ValidateWhereClause(whereClause);
                                        if (whereTest == true) {
                                            that._model.where = whereClause;
                                            that.formulaField(false);
                                        }
                                        else {
                                            alert(whereTest);
                                            editor.focus();
                                        }
                                    }
                                }
                            }
                            else if (verify() == true) {
                                var fieldGrid = that._fieldGrid,
                                    rows = fieldGrid.rows(),
                                    fieldName = fieldNameInput().val().trim(),
                                    fieldLabel = that.fieldNameToLabel(fieldName),
                                    formula = formulaEditor().getDoc().getValue(),
                                    f,
                                    options = formulaPanel.data('options'),
                                    dataFormatString = toFormat({ name: fieldName, type: formulaInfo[2], dataType: formulaInfo[1] });
                                if (options.fieldName) {
                                    // existing field
                                    f = that.field(options.fieldName);
                                    if (toFormat({ name: options.fieldName, type: f.column.type, dataType: f.column.dataType }) == f.column.format) {
                                        f.column.format = dataFormatString;
                                        f.row.Format = dataFormatString;
                                    }
                                    f.column.fieldName = fieldName;
                                    f.column.formula = formula;
                                    f.column.dataType = formulaInfo[1];
                                    f.column.type = formulaInfo[2];
                                    f.row.FieldName = fieldName;
                                    f.row.SqlFormula = formula;
                                    f.row.DataType = formulaInfo[1];
                                    f.row.Type = formulaInfo[2];
                                    if (that.fieldNameToLabel(options.fieldName) == f.row.Label) {
                                        f.column.label = fieldLabel;
                                        f.row.Label = fieldLabel;
                                    }
                                }
                                else {
                                    // new field
                                    rows.push({ FieldName: fieldName, Label: fieldLabel, Type: formulaInfo[2], DataType: formulaInfo[1], SqlFormula: formula, Format: dataFormatString });
                                    that._model.columns.push({ _type: 'column', fieldName: fieldName, formula: formula, type: formulaInfo[2], dataType: formulaInfo[1], label: fieldLabel, format: dataFormatString });
                                }
                                fieldGrid.refresh();
                                that.formulaField(false);
                                modelBuilder_showFieldOnDiagram(fieldName);
                            }
                        });
                    $('<div class="cloud-model-formula-field"><input type="text"/></div>').appendTo(formulaPanel).find(':text');
                    formulaText = $('<div class="cloud-model-formula-text"></div>').appendTo(formulaPanel);
                    $('<button class="cloud-model-formula-verify">Verify</button>').appendTo(formulaPanel);
                    $('<button class="cloud-model-formula-save">Save</button>').appendTo(formulaPanel);
                    $('<button class="cloud-model-formula-cancel">Cancel</button>').appendTo(formulaPanel);

                    // http://stackoverflow.com/questions/13744176/codemirror-autocomplete-after-any-keyup
                    //$(that._database.dataModel).each(function () {
                    //    var table = this;
                    //    columns = [];
                    //    $(table.columns).each(function () {
                    //        columns.push(that.quotedName(this.name));
                    //    });
                    //    tablesHint[that.quotedName(table.name)] = columns;
                    //});

                    formulaPanel.data('hints', hints);

                    //tablesHint["@BusinessRules_PreventDefault"] = [];

                    editor = new CodeMirror(formulaText[0], {
                        mode: 'text/x-mssql',
                        indentWithTabs: true,
                        dragDrop: false,
                        smartIndent: true,
                        lineNumbers: true,
                        matchBrackets: true,
                        autofocus: false,
                        readOnly: false,
                        extraKeys: { 'Ctrl-Space': 'autocomplete' },
                        hint: CodeMirror.hint.sql,
                        hintOptions: {
                            tables: hints/*{
                                "table1": ["col_A", "col_B", "col_C"],
                                "table2": ["other_columns1", "other_columns2"]
                            }*/
                        }
                    });
                    //editor.on("keyup", function (cm, event) {
                    //    if (!cm.state.completionActive && /*Enables keyboard navigation in autocomplete list*/
                    //        event.keyCode != 13) {        /*Enter - do not open autocomplete list just after item has been selected in it*/
                    //        CodeMirror.commands.autocomplete(cm, null, { completeSingle: false });
                    //    }
                    //});
                    formulaPanel.data('editor', editor);
                }
                if (options) {
                    if (that.addTable())
                        that.addTable(false);
                    formulaPanel.data('options', options);
                    hints = formulaPanel.data('hints');
                    for (var key in hints)
                        delete hints[key];

                    function enumerateTableColumns(schema, table, alias) {
                        var tableModel = that.findTableModel(schema, table),
                            columns = [];
                        $(tableModel.columns).each(function () {
                            columns.push(this.name);
                        });
                        hints[alias] = columns;
                    }

                    function registerParameter(paramName) {
                        hints[that._database.parameterMarker + paramName] = [];
                    }

                    enumerateTableColumns(that._model.baseSchema, that._model.baseTable, that._model.alias);
                    $(that._model.foreignKeys).each(function () {
                        var fk = this;
                        enumerateTableColumns(fk.parentTableSchema, fk.parentTableName, fk.id);
                    });
                    registerParameter('BusinessRules_UserId');
                    registerParameter('BusinessRules_UserName');
                    registerParameter('BusinessRules_PROPERTY');
                    registerParameter('Session_VARIABLE');
                    registerParameter('Url_PARAMETER');

                    fieldGrid.css('visibility', 'hidden');
                    formulaPanel.show();

                    fieldName = options && (options.newFieldName || options.fieldName) || 'Field';
                    if (options && !options.fieldName) {
                        fieldIndex = 1;
                        while (that.validateFieldName(fieldName + fieldIndex) != true && fieldIndex < 100)
                            fieldIndex++;
                        fieldName += fieldIndex;
                    }

                    fieldNameInput().val(fieldName).data('fieldName', fieldName);
                    if (isWhereClause()) {
                        formulaPanel.addClass('cloud-model-panel-formula-where');
                        fieldNameInput().val('WHERE').prop('readonly', true);
                    }
                    else {
                        formulaPanel.removeClass('cloud-model-panel-formula-where');
                        fieldNameInput().prop('readonly', null).parent();
                    }
                    editor = formulaEditor();
                    editor.getDoc().setValue(options && options.formula || '');
                    editor.focus();
                }
                else {
                    fieldGrid.css('visibility', '');
                    formulaPanel.hide();
                }
                if (that.hosted()) {
                    if (isWhereClause()) {
                        window.external.UIState('WhereClause', options != false);
                        window.external.UIState('FormulaField', false);
                    }
                    else {
                        window.external.UIState('FormulaField', options);
                        window.external.UIState('WhereClause', false);
                    }
                }
            }
        },
        toModelName: function (modelName) {
            modelName = this.clearnIdentifier(modelName);
            var modelIndex = 0,
                newModelName = modelName;
            //while (window.external.ValidateModelName(newModelName, true)) {
            //    modelIndex++;
            //    newModelName = modelName + modelIndex;
            //}
            return newModelName;
        },
        toFieldName: function (fieldName) {
            var that = this,
                fieldNameIndex = 0,
                result;
            result = fieldName = that.clearnIdentifier(fieldName);
            while (that.validateFieldName(result, null, true) !== true) {
                fieldNameIndex++;
                result = fieldName + fieldNameIndex.toString();
            }
            return result;
        },

        masterDetail: function (options) {
            var that = this,
                listContainer = that._list,
                panelWidth,
                detailsPanel = $('.cloud-model-panel-masterdetail'),
                model = that._model,
                details = model.details,
                table, foreignKey;

            if (!arguments.length)
                return detailsPanel.length && detailsPanel.is(':visible');

            if (typeof options == 'boolean') {
                if (!detailsPanel.length) {
                    if (options === false)
                        return;
                    detailsPanel = $('<div class="cloud-model-panel-masterdetail"></div>').appendTo('body').data('builder', that);//.height(fieldGrid.outerHeight(true));

                }
                if (options) {
                    detailsPanel.show();
                    panelWidth = detailsPanel.outerWidth(true);
                    listContainer.css('right', panelWidth);
                    $('.cloud-model-container').css('margin-right', panelWidth);
                    that.updateMasterDetailInfo(detailsPanel);
                }
                else {
                    detailsPanel.hide();
                    listContainer.css('right', '');
                    $('.cloud-model-container').css('margin-right', '');
                }
                if (that.hosted())
                    window.external.UIState('MasterDetail', options)
                that.scale();
            }
            else if (options.suggestion) {

                if (!details)
                    details = model.details = [];
                table = options.suggestion.table;
                if (window.external.Confirm('The detail relationship with the model "' + that.toModelName(table.name) + '" will be created.\n\nProceed?')) {

                    var filterFields = [],
                        newDetail;
                    table.foreignKeys[options.suggestion.foreignKeyIndex].foreignKey.forEach(function (fk) {
                        filterFields.push(fk.columnName);
                    });
                    newDetail = { _type: 'detail', fieldName: that.toFieldName(table.name), model: that.toModelName(table.name), filterFields: filterFields.join(), create: true, edit: true };
                    details.push(newDetail);
                    //that.updateMasterDetailInfo();
                    var tableName = table.schema;
                    if (tableName)
                        tableName += '.';
                    tableName += table.name;
                    if (newDetail.model === window.external.ModelName || !window.external.CreateOrUseExistingModel(newDetail.model, tableName))
                        that.updateMasterDetailInfo();
                }
            }
            else if (options.model)
                window.external.OpenModel(options.model);
            else if (options.detail != null) {
                switch (options.action) {
                    case 'show':
                        that.showDetail(options.detail)
                        break;

                }
            }
        },
        showDetail: function (detailIndex) {
            $('.cloud-model-detail').remove();
            var that = this,
                detailList = that._model.details,
                detail = detailList[detailIndex],
                content = [];
            content.push('<div class="cloud-model-detail" data-input-container="detail" data-detail-index="', detailIndex, '">');
            content.push('<div class="cloud-model-toolbar">',
                '<i class="material-icon' + (detailIndex == 0 ? detailList.length === 1 ? ' app-hidden' : ' app-disabled' : '') + '" title="Move Up" data-action="up">arrow_upward</i>',
                '<i class="material-icon' + (detailIndex == detailList.length - 1 ? detailList.length === 1 ? ' app-hidden' : ' app-disabled' : '') + '" title="Move Down" data-action="down">arrow_downward</i>',
                '<i class="material-icon" title="Delete" data-action="delete">delete</i></div>');
            content.push('<div class="cloud-input-label">Name:</div>');
            content.push('<div class="cloud-input-value" data-input="text" data-field="fieldName"><span class="cloud-input-inner">', htmlEncode(detail.fieldName), '</span></div>');
            content.push('<div class="cloud-input-label">Label:</div>');
            content.push('<div class="cloud-input-value', isNullOrEmpty(detail.label) ? ' cloud-empty' : '', '" data-input="text" data-field="label"><span class="cloud-input-inner">', htmlEncode(isNullOrEmpty(detail.label) ? 'none' : detail.label), '</span></div>');
            content.push('<div class="cloud-input-label">Tab:</div>');
            content.push('<div class="cloud-input-value', isNullOrEmpty(detail.tab) ? ' cloud-empty' : '', '" data-input="text" data-field="tab"><span class="cloud-input-inner">', htmlEncode(isNullOrEmpty(detail.tab) ? 'none' : detail.tab), '</span></div>');
            content.push('<div>',
                '<span class="cloud-checkbox" data-field="flow">',
                '<i class="material-icon">', toCheckboxIcon(detail.flow), '</i>Start a new row in the display flow.</span>',
                '</span><br/>',
                '<span class="cloud-checkbox" data-field="edit" title="Details can be entered while\nediting an existing master.">',
                '<i class="material-icon">', toCheckboxIcon(detail.edit), '</i>Edit</span>',
                '</span>',
                '<span class="cloud-checkbox" data-field="create" title="Details can be entered\nwith the new master.">',
                '<i class="material-icon">', toCheckboxIcon(detail.create), '</i>Create</span>',
                '</span>',
                '<span class="cloud-checkbox" data-field="list" title="Details are available when\na master is selected in the list.">',
                '<i class="material-icon">', toCheckboxIcon(detail.list), '</i>List</span>',
                '</span>',
                '</div>');
            content.push('</div>');
            $(content.join('')).insertAfter($('[data-detail-index="' + detailIndex + '"]').parent());

        },
        updateMasterDetailInfo: function (container) {
            if (!container)
                container = $('.cloud-model-panel-masterdetail');
            var that = this,
                model = that._model,
                details = model.details || [],
                detailList = [],
                database = that._database,
                baseSchema = model.baseSchema,
                baseTable = model.baseTable,
                content = [],
                models = JSON.parse(window.external.EnumerateModels());
            content.push('<div class="cloud-text">');

            // Details
            content.push('<div class="cloud-title">Details</div>')

            if (details.length) {
                details.forEach(function (detail, index) {
                    detailList.push(detail.model);
                    content.push('<p>');
                    content.push('<span data-type="detail" data-detail-index="', index, '" title="View Field">');
                    content.push(htmlEncode(detail.fieldName));
                    content.push('</span>')
                    content.push(' field based on ');
                    content.push('<span data-type="model" data-model-name="', detail.model, '" title="View Model">')
                    content.push(detail.model);
                    content.push(' (');
                    content.push((detail.filterFields || '').replace(/,/, ', '));
                    content.push(')')
                    content.push('</span>');
                    content.push('</p>');
                });
            }
            else
                content.push('<p>', 'None.', '</p>');

            // Suggestions
            var suggestions = [];
            database.dataModel.forEach(function (table, tableIndex) {
                var foreignKeys = table.foreignKeys;
                if (foreignKeys)
                    foreignKeys.forEach(function (fk, fkIndex) {
                        if (fk.parentTableSchema === baseSchema && fk.parentTableName === baseTable && detailList.indexOf(that.toModelName(table.name)) === -1)
                            suggestions.push({ table: table, fk: fk, tableIndex: tableIndex, fkIndex: fkIndex });

                    });
            });
            if (suggestions.length) {
                content.push('<div class="cloud-title">Suggestions</div>')
                suggestions.forEach(function (suggestion) {
                    content.push('<p>')
                    content.push('<span data-type="suggestion" data-table-index="', suggestion.tableIndex, '" data-foreign-key-index="', suggestion.fkIndex, '" title="Add suggestion to details.">');
                    if (that._schemas.length > 1)
                        content.push(htmlEncode(suggestion.table.schema), '.');
                    content.push(htmlEncode(suggestion.table.name));
                    content.push(' (')
                    suggestion.fk.foreignKey.forEach(function (fk, fkIndex) {
                        if (fkIndex)
                            content.push(', ');
                        content.push(htmlEncode(fk.columnName));
                    });
                    content.push(')');
                    content.push('</span>');
                    content.push('</p>')
                });
            }

            // Masters

            var masterModelList = [];
            models.list.forEach(function (m) {
                var details = m.details,
                    isDetail;
                if (details)
                    details.every(function (d) {
                        isDetail = d.model === models.thisModel;
                        if (isDetail)
                            masterModelList.push(m.model);
                        return !isDetail;
                    });

            });


            content.push('<div class="cloud-title">Masters</div>')
            if (masterModelList.length) {
                masterModelList.forEach(function (master, index) {
                    content.push('<p>');
                    content.push('<span data-type="model" data-model-name="', master, '" title="View Model">')
                    content.push(master);
                    content.push('</span>');
                    content.push('</p>');
                });
            }
            else
                content.push('<p>', 'None.', '</p>');


            content.push('</div>');
            $(content.join('')).appendTo(container.empty());
        },
        addTable: function (options) {
            var that = this,
                diagram = that._diagram,
                listContainer = that._list,
                fieldGrid = listContainer.find('.cloud-grid'),
                tablePanel = listContainer.find('.cloud-model-panel-tables'),
                tableList;

            if (!arguments.length)
                return tablePanel.length > 0 && tablePanel.is(':visible');


            if (typeof options === 'boolean') {

                if (!tablePanel.length) {
                    if (options === false)
                        return;
                    tablePanel = $('<div class="cloud-model-panel cloud-model-panel-tables"></div>').appendTo(listContainer).height(fieldGrid.outerHeight(true));
                    tableList = $('<ul class="cloud-model-table-list"/>').appendTo(tablePanel);
                    $(that._database.dataModel).each(function () {
                        var t = this,
                            dt = that.findTableElement(t), // that._diagram.find('[data-schema="' + t.schema + '"][data-table="' + t.name + '"]'),
                            li, refCount;
                        li = $('<li draggable="true"/>').appendTo(tableList).text(toPhysicalTableName(t.schema, t.name)).attr({ 'data-schema': t.schema, 'data-table': t.name });
                        li.attr('title', li.text());
                        refCount = $('<span class="cloud-model-table-ref-count"/>').appendTo(li).text(dt.length);
                        if (dt.length)
                            li.addClass('cloud-model-table-ref');
                        else
                            refCount.hide();
                    });
                    $('<div class="cloud-model-clear"></div>').appendTo(tablePanel);
                }
                if (options) {
                    if (that.formulaField())
                        that.formulaField(false);
                    fieldGrid.css('visibility', 'hidden');
                    tablePanel.show();
                    tablePanel.scrollTop(tablePanel.data('scrollTop') || 0);
                }
                else {
                    fieldGrid.css('visibility', '');
                    tablePanel.data('scrollTop', tablePanel.scrollTop()).hide();
                }
                if (that.hosted())
                    window.external.UIState('AddTable', options);
            }
            else {
                that.scale(false);
                var dt = that.findTableElement(options), // that._diagram.find('[data-schema="' + options.schema + '"][data-table="' + options.name + '"]'),
                    id = (options.id || options.name).replace(/\s*/g, ''),
                    fk,
                    scaleRatio = that._scaleRatio;
                if (id.match(/\d$/))
                    id += '_';
                if (that._model.alias === id || that._foreignKeyMap[id])
                    id += dt.length;
                fk = {
                    '_type': 'foreignKey',
                    'id': id,
                    'parentTableSchema': options.schema,
                    'parentTableName': options.name,
                    'foreignKey': [
                    ],
                    'x': options.x != null ? options.x / scaleRatio : that.diagramSize().width - diagramMargin + tableSpacing,
                    'y': options.y != null ? options.y / scaleRatio : diagramMargin
                };
                that._model.foreignKeys.push(fk);
                that.setupMappings();
                that._right = 0;
                that.renderMasterTables();
                $('.cloud-model-highlight').removeClass('cloud-model-highlight');
                dt = that.findTableElement({ 'foreignKey': id }).addClass('cloud-model-highlight');
                diagram.width(that._right);
                that._bottom = Math.max(that._bottom, diagramMargin + dt.outerHeight());
                diagram.height(that._bottom);
                svg({
                    element: that._canvas,
                    width: that._right,
                    height: that._bottom
                });
                that.updateStateOfConnectors();
                that.scale(true);
                if (options.x == null)
                    diagram.parent().scrollTop(0).scrollLeft((that._right) * scaleRatio - $window.width());
                setTimeout(function () {
                    dt.removeClass('cloud-model-highlight');
                }, 1500);
                that.updateTableRefCount(options);
            }
        },
        diagramScroll: function () {
            var container = this._diagram.parent();
            return { left: container.scrollLeft(), top: container.scrollTop() };
        },
        diagramSize: function () {
            var that = this,
                w = 0,
                h = 0,
                scrolling = that.diagramScroll();
            that._diagram.find('.cloud-model-table').each(function () {
                var t = $(this),
                    offset = t.offset();
                w = Math.max(w, scrolling.left + offset.left + t.outerWidth() + diagramMargin);
                h = Math.max(h, scrolling.top + offset.top + t.outerHeight() + diagramMargin);
            });
            return { width: w, height: h };
        },
        linkTables: function (dropTarget, force) {
            var that = this,
                result,
                columnElement = $(dropTarget).closest('.cloud-model-column'),
                tableElement = columnElement.closest('.cloud-model-table'),
                parentFK = that._foreignKeyMap[tableElement.attr('data-foreign-key')],
                childFK,
                parentTableName = tableElement.attr('data-table'),
                parentSchema = tableElement.attr('data-schema'),
                dragData = dragEvent.data,
                parentColumn, childColumn,
                parentTable, childTable,
                allow = true, alreadyLinked;

            function isParentOfAnotherChild(fk) {
                var test;
                if (fk.foreignKey.length)
                    test = true;
                if (!test)
                    $(that._model.foreignKeys).each(function () {
                        if (this.baseForeignKey == fk.id)
                            if (isParentOfAnotherChild(this)) {
                                test = true;
                                return false;
                            }
                    });
                return test;
            }

            if (columnElement.length && parentFK && parentFK.id != dragData.alias) {
                parentTable = that.findTableModelInfo(parentSchema, parentTableName);
                parentColumn = that.findColumnModel(parentSchema, parentTableName, columnElement.attr('data-column'));
                childTable = that.findTableModelInfo(dragData.schema, dragData.table);
                childColumn = that.findColumnModel(dragData.schema, dragData.table, dragData.column);
                childFK = that._foreignKeyMap[dragData.alias];
                // validate linking requirements

                if (toDataType(parentColumn, false) != toDataType(childColumn, false) && force != true)
                    allow = false;
                if (!childFK && parentFK.baseForeignKey)
                    allow = false;

                if (childFK && parentFK.baseForeignKey && childFK.id != parentFK.baseForeignKey)
                    allow = false;

                if (parentFK && parentFK.baseForeignKey && childFK && childFK.baseForeignKey && childFK.id != parentFK.baseForeignKey)
                    allow = false;

                if (allow && childFK && parentFK && parentFK.foreignKey.length && childFK.id != parentFK.baseForeignKey && isParentOfAnotherChild(parentFK))
                    allow = false;

                if (allow)
                    $(parentFK.foreignKey).each(function () {
                        var fk = this;
                        if (fk.columnName == childColumn.name && fk.parentColumnName == parentColumn.name)
                            alreadyLinked = true;
                    });

                // create a link if allowed and provide visual feedback
                if (allow) {
                    if (!alreadyLinked) {
                        if (dragData.rollback) {
                            dragData.rollback();
                            parentFK = that._foreignKeyMap[parentFK.id];
                        }
                        dragData.rollbackData = JSON.stringify(parentFK);
                        dragData.rollback = function () {
                            that.scale(false);
                            that.connector(parentFK, false);
                            var model = that._model,
                                index = model.foreignKeys.indexOf(parentFK);
                            eval('parentFK=' + dragData.rollbackData)
                            model.foreignKeys.splice(index, 1, parentFK);
                            that.setupMappings();
                            that.connector(parentFK, true);
                            that.updateConnectors();
                            that.scale(true);
                            columnElement.removeClass('cloud-model-column-selected');
                        };
                        dragData.commit = function () {
                            columnElement.removeClass('cloud-model-column-selected');
                        };
                        that.scale(false);
                        that.connector(parentFK, false);
                        $(parentFK.foreignKey).each(function (index) {
                            var fk = this;
                            if (fk.parentColumnName === parentColumn.name || childColumn.name === fk.columnName) {
                                parentFK.foreignKey.splice(index, 1);
                                return false;
                            }
                        });
                        parentFK.baseForeignKey = childFK ? childFK.id : null;
                        parentFK.foreignKey.push({
                            '_type': 'foreignKeyColumn',
                            'columnName': childColumn.name,
                            'parentColumnName': parentColumn.name
                        });
                        // test linking of child table to parent for 1-to-1 relationship
                        if (childTable.tableModel.primaryKey.length === 1 && childTable.tableModel.primaryKey[0].columnName === childColumn.name &&
                            parentTable.tableModel.primaryKey.length === 1 && parentTable.tableModel.primaryKey[0].columnName === parentColumn.name) {
                            parentFK.type = '1-to-1';
                        }
                        that.setupMappings();
                        that.connector(parentFK, true);
                        that.updateConnectors();
                        that.scale(true);
                        columnElement.addClass('cloud-model-column-selected');
                    }
                    tableElement.addClass('cloud-model-drop-target');
                    result = true;
                }
            }
            if (!result) {
                if (dragData.rollback) {
                    dragData.rollback();
                    dragData.rollback = null;
                }
                $('.cloud-model-drop-target').removeClass('cloud-model-drop-target');
            }
            return result;
        },
        removeTable: function (foreignKey) {
            var that = this,
                foreignKeys = that._model.foreignKeys,
                fk = that._foreignKeyMap[foreignKey];
            that.scale(false);
            that.removeForeignKey(foreignKey);
            that._diagram.find('.cloud-model-table[data-foreign-key="' + foreignKey + '"]').remove();
            $(foreignKeys).each(function () {
                var pfk = this;
                if (pfk.baseForeignKey == foreignKey) {
                    that.removeForeignKey(pfk.id);
                    pfk.baseForeignKey = null;
                }
            });
            foreignKeys.splice(foreignKeys.indexOf(fk), 1);
            that.setupMappings();
            that.updateConnectors();
            that.scale(true);
            that.updateTableRefCount({ name: fk.parentTableName, schema: fk.parentTableSchema });
        },
        updateTableRefCount: function (options) {
            var refCount = $('.cloud-model-table-list [data-table="' + options.name + '"][data-schema="' + options.schema + '"] .cloud-model-table-ref-count'),
                tableElements = this.findTableElement(options);
            if (tableElements.length)
                refCount.show().text(tableElements.length).parent().addClass('cloud-model-table-ref');
            else
                refCount.hide().parent().removeClass('cloud-model-table-ref');
        },
        removeForeignKey: function (foreignKey, column) {
            var that = this,
                fk = that._foreignKeyMap[foreignKey],
                fieldGrid = that._fieldGrid,
                rows = fieldGrid.rows();
            if (column)
                that.scale(false);
            that.connector(fk, false);
            if (column)
                $(fk.foreignKey).each(function (index) {
                    var fkc = this;
                    if (fkc.parentColumnName == column) {
                        fk.foreignKey.splice(index, 1);
                        return false;
                    }
                });
            else
                fk.foreignKey = [];
            if (!fk.foreignKey.length) {

                function removeColumnsFromModel(fkId) {
                    var fieldsToRemove = [],
                        columnsToRemove = [],
                        modelColumns = that._model.columns,
                        fk = that._foreignKeyMap[fkId];

                    $(that._model.foreignKeys).each(function () {
                        if (this.baseForeignKey == fkId)
                            removeColumnsFromModel(this.id);
                    });

                    $(rows).each(function () {
                        var r = this;
                        if (r.TableAlias == fkId) {
                            fieldsToRemove.push(r.FieldName);
                            columnsToRemove.push(r.ColumnName);
                        }
                    });
                    $(rows).each(function () {
                        var r = this;
                        if (r.AliasFieldName && fieldsToRemove.indexOf(r.AliasFieldName) != -1)
                            r.AliasFieldName = null;
                    });
                    $(columnsToRemove).each(function () {
                        that.removeField({
                            tableAlias: fkId,
                            columnName: this,
                            tableName: fk.parentTableName,
                            schema: fk.parentTableSchema,
                            silent: true
                        });
                    });
                }
                removeColumnsFromModel(fk.id);
                fieldGrid.refresh();
            }
            if (!fk.foreignKey.length)
                fk.baseForeignKey = null;
            if (column)
                that.setupMappings();
            that.connector(fk, true);
            if (column) {
                that.updateConnectors();
                that.scale(true);
            }
        },
        _refresh: function () {
            var that = this;
            that.scale(false);
            that.renderBaseTable();
            that.renderMasterTables();
            that.updateConnectors();
            that._fieldGrid.refresh();
            that.scale(true);
        },
        removePrimarKey: function (options) {
            var that = this,
                tableModelInfo = that.findTableModelInfo(options.schema, options.table),
                tableModel = tableModelInfo.tableModel,
                columnModel = that.findColumnModel(options.schema, options.table, options.column);
            $(that._model.columns).each(function () {
                var column = this;
                if (!column.foreignKey && column.name == columnModel.name)
                    delete column.primaryKey;
            });
            $(tableModel.primaryKey).each(function (index) {
                var pkColumn = this;
                if (pkColumn.columnName == columnModel.name) {
                    tableModel.primaryKey.splice(index, 1);
                    return false;
                }
            });
            //tableModel.primaryKey.push(pkColumn);
            delete tableModelInfo.primaryKey[columnModel.name];
            that._diagram.find('.cloud-model-table[data-table="' + tableModel.name + '"][data-schema="' + tableModel.schema + '"]').remove();
            that._refresh();
        },
        setPrimarKey: function (options) {
            var that = this,
                tableModelInfo = that.findTableModelInfo(options.schema, options.table),
                tableModel = tableModelInfo.tableModel,
                columnModel = that.findColumnModel(options.schema, options.table, options.column),
                pkColumn = {
                    _type: 'primaryKeyColumn',
                    columnName: columnModel.name,
                    isVirtual: true
                };
            $(that._model.columns).each(function () {
                var column = this;
                if (!column.foreignKey && column.name == columnModel.name)
                    column.primaryKey = true;
            });
            tableModel.primaryKey.push(pkColumn);
            tableModelInfo.primaryKey[columnModel.name] = pkColumn;
            that._diagram.find('.cloud-model-table[data-table="' + tableModel.name + '"][data-schema="' + tableModel.schema + '"]').remove();
            that._refresh();
        },
        changeFieldProperty: function (options) {
            var that = this,
                sortColumns,
                fieldName = options.name,
                value = options.value,
                f = that.field(options.fieldName),
                fieldGrid = that._fieldGrid,
                result = true;

            options.success = function (textInput) {
                textInput.text(value);
                fieldGrid.fit();
            };

            function syncSortTypeAndOrder() {
                $(that.sortColumns()).each(function () {
                    var c = this,
                        sf = that.field(c.fieldName);
                    sf.row.SortType = c.sortType;
                    sf.row.SortOrder = c.sortOrder;
                });
                options.success = function (textInput) {
                    var grid = textInput.closest('.cloud-grid tbody'),
                        sortColumns = that.sortColumns();
                    grid.find('[data-column="SortType"]').text('');
                    grid.find('[data-column="SortOrder"]').text('');
                    $(sortColumns).each(function () {
                        var c = this,
                            r = grid.find('[data-field="' + c.fieldName + '"]');
                        r.find('[data-column="SortType"]').text(c.sortType);
                        r.find('[data-column="SortOrder"]').text(c.sortOrder);
                    });
                    fieldGrid.fit();
                };
            }

            function clearSort(f) {
                delete f.column.sortOrder;
                delete f.column.sortType;
                f.row.SortType = null;
                f.row.SortOrder = null;
            }

            function updateSpec(f) {
                var columnSpec = that.columnSpec(f.row._schema, f.row._tableName, f.row.ColumnName, f.row.TableAlias),
                    fieldName = f.row.FieldName,
                    table = that._diagram.find(f.row.TableAlias == that._model.alias ? '.cloud-model-table-base' : '.cloud-model-table[data-foreign-key="' + f.row.TableAlias + '"]'),
                    column = table.find('[data-column="' + f.row.ColumnName + '"]'),
                    row = fieldGrid.findRow({ FieldName: fieldName }),
                    gridCol = fieldGrid.column('Spec'),
                    fieldSpec;
                column.find('.cloud-model-column-spec').text(columnSpec.text).attr('title', columnSpec.tooltip);
                fieldSpec = gridCol.value(row);
                fieldGrid._tableBody.find('[data-field="' + fieldName + '"] [data-column="Spec"]').text(fieldSpec.text).attr('title', fieldSpec.tooltip);

            }

            if (fieldName == 'Label') {
                if (value) {
                    f.row.Label = value;
                    f.column.label = value;
                }
                else
                    result = 'Required';
            }
            else if (fieldName == 'Format') {
                if (value && that.hosted())
                    result = window.external.ValidateFormatString(value, f.column.dataType || that.findColumnModel(f.row._schema, f.row._tableName, f.row.ColumnName).dataType);
                if (result == true) {
                    f.row.Format = value;
                    f.column.format = value;
                }
            }
            else if (fieldName == 'SortType') {
                if (!value)
                    value = 'Unsorted';
                if (value.match(/^(ascending|descending|asc|desc|unsorted)$/i)) {
                    if (value.match(/unsorted/i))
                        clearSort(f);
                    else {
                        sortColumns = that.sortColumns();
                        f.column.sortType = value.match(/^asc/i) ? 'Ascending' : 'Descending';
                        if (!f.column.sortOrder)
                            f.column.sortOrder = sortColumns.length ? sortColumns[sortColumns.length - 1].sortOrder + 1 : 1;
                    }
                    syncSortTypeAndOrder();
                }
                else
                    result = 'Enter "Ascending", "Descending", or "Unsorted".';
            }
            else if (fieldName == 'SortOrder') {
                if (!value)
                    value = 'Unsorted';
                if (value.match(/^(\d+|unsorted)$/i)) {
                    if (value.match(/^unsorted/i))
                        clearSort(f);
                    else {
                        f.column.sortOrder = null;
                        sortColumns = that.sortColumns();
                        value = parseInt(value);
                        $(sortColumns).each(function (index) {
                            var c = this;
                            if (c.sortOrder >= value)
                                c.sortOrder++;
                        });
                        f.column.sortOrder = value;
                        if (!f.column.sortType)
                            f.column.sortType = 'Ascending';
                    }
                    syncSortTypeAndOrder();
                }
                else
                    result = 'Enter a numeric value or "Unsorted".';
            }
            else if (fieldName == 'FieldName') {
                if (value) {
                    result = that.validateFieldName(value, [f.row.FieldName]);
                    if (result == true) {
                        $(fieldGrid.rows()).each(function () {
                            var r = this;
                            if (r.AliasFieldName == f.row.FieldName) {
                                r.AliasFieldName = value;
                                fieldGrid._tableBody.find('[data-field="' + r.FieldName + '"] [data-column="AliasFieldName"]').text(value);
                            }
                        });
                        var originalAutoLabel = [],
                            newAutoLabel = [];
                        that.nameToParts(f.row.FieldName, originalAutoLabel);
                        if (originalAutoLabel.join(' ') == f.row.Label) {
                            that.nameToParts(value, newAutoLabel);
                            newAutoLabel = newAutoLabel.join(' ')
                            f.column.label = newAutoLabel;
                            f.row.Label = newAutoLabel;
                            fieldGrid._tableBody.find('[data-field="' + f.row.FieldName + '"] [data-column="Label"]').text(newAutoLabel);
                        }
                        f.column.fieldName = value;
                        f.row.FieldName = value;
                        that.setupMappings();
                        options.textInput.closest('[data-field]').attr('data-field', value);
                    }
                }
                else
                    result = 'Required.';
            }
            else if (fieldName == 'AliasFieldName') {
                var oaf = f.row.AliasFieldName ? that.field(f.row.AliasFieldName) : null,
                    af, aliasedRow;
                if (value) {
                    af = that.field(value);
                    if (!af.row)
                        result = 'Unknown field name.';
                    else if (f.row.FieldName.toLowerCase() == value.toLowerCase())
                        result = 'A field cannot be self-aliasing.';
                    else if (!af.row.TableAlias)
                        result = 'Formula field cannot be used as alias.';
                    else if (af.row.AliasFieldName)
                        result = 'Aliased field cannot be used as an alias.';
                    else {
                        aliasedRow = fieldGrid.findRow({ AliasFieldName: af.row.FieldName });
                        if (aliasedRow && aliasedRow.FieldName != f.row.FieldName)
                            result = 'Field is already used as an alias of "' + aliasedRow.FieldName + '" field.';
                        else {
                            f.row.AliasFieldName = af.row.FieldName;
                            if (af.row.TableAlias == that._model.alias)
                                delete f.column.aliasColumnName;
                            else
                                f.column.aliasForeignKey = af.row.TableAlias;
                            f.column.aliasColumnName = af.row.ColumnName;
                        }
                    }
                }
                else {
                    delete f.column.aliasForeignKey;
                    delete f.column.aliasColumnName;
                    f.row.AliasFieldName = null;
                }
                if (result == true) {
                    that.setupMappings();
                    if (oaf)
                        updateSpec(oaf);
                    if (af)
                        updateSpec(af);
                    options.success = function (textInput) {
                        var grid = textInput.closest('.cloud-grid tbody');
                        grid.find('[data-column="AliasFieldName"]').text('');
                        $(fieldGrid.rows()).each(function () {
                            var r = this;
                            if (r.AliasFieldName)
                                grid.find('[data-field="' + r.FieldName + '"] [data-column="AliasFieldName"]').text(r.AliasFieldName);
                        });
                        fieldGrid.fit();
                    };
                }
            }
            else
                result = 'Not supported';
            if (result != true)
                options.success = null;
            return result;
        },
        sortColumns: function () {
            var that = this,
                columns = [];
            $(that._model.columns).each(function () {
                var c = this;
                if (c.sortOrder != null)
                    columns.push(c);
            });
            columns.sort(function (c1, c2) {
                var s1 = c1.sortOrder ? parseInt(c1.sortOrder) : 0,
                    s2 = c2.sortOrder ? parseInt(c2.sortOrder) : 0;
                return s1 - s2;
            });
            $(columns).each(function (index) {
                this.sortOrder = index + 1;
            });
            return columns;
        },
        changeTableAlias: function (options) {
            var that = this,
                newAlias = options.newTableAlias,
                oldAlias = options.tableAlias,
                error,
                aliases = [that._model.alias.toLowerCase()];
            if (!newAlias)
                error = 'Required';
            if (!error && !newAlias.match(/^[a-z][a-z0-9_]*$/i))
                error = 'A table alias must start with a letter and contain alpha-numeric characters and "_".';
            if (!error && newAlias.length > that._database.nameMaxLength)
                error = 'The table name is too long.';
            if (!error) {
                $(that._model.foreignKeys).each(function () {
                    aliases.push(this.id.toLowerCase());
                });
                if (aliases.indexOf(newAlias.toLowerCase()) != -1)
                    error = 'Duplicate table alias.';
            }
            if (error)
                return error;
            if (oldAlias == that._model.alias) {
                that._model.alias = newAlias;
                $('.cloud-model-table-base').remove();
            }
            else {
                that._foreignKeyMap[oldAlias].id = newAlias;
                $('.cloud-model-table[data-foreign-key="' + oldAlias + '"]').remove();
                $('[data-connector="' + oldAlias + '"]').attr('data-connector', newAlias);
            }
            $(that._model.columns).each(function () {
                var c = this;
                if (c.foreignKey == oldAlias)
                    c.foreignKey = newAlias;
                if (c.aliasForeignKey == oldAlias)
                    c.aliasForeignKey = newAlias;
            });
            $(that._fieldGrid.rows()).each(function () {
                var r = this;
                if (r.TableAlias == oldAlias)
                    r.TableAlias = newAlias;
            });
            $(that._model.foreignKeys).each(function () {
                var fk = this;
                if (fk.baseForeignKey == oldAlias)
                    fk.baseForeignKey = newAlias;
            });
            that.setupMappings();
            that._fieldGrid.refresh();
            that.scale(false);
            that.renderBaseTable();
            that.renderMasterTables();
            that.updateConnectors();
            that.scale(true);
            return true;
        },
        showContextMenu: function (event) {
            var that = this,
                model = that._model,
                result,
                title, items = [],
                options = { x: event.pageX, y: event.pageY };

            function test(selector) {
                var success = false;
                if (!result) {
                    anchor = $(event.target).closest(selector);
                    if (anchor.length) {
                        result = true;
                        success = true;
                    }
                }
                return success;
            }

            modelBuilder_hideTooltip();
            revealAllDependencies();
            var target = $(event.target),
                anchor,
                dataConnector;
            if (test('[data-connector]')) {
                //title = 'Relationship';
                dataConnector = anchor.attr('data-connector')
                items.push({
                    text: 'Disconnect from "' + dataConnector + '"', context: { id: dataConnector, column: anchor.attr('data-parent-column') }, callback: function (fk) {
                        that.removeForeignKey(fk.id, fk.column);
                    }
                });
            }
            // "column" right-click
            if (test('.cloud-model-column')) {
                var tableElem = anchor.closest('.cloud-model-table'),
                    foreignKey = tableElem.attr('data-foreign-key'),
                    tableAlias = foreignKey || that._model.alias,
                    tableModelInfo = that.findTableModelInfo(tableElem.attr('data-schema'), tableElem.attr('data-table')),
                    tableModel = tableModelInfo.tableModel,
                    columnModel = that.findColumnModel(tableModel.schema, tableModel.name, anchor.attr('data-column')),
                    pkContext;
                // Add/Remove To/From Model
                if (!foreignKey || that._foreignKeyMap[foreignKey].foreignKey.length)
                    items.push({
                        text: anchor.is('.cloud-model-column-selected') ? 'Remove From Model' : 'Add Column To Model', callback: function () {
                            var columnName = anchor.find('.cloud-model-column-name').trigger('click');
                            setTimeout(function () {
                                var title = columnName.data('title')
                                if (title)
                                    columnName.attr('title', title);
                            }, 500);
                        }
                    });
                // Set/Remove Primary Key
                if (tableElem.is('.cloud-model-table-base') && (!tableModel.primaryKey.length || tableModel.primaryKey[0].isVirtual)) {
                    pkContext = { schema: tableModel.schema, table: tableModel.name, column: columnModel.name };
                    if (tableModelInfo.primaryKey[columnModel.name])
                        items.push({
                            text: 'Remove Primary Key', context: pkContext, callback: function () {
                                that.removePrimarKey(pkContext);
                            }
                        });
                    else
                        items.push({
                            text: 'Set Primary Key', context: pkContext, callback: function () {
                                that.setPrimarKey(pkContext);
                            }
                        });
                }
                // Connnect To ...
                $(tableModelInfo.foreignKeys).each(function () {
                    var fk = this[columnModel.name];
                    if (fk) {
                        // see if the column is already connected to a key
                        $(model.foreignKeys).each(function () {
                            if (fk.info.parentTableName == this.parentTableName && fk.info.parentTableSchema == this.parentTableSchema && foreignKey == this.baseForeignKey)
                                $(this.foreignKey).each(function () {
                                    if (this.columnName == columnModel.name)
                                        fk = null;
                                });
                            if (!fk)
                                return false;
                        });
                        if (fk) {
                            items.push({
                                text: 'Connect to "' + toPhysicalTableName(fk.info.parentTableSchema, fk.info.parentTableName) + '"',
                                context: fk.info,
                                callback: function (context) {
                                    var childForeignKey = (tableElem.attr('data-foreign-key') || ''),
                                        cleanedColumnName = columnModel.name,
                                        newForeignKeyName;

                                    if (cleanedColumnName.length > 2) {
                                        cleanedColumnName = cleanedColumnName.replace(/\_(ID|PK|FK|GUID)$/i, '')
                                        if (cleanedColumnName.match(/[a-z]/))
                                            cleanedColumnName = cleanedColumnName.replace(/(Id|ID|Pk|PK|Fk|FK|Guid)$/, '');
                                    }
                                    newForeignKeyName = cleanedColumnName;
                                    if (that._foreignKeyMap[newForeignKeyName]) {
                                        if (childForeignKey.match(/\_/) || newForeignKeyName.match(/\_/) || childForeignKey && !(childForeignKey.match(/[A-Z]/) && childForeignKey.match(/[a-z]/)))
                                            newForeignKeyName = '_' + newForeignKeyName;
                                        newForeignKeyName = childForeignKey + newForeignKeyName;
                                        if (newForeignKeyName.length > that._database.nameMaxLength)
                                            newForeignKeyName = cleanedColumnName;
                                    }

                                    that.addTable({ id: newForeignKeyName, schema: fk.info.parentTableSchema, name: fk.info.parentTableName });

                                    var newFK = model.foreignKeys[model.foreignKeys.length - 1],
                                        parentTable, parentColumnName, parentColumn;
                                    $(fk.info.foreignKey).each(function () {
                                        var fk = this;
                                        if (fk.columnName == columnModel.name) {
                                            parentColumnName = fk.parentColumnName;
                                            return false;
                                        }
                                    });
                                    parentTable = that._diagram.find('.cloud-model-table[data-foreign-key="' + newFK.id + '"]');
                                    parentColumn = parentTable.find('.cloud-model-column[data-column="' + parentColumnName + '"]');
                                    dragEvent = {
                                        data: {
                                            alias: tableElem.attr('data-foreign-key'),
                                            schema: tableModel.schema,
                                            table: tableModel.name,
                                            column: columnModel.name
                                        }
                                    };
                                    toggleOptionalTableColumns(parentTable);
                                    that.linkTables(parentColumn);
                                    dragEvent = null;
                                    parentTable.removeClass('cloud-model-drop-target');
                                    parentColumn.removeClass('cloud-model-column-selected');
                                    setTimeout(function () {
                                        revealAllDependencies();
                                    }, 500);
                                }
                            });
                        }
                    }
                });
                // Disconnect From ...
                $(model.foreignKeys).each(function () {
                    var fk = this;
                    if (fk.baseForeignKey == foreignKey)
                        $(fk.foreignKey).each(function () {
                            var fkColumn = this;
                            if (fkColumn.columnName == columnModel.name)
                                items.push({
                                    text: 'Disconnect from "' + fk.id + '"', context: { id: fk.id, column: fkColumn.parentColumnName },
                                    callback: function (context) {
                                        that.removeForeignKey(context.id, context.column);
                                    }
                                });
                        });
                });
                // Add As Formula Field
                items.push({
                    text: 'Add As Formula Field', callback: function () {
                        that.formulaField({ newFieldName: tableAlias + (tableAlias.match(/\_/) ? '_' : '') + columnModel.name, formula: tableAlias + '.' + that.quotedName(columnModel.name) });
                    }
                });
                options.hideArrow = true;
            }
            // "table header" right-click
            if (test('.cloud-model-table')) {
                items.push({
                    text: 'Rename Alias', callback: function () {
                        anchor.find('th[data-input] [data-input-hotspot]').trigger('click');
                    }
                });
                if (!anchor.is('.cloud-model-table-base'))
                    items.push({
                        text: 'Delete Table', context: anchor.attr('data-foreign-key'), callback: function (context) {
                            that.removeTable(context);

                        }
                    });
                if (anchor.find(':input').length > anchor.find(':checked').length)
                    items.push({
                        text: 'Add All Columns', callback: function () {
                            that.forEachField(anchor.attr('data-foreign-key'), 'add');
                        }
                    });
                if (anchor.find(':checked').length)
                    items.push({
                        text: 'Remove All Columns', callback: function () {
                            that.forEachField(anchor.attr('data-foreign-key'), 'remove');
                        }
                    });
                options.hideArrow = true;
            }
            // "model row column" right-click
            if (test('.cloud-model-list .cloud-grid-body tbody td')) {
                var tr = anchor.closest('tr'),
                    trIndex = tr.index(),
                    row = that._fieldGrid.rows()[trIndex];
                if (row) {
                    tr.closest('.cloud-grid').find('tbody').find('tr:eq(' + trIndex + ')').addClass('cloud-model-inspected');
                    modelBuilder_showFieldOnDiagram(tr.attr('data-field'));
                    //if (anchor.index() > 0)
                    //    items.push({
                    //        text: 'Show On Diagram', callback: function () {
                    //            modelBuilder_showFieldOnDiagram(tr.attr('data-field'));
                    //        }
                    //    });
                    if (!row.TableAlias)
                        items.push({
                            text: 'Edit Formula', callback: function () {
                                that.formulaField({ fieldName: row.FieldName, formula: row.SqlFormula });
                            }
                        });
                    if (!anchor.is('[data-column="FieldName"]'))
                        title = row.FieldName;
                    items.push({
                        text: 'Remove From Model', callback: function () {
                            if (row.TableAlias)
                                that._diagram.find('.cloud-model-table' +
                                    (row.TableAlias == model.alias ? '.cloud-model-table-base' : ('[data-foreign-key="' + row.TableAlias + '"]')) +
                                    ' [data-column="' + row.ColumnName + '"] .cloud-model-column-name').trigger('click');
                            else
                                that.removeField({ fieldName: row.FieldName });
                        }
                    });
                    if (row.TableAlias)
                        items.push({
                            text: 'Add As Formula Field', callback: function () {
                                that.formulaField({ newFieldName: row.FieldName, formula: row.TableAlias + '.' + that.quotedName(row.ColumnName) });
                            }
                        });
                }
            }
            // "empty space in diagram" right-click
            if (test('.cloud-model-container')) {
                if (that.addTable() || that.formulaField())
                    items.push(
                        {
                            text: 'Show Model Fields', callback: function () {
                                modelBuilder_addTable(false);
                                modelBuilder_formulaField(false);
                            }
                        });
                if (!that.addTable())
                    items.push(
                        {
                            text: 'Add Table', callback: function () {
                                modelBuilder_addTable(true);
                            }
                        });
                if (!that.formulaField())
                    items.push({
                        text: 'Add Formula Field', callback: function () {
                            modelBuilder_formulaField(true);
                        }
                    });
                if (!that.formulaField())
                    items.push({
                        text: that._model.where ? 'Change Filter' : 'Add Filter', callback: function () {
                            that.whereClause(true);
                        }
                    });
                items.push({
                    text: 'Arrange Tables', callback: function () {
                        if (confirm('Arrange Tables?'))
                            modelBuilder_arrangeTables();
                    }
                });
                options.hideArrow = true;
            }
            // "add table panel" right-click
            if (test('.cloud-model-panel-tables')) {
                if (that.addTable()) {
                    items.push({
                        text: 'Show Model Fields', callback: function () {
                            modelBuilder_addTable(false);
                        }
                    });
                    options.hideArrow = true;
                }
            }
            if (result && items.length) {
                anchor.addClass('cloud-model-inspected');
                if (anchor.is('.cloud-model-connector'))
                    svgAddClass(anchor, 'cloud-model-inspected');
                if (title)
                    options.title = title;
                options.items = items;
                listPopup(options);
            }
            return result;
        },
        diagramWidth: function (value) {
            var that = this;
            if (!arguments.length)
                return that._right;
            if (value > that._right) {
                that._right = value;
                that._diagram.width(value);
                svg({
                    element: that._canvas,
                    width: value
                });
            }
        },
        diagramHeight: function (value) {
            var that = this;
            if (!arguments.length)
                return that._bottom;
            if (value > that._bottom) {
                that._bottom = value;
                that._diagram.height(value);
                svg({
                    element: that._canvas,
                    height: value
                });
            }
        }
    }

    $(document).on('click', '[data-type="suggestion"]', function () {
        //debugger
        var suggestion = $(this),
            builder = getDetailBuilder(suggestion);
        builder.masterDetail({
            suggestion: {
                table: builder._database.dataModel[suggestion.data('table-index')],
                foreignKeyIndex: suggestion.data('foreign-key-index')
            }
        });
        return false;
    }).on('click', '[data-type="model"]', function () {
        getDetailBuilder(this).masterDetail({ model: $(this).data('model-name') });
        return false;
    }).on('click', '[data-type="detail"]', function () {
        var detail = $(this),
            existingDetailEditor = $('[data-input-container="detail"][data-detail-index="' + detail.data('detail-index') + '"]');
        if (existingDetailEditor.length)
            existingDetailEditor.remove();
        else
            getDetailBuilder(detail).masterDetail({ detail: detail.data('detail-index'), action: 'show' });
        return false;
    }).on('click', '.cloud-input-label', function () {
        $(this).next().trigger('click');
    }).on('getvalue.input.app', '[data-input-container="detail"] [data-field]', function (e) {
        var detail = toModelDetail(this);
        e.inputValue = detail[$(this).data('field')];
    }).on('setvalue.input.app', '[data-input-container="detail"] [data-field]', function (e) {
        var dataInput = $(this),
            builder = getDetailBuilder(this),
            detailInfo = toModelDetail(dataInput, true),
            propName = dataInput.data('field'),
            propValue = e.inputValue,
            inner = dataInput.find('.cloud-input-inner'),
            result;
        if (propName === 'fieldName') {
            result = getDetailBuilder(this).validateFieldName(propValue);
            if (result !== true)
                e.inputValid = false;
            else
                setTimeout(function () {
                    builder.updateMasterDetailInfo();
                    builder.masterDetail({ detail: detailInfo.index, action: 'show' });
                });
        }
        if (e.inputValid) {
            detailInfo.detail[propName] = propValue;
            inner.text(isNullOrEmpty(propValue) ? 'none' : propValue);
            dataInput.toggleClass('cloud-empty', isNullOrEmpty(propValue));
        }
        else
            e.inputError = result;
    }).on('click', '.cloud-model-detail .cloud-checkbox', function (e) {
        var checkbox = $(this),
            icon = checkbox.find('i'),
            isChecked = icon.text() === toCheckboxIcon(true),
            detail = toModelDetail(checkbox),
            propName = checkbox.data('field');
        isChecked = !isChecked;
        icon.text(toCheckboxIcon(isChecked));
        if (propName === 'flow')
            if (isChecked)
                detail[propName] = 'row';
            else
                delete detail[propName];
        else
            detail[propName] = isChecked;
    }).on('click', '.cloud-model-detail .cloud-model-toolbar .material-icon', function (e) {
        var button = $(this),
            action = button.data('action'),
            builder = getDetailBuilder(button),
            detailInfo = toModelDetail(button, true);
        if (!button.is('.app-disabled'))
            switch (action) {
                case 'delete':
                    if (window.external.Confirm('Delete "' + detailInfo.detail.fieldName + '" field from the model?')) {
                        detailInfo.model.details.splice(detailInfo.index, 1);
                        builder.updateMasterDetailInfo();
                    }
                    break;
                case 'up':
                    detailInfo.model.details.splice(detailInfo.index, 1);
                    detailInfo.model.details.splice(detailInfo.index - 1, 0, detailInfo.detail);
                    builder.updateMasterDetailInfo();
                    builder.masterDetail({ detail: detailInfo.index - 1, action: 'show' });
                    break;
                case 'down':
                    detailInfo.model.details.splice(detailInfo.index, 1);
                    detailInfo.model.details.splice(detailInfo.index + 1, 0, detailInfo.detail);
                    builder.updateMasterDetailInfo();
                    builder.masterDetail({ detail: detailInfo.index + 1, action: 'show' });
                    break;
            }
    }).on('click', '.cloud-model-panel-masterdetail', function (e) {
        if (!$(e.target).closest('.cloud-model-detail').length)
            $('[data-input-container="detail"][data-detail-index]').remove();
    });

    function toCheckboxIcon(value) {
        return value === true || value === 'true' || value === 'row' ? 'check_circle' : 'radio_button_unchecked';
    }

    function getDetailBuilder(elem) {
        modelBuilder_hideTooltip();
        return $(elem).closest('.cloud-model-panel-masterdetail').data('builder');
    }

    function toModelDetail(elem, all) {
        var builder = getDetailBuilder(elem),
            detailIndex = $(elem).closest('[data-detail-index]').data('detail-index'),
            result = {
                model: builder._model,
                detail: builder._model.details[detailIndex],
                index: detailIndex
            };
        //return builder._model.details[detailIndex];
        return all ? result : result.detail;
    }

}());