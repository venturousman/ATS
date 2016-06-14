'use strict';
define([], function () {
    /// constructor to load default data or register all listening events
    function testController($scope) {
        $scope.search = function () {
            alert('test');
        }
    }
    // inject test controller to attendanceTrackingSystem module
    angular.module('attendanceTrackingSystem').register.controller('test', ['$scope', testController]);

    return testController;
});