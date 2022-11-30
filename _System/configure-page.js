(function () {

    var selectors = $('.selector'),
        _window = window,
        pageWizard,
        pageTemplate = '<div class="jumbotron page-wizard-page"></div>';

    selectors.each(function () {
        var selector = $(this),
            as = selector.find('a');

        as.on('click', function (target) {
            selector.find('.active').removeClass('active');
            $(this).addClass('active');
            return false;
        });
    });

    if (typeof CloudOnTime == 'undefined')
        _window.CloudOnTime = {};
    if (typeof _window.CloudOnTime.PageWizard == 'undefined')
        pageWizard = _window.CloudOnTime.PageWizard = {};

    pageWizard.builder = function (options) {
        var that = this;

        this._wrapper = options.wrapper;
        this._dataViews = options.dataViews;
        this._controllers = options.controllers;
        this._containers = options.containers;


        this._wrapper.parent().children().hide();
        this._wrapper.show();
        this._wrapper.addClass('page-wizard container');

        var toolbar = $('<div class="navbar navbar-default navbar-fixed-bottom page-wizard-toolbar"></div>').appendTo(this._wrapper),
            toolbarContainer = $('<div class="container"></div>').appendTo(toolbar);
        this._next = $('<button type="button" class="btn btn-default navbar-btn navbar-right">Next<span class="glyphicon glyphicon-chevron-right"></span></button>').appendTo(toolbarContainer).on('click', function () {
            if (!that.inMotion)
                that.next();
        }),
        this._back = $('<button type="button" class="btn btn-default navbar-btn navbar-right"><span class="glyphicon glyphicon-chevron-left"></span>Back</button>').appendTo(toolbarContainer).on('click', function () {
            if (!that.inMotion)
                that.back();
        });

        this.navigate('home');
    };
    var countOfHomePage = 0;
    pageWizard.Pages = {
        home: {
            init: function () {
                $('<h1>Paging Testing</h1>').appendTo(this.container);
                this.counter = $('<div></div>').appendTo(this.container);
            },
            refresh: function () {
                this.counter[0].innerHTML = 'Count: ' + countOfHomePage++;
            },
            back: null,
            next: function (that) {
                that.navigate('suggestions');
            }
        },
        suggestions: {
            template: '<div class="jumbotron"></div>',
            init: function (builder) {
                var content = $('<div class="row"><div class="col-sm-12"><h2 class="suggestion-header"></h2><h3>Select an option:</h3><div class="suggestion-options"></div></div></div>').appendTo(this.container);
                this.header = content.find('h2.suggestion-header');
                this.options = content.find('div.suggestion-options');

            },
            refresh: function (builder) {
                this.options.empty();
                var that = this,
                    suggestions = builder.getSuggestions(),
                    index = 1;
                suggestions.forEach(function (suggestion) {
                    var well = $('<div class="tree-well"></div>').appendTo(that.options),
                        header = $('<div class="page-tree-header"><div class="page-tree-number">' + index++ + '</div><h4>' + suggestion.description + '</h4></div>').appendTo(well),
                        topList = $('<ul class="page-tree"></ul>').appendTo(well);

                    // build tree
                    suggestion.containers.forEach(function (container) {
                        var containerLi = $('<li class="container-node">' + container.id + '</li>').appendTo(topList),
                            dataViewsLi = $('<li class="none-node"></li>').appendTo(topList),
                            dataViewList = $('<ul></ul>').appendTo(dataViewsLi);
                        if (container.isNew) {
                            containerLi.addClass('tree-new');
                            dataViewsLi.addClass('tree-new');
                        }

                        container.dataViews.forEach(function (dataView) {
                            var dataViewLi = $('<li class="dataview-node">' + dataView + '</li>').appendTo(dataViewList);
                        });
                    });
                });
            },
            back: function (that) {
                that.navigate('home');
            }
        }
    };

    pageWizard.builder.prototype = {
        inMotion: false,
        attach: function (container) {

        },
        navigate: function (pageName) {
            var that = this;
            that.inMotion = true;
            function continueNavigate() {
                var page = pageWizard.Pages[pageName];
                if (page) {
                    if (!page.container) {
                        page.container = $(pageTemplate);
                        page.init(that);
                    }
                    page.refresh(that);

                    if (!jQuery.contains(document.documentElement, page.container[0]))
                        page.container.appendTo(that._wrapper).hide();

                    if (!page.back)
                        that._back.addClass('disabled');
                    else
                        that._back.removeClass('disabled');
                    if (!page.next)
                        that._next.addClass('disabled');
                    else
                        that._next.removeClass('disabled');

                    that._activePage = page;
                    page.container.fadeIn(250, function () {
                        that.inMotion = false;
                    });
                }
            }

            var pages = this._wrapper.find('.page-wizard-page');
            if (pages.length > 0)
                pages.fadeOut(80).promise().done(continueNavigate);
            else
                continueNavigate();

        },
        back: function () {
            this._activePage.back(this);
        },
        next: function () {
            this._activePage.next(this);
        },
        _suggestions: null/*[
            {
                description: 'Add detail views of Customers displayed, each in a tab.',
                containers: [
                    { id: 'c100', dataViews: ['Customers'] },
                    { id: 'c101', isNew: true, dataViews: ['Orders', 'OrderDetails'] }
                ]
            },
            {
                description: 'Add detail views of Customers displayed in a stack.',
                containers: [
                    { id: 'c100', dataViews: ['Customers'] },
                    { id: 'c101', isNew: true, dataViews: ['Orders', 'OrderDetails'] }
                ]
            },
            {
                description: 'Add detail views of Customers displayed in individual containers.',
                containers: [
                    { id: 'c100', dataViews: ['Customers'] },
                    { id: 'c101', isNew: true, dataViews: ['Orders'] },
                    { id: 'c102', isNew: true, dataViews: ['OrderDetails'] }
                ]
            }
        ]*/
        ,
        _currentConfig: {
            containers: [{ id: 'c100', dataViews: ['Customers'] }]
        },
        getSuggestions: function () {
            if (this._suggestions)
                return this._suggestions;
            else {
                debugger;
                var current = this._currentConfig,
                    countOfMaster = this._dataViews.filter(function () { return this.FilterSource.length == 0;}).length;
                alert(countOfMaster);
                if (current.containers.length == 1 && current.containers[0].dataViews.length == 1) {
                    // handle single data view - descend tree
                }
                else if (current.containers.length == 0 || current.containers[0].dataViews.length == 0) {
                    // handle empty page
                }
                else if (true) {

            }
            }
        }
    };

    function copyObject(object) {
        return JSON.parse(JSON.stringify(object));
    }
})();