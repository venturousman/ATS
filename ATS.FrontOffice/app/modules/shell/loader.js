/// <summary>
/// shell bootstrapper which help to config some neccesary starting-up for dashboard module
/// such as routing resolver, localization
/// </summary>

define(['require', 'modules/shell/configs/require'], function (require) {
    // get shell Module and configure router for shell module
    var shellModule = angular.module('shell');
    // router configure for shell module
    shellModule.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', 'routeResolverProvider', '$controllerProvider', '$compileProvider', '$filterProvider', '$provide',
    function ($stateProvider, $urlRouterProvider, $locationProvider, routeResolverProvider, $controllerProvider, $compileProvider, $filterProvider, $provide) {
        // fill-up register information
        shellModule.register =
        {
            controller: $controllerProvider.register,
            directive: $compileProvider.directive,
            filter: $filterProvider.register,
            factory: $provide.factory,
            service: $provide.service
        };

        // define routes - controllers will be loaded dynamically
        var route = routeResolverProvider.route;

        // here we do our configure for shell Module with syntax(url, moduleName, pageName, controllerName)
        $stateProvider
            .state('home', route.resolve('/', 'shell', 'home', 'home'));
        $urlRouterProvider.otherwise('/');
        //// remove hashtag from angular urls
        //if (window.history && window.history.pushState) {
        //    $locationProvider.html5Mode({ enabled: true, requireBase: false });
        //}
    }]);
    // a "fancy" AngularJS-y solution is monitoring the digest loop, if none has been triggered for the last [specified duration] then logout
    //shellModule.run(['$rootScope', '$location', '$cookieStore', '$http', '$window', 'events', function ($rootScope, $location, $cookieStore, $http, $window, events) {
    //    // keep user logged in after page refresh
    //    $rootScope.globals = $window.sessionStorage.getItem('globals') ? JSON.parse($window.sessionStorage.getItem('globals')) : {};
    //    if ($rootScope.globals.currentUser) {
    //        $http.defaults.headers.common['Authorization'] = $rootScope.globals.currentUser.authData;// jshint ignore:line
    //    }
    //    events.on('$locationChangeStart', function (event, next, current) {
    //        // redirect to login page if not logged in and trying to access a restricted page
    //        if ($location.path() !== '/login' && !$rootScope.globals.currentUser) {
    //            $window.location.href = '/index.html';
    //        }
    //    });
    //}]);
});