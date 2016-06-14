/// <summary>
/// a collection of constants which can use in application
/// </summary>
define(function () {
    var commonModule = angular.module('common');

    /// <summary>
    /// we define all constants here 
    /// </summary>
    commonModule.service('constants', ['$window', function ($window) {
        return {
            // default timeout to show busy indicator
            DefaultTimeout: 300,

            //default date format
            DefaultDateFormat: 'dd MMM yy',

            MinDate: new Date('1-1-1'),

            MaxDate: new Date('9999-12-31'),

            //define an empty guid
            EmptyGuid: "00000000-0000-0000-0000-000000000000"

        };//return
    }]);
});