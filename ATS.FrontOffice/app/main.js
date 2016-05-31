/*global require*/
'use strict';

require.config({
    //baseUrl: 'app',
    paths: {
        // Aliases and paths of modules
        angular: '../scripts/angular',
        'angular-route': '../scripts/angular-route',
    },
    shim: {
        // Modules and their dependent modules
        angular: {
            exports: 'angular'
        },
        'angular-route': ['angular']
    },
    deps: ['app']
});