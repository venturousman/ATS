/*global require*/
'use strict';

// app general configuration
var appConfigs = {
    name: 'AttendanceTrackingSystem',
    //idleTime: 48 * 30 * 60 * 1000,
    version: 1,
    baseUrl: 'app',
    modules: ['common', 'localization', 'shell', 'attendanceTrackingSystem']
}

// require js configuration
require.config({
    //baseUrl: appConfigs.baseUrl,
    paths: {
        // Aliases and paths of modules
        'jquery': '../scripts/jquery-2.2.3',
        'angular': '../scripts/angular',
        'angular-ui-router': '../scripts/angular-ui-router-0.2.15',
        //'angular-route': '../scripts/angular-route',
        'angular-cookies': '../scripts/angular-cookies.min',
        'bootstrap': '../scripts/bootstrap',
        'underscore': '../scripts/underscore-1.8.3',
        'underscore-string': '../scripts/underscore.string-2.3.3',
        'underscore-string-format': '../scripts/underscore.string.format',
    },
    shim: {
        // Modules and their dependent modules
        'jquery': {
            exports: 'jquery'
        },
        'angular': {
            deps: ['jquery']
        },
        'angular-ui-router': {
            deps: ['angular']
        },
        //'angular-route': ['angular']
        'angular-cookies': {
            deps: ['angular']
        },
        'bootstrap': {
            deps: ['jquery']
        },
        'underscore': {
            exports: '_'
        },
        'underscore-string': {
            deps: ['underscore']
        },
    },
    //deps: ['app']
});

// main function
require([
    'jquery',
    'angular',
    'angular-ui-router',
    'angular-cookies',
    //'jquery-ui',
    //'jquery.ui.touch-punch.min',
    //'ipicture',
    'bootstrap',
    ////'clockface',
    //'date',
    //'master',
    'underscore',
    'underscore-string',
    'underscore-string-format'
], function () {
    var modules = [];
    _.each(appConfigs.modules, function (module) {
        // loading existing module in main.js
        modules.push('modules/' + module + '/loader');
        // create module instance
        angular.module(module, ['ui.router', 'ngCookies']);
    });
    require(modules, function () {
        // create main module
        angular.module(appConfigs.name, appConfigs.modules);
        // bootstrap module
        angular.bootstrap(document, [appConfigs.name]);
    });
});

