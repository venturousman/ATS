define([], function () {
    'use strict';
    var shellModule = angular.module('shell');

    shellModule.directive('menu', ['$q', '$timeout', '$window', 'httpInterceptor', menuDirective]);
   
    function menuDirective($q, $timeout, $window, httpInterceptor) {
        return {
            restrict: 'E',
            replace: true,
            scope: {
            },
            templateUrl: 'app/modules/shell/directives/menu.html',
            link: function (scope, element, attrs) {                
                element.find('.extMenu').on('click', function () {
                  
                    var chkMenuVisible = $('#extMenuOverlay').is(':visible');
                    $()
                    if (chkMenuVisible) {
                        //$('.welcomeuser').show();
                        element.find('#extMenuOverlay').fadeOut('fast');
                        angular.element(this).removeClass('active');
                    } else {
                        element.find('#extMenuOverlay').fadeIn('fast');
                        angular.element(this).addClass('active');
                        //$('.welcomeuser').hide();
                       
                    }

                });//exMenu ends

                element.find('#extMenuOverlay').on('click', function () {
                    element.find('#extMenuOverlay').fadeOut('fast');
                    angular.element(this).removeClass('active');
                    $('.welcomeuser').show();
                });
            }
        };
    }
});