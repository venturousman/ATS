define(function (require) {
    var localizationModule = angular.module('localization');

    // simple translation filter
    // usage {{ TOKEN | i18n }}
    localizationModule.filter('i18n', ['localize', function (localize) {
        return function (input) {
            return localize.getLocalizedString(input);
        };
    }]);

    // translation directive that can handle dynamic strings
    // updates the text value of the attached element
    // usage <span data-i18n="TOKEN" ></span>
    // or
    // <span data-i18n="TOKEN|VALUE1|VALUE2" ></span>
    localizationModule.directive('i18n', ['localize', function (localize) {
        var i18nDirective = {
            restrict: "EAC",
            updateText: function (elm, token) {
                var values = token.split('|');
                if (values.length >= 1) {
                    // construct the tag to insert into the element
                    var tag = localize.getLocalizedString(values[0]);
                    // update the element only if data was returned
                    if ((tag !== null) && (tag !== undefined) && (tag !== '')) {
                        if (values.length > 1) {
                            for (var index = 1; index < values.length; index++) {
                                var target = '{' + (index - 1) + '}';
                                tag = tag.replace(target, values[index]);
                            }
                        }
                        // insert the text into the element
                        elm.html(tag);
                    };
                }
            },

            link: function (scope, elm, attrs) {
                scope.$on('localizeResourcesUpdates', function () {
                    i18nDirective.updateText(elm, attrs.i18n);
                });

                attrs.$observe('i18n', function (value) {
                    i18nDirective.updateText(elm, attrs.i18n);
                });

                scope.$on('$destroy', function () {
                    elm.remove();
                });
            }
        };

        return i18nDirective;
    }]);

    // translation directive that can handle dynamic strings
    // updates the attribute value of the attached element
    // usage <span data-i18n-attr="TOKEN|ATTRIBUTE" ></span>
    // or
    // <span data-i18n-attr="TOKEN|ATTRIBUTE|VALUE1|VALUE2" ></span>
    localizationModule.directive('i18nAttr', ['localize', function (localize) {
        var i18NAttrDirective = {
            restrict: "EAC",
            updateText: function (elm, token) {
                var values = token.split('|');
                // construct the tag to insert into the element
                var tag = localize.getLocalizedString(values[0]);
                // update the element only if data was returned
                if ((tag !== null) && (tag !== undefined) && (tag !== '')) {
                    if (values.length > 2) {
                        for (var index = 2; index < values.length; index++) {
                            var target = '{' + (index - 2) + '}';
                            tag = tag.replace(target, values[index]);
                        }
                    }
                    // insert the text into the element
                    elm.attr(values[1], tag);
                }
            },
            link: function (scope, elm, attrs) {
                scope.$on('localizeResourcesUpdates', function () {
                    i18NAttrDirective.updateText(elm, attrs.i18nAttr);
                });

                attrs.$observe('i18nAttr', function (value) {
                    i18NAttrDirective.updateText(elm, value);
                });
            }
        };

        return i18NAttrDirective;
    }]);

    // translation directive that can handle dynamic strings
    // updates the attribute value of the attached element
    // usage <i18n-html value='VALUE'></i18n-html>
    localizationModule.directive('i18nHtml', ['localize', function (localize) {
        return {
            restrict: 'E',
            replace: true,
            template: '',
            scope: {
                value: '=?'
            },
            link: function (scope, element, attrs) {
                scope.$on('localizeResourcesUpdates', function () {
                    element.html(localize.getLocalizedString(scope.value));
                });
                attrs.$observe('i18nHtml', function (value) {
                    element.html(localize.getLocalizedString(scope.value));
                });
            }
        };
    }]);
});// define