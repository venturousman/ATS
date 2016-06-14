/// <summary>
/// Shell bootstrapper which help to config some neccesary starting-up for Shell module
/// such as routing resolver, localization
/// </summary>

define(['modules/attendanceTrackingSystem/configs/require'], function () {
    // get Shell Module and configure router for Shell module
    var atsModule = angular.module('attendanceTrackingSystem');
    // router configure for shell module
    atsModule.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', 'routeResolverProvider', '$controllerProvider', '$compileProvider', '$filterProvider', '$provide',
    function ($stateProvider, $urlRouterProvider, $locationProvider, routeResolverProvider, $controllerProvider, $compileProvider, $filterProvider, $provide) {
        // fill-up register information
        atsModule.register =
        {
            controller: $controllerProvider.register,
            directive: $compileProvider.directive,
            filter: $filterProvider.register,
            factory: $provide.factory,
            service: $provide.service
        };

        // define routes - controllers will be loaded dynamically
        var route = routeResolverProvider.route;

        // here we do our configure for login Module with syntax(url, moduleName, pageName, controllerName)
        $stateProvider
            .state('attendanceTrackingSystem', route.resolve('/courses', 'attendanceTrackingSystem', 'courses', 'courses'))
            .state('test', route.resolve('/test', 'attendanceTrackingSystem', 'test', 'test'));
            //.state('digitalWorkshop.dashboard', route.resolve('/dashboard', 'digitalWorkshop', 'dashboard', 'dashboard'))
            //.state('digitalWorkshop.appointments', route.resolve('/appointments', 'digitalWorkshop', 'appointments', 'appointments'))
            //.state('digitalWorkshop.appointmentDetail', route.resolve('/appointmentDetail', 'digitalWorkshop', 'appointmentDetail', 'appointmentDetail'))
            //.state('digitalWorkshop.jobCards', route.resolve('/jobCards', 'digitalWorkshop', 'jobCards', 'jobCards'))
            //.state('digitalWorkshop.spareParts', route.resolve('/spareParts', 'digitalWorkshop', 'spareParts', 'spareParts'))
            //.state('digitalWorkshop.contacts', route.resolve('/contacts', 'digitalWorkshop', 'contacts', 'contacts'));
        $urlRouterProvider.otherwise('/attendanceTrackingSystem');
        //// remove hashtag from angular urls
        //if (window.history && window.history.pushState) {
        //    $locationProvider.html5Mode({ enabled: true, requireBase: false });
        //}
    }]);
});