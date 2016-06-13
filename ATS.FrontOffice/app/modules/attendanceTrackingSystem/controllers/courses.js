'use strict';
define([], function () {
    /// constructor to load default data or register all listening events
    function coursesController($scope) {
        $scope.search = function () {
            alert('test');
        }
    }
    // inject courses controller to attendanceTrackingSystem module
    angular.module('attendanceTrackingSystem').register.controller('courses', ['$scope', coursesController]);

    return coursesController;
});