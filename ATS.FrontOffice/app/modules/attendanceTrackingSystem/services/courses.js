'use strict'
define(function (require) {
    angular.module('attendanceTrackingSystem').register.factory('coursesServices', ['$http', '$q', 'restServiceUrl', function ($http, $q, restServiceUrl) {
        var appFactory = {};
        // get all appointments
        appFactory.getCourses = function () {
            var deferred = $q.defer();
            $http.get(restServiceUrl.getCourses).then(function (response) {
                //deferred.resolve(response.data.value);
                deferred.resolve(response.data);
            }, function (error) {
                deferred.reject();
            });
            return deferred.promise;
        };
        //appFactory.getPreviousAppointments = function (customerId) {
        //    var deferred = $q.defer();
        //    $http.get(restServiceUrl.getAppointmentByCustomerID + "'" + customerId + "'").then(function (response) {
        //        deferred.resolve(response.data.value);
        //    }, function (error) {
        //        deferred.reject();
        //    });
        //    return deferred.promise;
        //};

        return appFactory;
    }]);
});// define