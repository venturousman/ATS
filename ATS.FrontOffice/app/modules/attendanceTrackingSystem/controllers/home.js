'use strict';
define([], function () {
    /// constructor to load default data or register all listening events
    function homeController($scope) {
        $scope.search = function () {
            alert('test');
        }
    }
    // inject home controller to attendanceTrackingSystem module
    angular.module('attendanceTrackingSystem').register.controller('home', ['$scope', homeController]);

    return homeController;
});