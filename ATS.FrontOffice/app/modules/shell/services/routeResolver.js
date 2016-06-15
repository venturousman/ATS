/// <summary>
// a trick class to delay routing for asynchronous loading
/// </summary>
define(['require'], function (require) {
    // get route service instance
    var shellModule = angular.module('shell');

    // must be a provider since it will be injected into module.config()    
    shellModule.provider('routeResolver', function () {
        /// <summary>
        // get method to return this instance
        /// </summary>
        this.$get = function () {
            return this;
        };

        /// <summary>
        // route method to make sure controller will be loaded together with the view
        /// </summary>
        this.route = function () {
            // resolve method define
            var resolve = function (url, moduleName, pageName, controllerName, compositeViews) {
                var routeDef = {},
                    viewPath = 'modules/' + moduleName + '/views/',
                    controllerPath = 'modules/' + moduleName + '/controllers/',
                    compositePath = 'modules/' + moduleName + '/compositeViews/';

                // as all the views aren't added on the build script, so we shoud add the baseUrl 
                // to make sure requirejs know what exactly path
                routeDef.url = url;
                //routeDef.templateUrl = appConfigs.baseUrl + '/' + viewPath + pageName + '.html';
                routeDef.templateUrl = viewPath + pageName + '.html';
                routeDef.controller = controllerName;

                routeDef.resolve = {
                    load: ['$q', '$rootScope', 'localize', function ($q, $rootScope, localize) {
                        var dependencies = [controllerPath + controllerName], i;
                        if (compositeViews) {
                            for (i = 0; i < compositeViews.length; i++) {
                                dependencies.unshift(compositePath + compositeViews[i]);
                            }
                        }

                        return resolveDependencies($q, $rootScope, localize, dependencies, moduleName);
                    }]
                };

                return routeDef;
            },

            // resolver method , this will call rootScope.appy which make effection if you are binding to DOM
            // we need to feed all resource files first before controller is rendered
            resolveDependencies = function ($q, $rootScope, localize, dependencies, moduleName) {
                var defer = $q.defer();
                var resourceByModulePath = 'modules/{0}/resources/resources-locale_' + localize.language;
                var defaultResourceByModulePath = 'modules/{0}/resources/resources-locale_default';

                // dependencies loader
                var loadDependencies = function () {
                    require(dependencies, function () {
                        defer.resolve();
                        $rootScope.$apply();
                    });
                };

                // resource loader
                var loadResourceDependenciesByModule = function (module) {
                    if (localize.isModuleLoaded(module)) {
                        loadDependencies();
                    } else {
                        require([_.string.formatArgs(resourceByModulePath, [module])], function (json) {
                            // feed resource data
                            localize.feedData(json);
                            // load other dependencies
                            loadDependencies();
                        }, function (error) { // incase the resource file does not exist then we should load deault resource file for replacing
                            require([_.string.formatArgs(defaultResourceByModulePath, [module])], function (json) {
                                // feed resource data
                                localize.feedData(json);
                                // load other dependencies
                                loadDependencies();
                            });
                        });
                    }
                };

                // shell resource is a reused module so it should be loaded in prioritest
                if (!localize.isModuleLoaded('shell')) {
                    // load other dependencies
                    require([_.string.formatArgs(resourceByModulePath, ['shell'])], function (json) {
                        // feed resource data
                        localize.feedData(json);
                        // and next step is load current resource  by moduleName
                        loadResourceDependenciesByModule(moduleName);
                    }, function (error) { // incase the resource file does not exist then we should load deault resource file for replacing
                        require([_.string.formatArgs(defaultResourceByModulePath, ['shell'])], function (json) {
                            // feed resource data
                            localize.feedData(json);
                            // and next step is load current resource  by moduleName
                            loadResourceDependenciesByModule(moduleName);
                        });
                    });
                } else {
                    loadResourceDependenciesByModule(moduleName);
                }

                return defer.promise;
            };

            return {
                resolve: resolve
            };
        }();
    });
});