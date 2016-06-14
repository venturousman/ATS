'use strict';
// it's simply to tell Angular know it exist to load setting.html page
define(function () {
    // constructor to load default data or register all listening events
    function settingController($scope, $state, $window, commonApi, constants, localize) {
        // Init data when initialize welcome screen
        function initialize() {
        }

        //initialize welcome screen
        initialize();
    }

    // inject 'welcome' controller to dashboard module
    angular.module('shell').register.controller('setting', ['$scope', '$state', '$window', 'commonApi', 'constants', 'localize', settingController]);

    return settingController;
});