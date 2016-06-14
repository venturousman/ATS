'use strict';
// it's simply to tell Angular know it exist to load home.html page
define(function () {
    // constructor to load default data or register all listening events
    function homeController($scope, $state, $window, commonApi, constants, localize) {
        // Init data when initialize dashboard screen
        function initialize() {
        }

        //initialize dashboard screen
        initialize();
    }

    // inject 'home' controller to dashboard module
    angular.module('shell').register.controller('home', ['$scope', '$state', '$window', 'commonApi', 'constants', 'localize', homeController]);

    return homeController;
});