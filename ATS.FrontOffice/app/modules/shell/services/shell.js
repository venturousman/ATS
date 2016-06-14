/// <summary>
/// all Apis call to application layer restful service which related to dashboard module 
/// for example: menu, taskbar, thumbnail...
/// </summary>
define([], function () {
    var shellModule = angular.module('shell');

    /// shell services
    shellModule.service('shellServices', ['$q', '$http', '$window', function ($q, $http, $window) {
        var service = {};
        
        return service;
    }]);
    //#endregion

    // #region Events Publish/Subscribe
    // help to handle broadcasting or catching events which raised from other components
    shellModule.service('events', ['$rootScope', function ($rootScope) {
        // Event Publish
        this.trigger = function (name, args) {
            $rootScope.$broadcast(name, args);
        };

        // Event Subscribe
        this.on = function (name, handler) {
            $rootScope.$on(name, handler);
        };
    }]);
    // #endregion
});