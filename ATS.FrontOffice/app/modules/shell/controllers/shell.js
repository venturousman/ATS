'use strict';
// shell controller for manage shell page
define(function () {
    // constructor to load default data or register all listening events
    function shellController($scope, shellServices) {
        // Init data when initialize dashboard screen
        function initialize() {
        }

        //initialize dashboard screen
        initialize();
    }
    angular.module('shell').controller('shell', ['$scope', 'shellServices', shellController]);
    return shellController;
});