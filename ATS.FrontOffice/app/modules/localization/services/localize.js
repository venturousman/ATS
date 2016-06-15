define(function (require) {
    // localization service responsible for retrieving resource files from the server and
    // managing the translation dictionary
    angular.module('localization').factory('localize', ['$http', '$rootScope', '$window', '$filter', '$log', '$q', function ($http, $rootScope, $window, $filter, $log) {
        var localize = {
            // use the $window service to get the language of the user's browser
            language: $window.navigator.userLanguage || $window.navigator.language,
            // array to hold the localized resource string entries
            dictionary: [],
            // modulesLoaded
            modules: {},

            // allows setting of language on the fly
            setLanguage: function (value) {
                localize.language = value;
            },

            // indicate resource for given module has been loaded or not
            isModuleLoaded: function (moduleName) {
                if (localize.modules[moduleName]) {
                    return true;
                } else {
                    localize.modules[moduleName] = moduleName;
                    return false;
                }
            },

            // feed json data to memory dictionary
            feedData: function (data) {
                // store the returned array in the dictionary
                localize.dictionary = _.union(localize.dictionary, data);
                // broadcast that the file has been loaded
                $rootScope.$broadcast('localizeResourcesUpdates');
            },

            // checks the dictionary for a localized resource string
            getLocalizedString: function (value) {
                // default the result to an empty string
                var result = '';

                // make sure the dictionary has valid data
                if ((localize.dictionary !== []) && (localize.dictionary.length > 0)) {
                    // use the filter service to only return those entries which match the value
                    // and only take the first result
                    var entry = $filter('filter')(localize.dictionary, function (element) {
                        return element.key === value;
                    })[0];

                    if (!entry) {
                        $log.log("The Key: " + value + " is missing.");
                        // the result should be input 'key' if resource is missing
                        result = value;
                    } else {
                        // set the result
                        result = entry.value;
                    }
                }
                // return the value to the call
                return result;
            }
        };

        // return the local instance when called
        return localize;
    }]);
});// define