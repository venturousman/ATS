'use strict';
define([], function () {
    /// constructor to load default data or register all listening events
    function schedulesController($scope) {
        $scope.search = function () {
            alert('test');
        }
    }
    // inject schedules controller to attendanceTrackingSystem module
    angular.module('attendanceTrackingSystem').register.controller('schedules', ['$scope', schedulesController]);

    return schedulesController;
});