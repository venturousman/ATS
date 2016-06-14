/// <summary>
/// we put all common api as a helper class which can be used across multi-modules
/// </summary>
define([], function () {
    var commonModule = angular.module('common');

    /// Common Api services
    /// </summary>
    commonModule.service('commonApi', ['constants', 'localize', '$window', '$q', function (constants, localize, $window, $q) {

        this.compareTwoObject = function (object1, object2) {
            if (!object1 || !object2) {
                return;
            }

            //For the first loop, we only check for types
            for (propName in object1) {
                //Check for inherited methods and properties - like .equals itself
                //https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/hasOwnProperty
                //Return false if the return value is different
                if (object1.hasOwnProperty(propName) != object2.hasOwnProperty(propName)) {
                    return false;
                }
                    //Check instance type
                else if (typeof object1[propName] != typeof object2[propName]) {
                    //Different types => not equal
                    return false;
                }
            }
            //Now a deeper check using other objects property names
            for (propName in object2) {
                //We must check instances anyway, there may be a property that only exists in object2
                //I wonder, if remembering the checked values from the first loop would be faster or not 
                if (object1.hasOwnProperty(propName) != object2.hasOwnProperty(propName)) {
                    return false;
                }
                else if (typeof object1[propName] != typeof object2[propName]) {
                    return false;
                }
                //If the property is inherited, do not check any more (it must be equa if both objects inherit it)
                if (!object1.hasOwnProperty(propName))
                    continue;

                //Now the detail check and recursion

                //object1 returns the script back to the array comparing
                /**REQUIRES Array.compare**/
                if (object1[propName] instanceof Array && object2[propName] instanceof Array) {
                    // recurse into the nested arrays
                    if (!this.compareTwoArray(object1[propName], object2[propName]))
                        return false;
                }
                else if (object1[propName] instanceof Object && object2[propName] instanceof Object) {
                    // recurse into another objects
                    //console.log("Recursing to compare ", object1[propName],"with",object2[propName], " both named \""+propName+"\"");
                    if (!this.compareTwoObject(object1[propName], object2[propName]))
                        return false;
                }
                    //Normal value comparison for strings and numbers
                else if (object1[propName] != object2[propName]) {
                    return false;
                }
            }
            //If everything passed, let's say YES
            return true;
        };
        // attach the .compare method to Array's prototype to call it on any array
        this.compareTwoArray = function (array1, array2) {
            // if the other array2 is a falsy value, return
            if (!array2)
                return false;

            // compare lengths - can save a lot of time
            if (array1.length != array2.length)
                return false;

            for (var i = 0, l = array1.length; i < l; i++) {
                // Check if we have nested array2s
                if (array1[i] instanceof Array && array2[i] instanceof Array) {
                    // recurse into the nested array2s
                    if (!this.compareTwoArray(array1[i], array2[i]))
                        return false;
                }
                    /**REQUIRES OBJECT COMPARE**/
                else if (array1[i] instanceof Object && array2[i] instanceof Object) {
                    // recurse into another objects
                    //console.log("Recursing to compare ", this[propName],"with",object2[propName], " both named \""+propName+"\"");
                    if (!this.compareTwoObject(array1[i], array2[i]))
                        return false;
                }
                else if (array1[i] != array2[i]) {
                    // Warning - two different object instances will never be equal: {x:20} != {x:20}
                    return false;
                }
            }
            return true;
        };

        /// <summary>
        /// random generate a string contains 4 characters
        /// </summary>
        function S4() {
            return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
        };

        /// <summary>
        /// create new Guid
        /// </summary>
        this.newGuid = function () {
            return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
        };

        /// <summary>
        /// Check whether a GUID is valid
        /// </summary>        
        this.isValidGuid = function (guid) {
            if (!!guid) {
                var reg = new RegExp("^(\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\}{0,1})$");
                return reg.test(guid);
            }

            return false;
        };

        /// <summary>
        /// format a date foloow given format pattern and return a String value
        /// read more https://github.com/jquery/globalize#find
        /// </summary>
        this.formatDate = function (date, format) {
            return Globalize.format(date, format || constants.DefaultDateFormat);
        };

        /// <summary>
        /// parse a string representing a date into a JavaScript Date object
        /// read more https://github.com/jquery/globalize#parse_date
        /// </summary>
        this.parseDate = function (date, format, locale) {
            if (angular.isDate(date)) {
                return new Date(date);
            } else {
                return Globalize.parseDate(date, format, locale);
            }
        };

        /// <summary>
        /// Read-only views of a numeric/money field should show it correctly formatted with the currency symbol (if money) 
        /// and thousand and decimal characters if appropriate.
        /// </summary>
        this.formatCurrency = function (money) {
            Globalize.culture().numberFormat.currency.symbol = '';
            return money ? Globalize.format(money, "c") : '0.00';
        }

        /// <summary>
        /// Convert UTC Date to Local Date
        /// </summary>
        this.UTCToLocalDate = function (utcDate, format) {
            var timeOffset = -((new Date()).getTimezoneOffset() / 60);
            var newDate = utcDate;
            newDate.setHours(newDate.getHours() + timeOffset);
            return this.formatDate(newDate, format);
        };

        /// <summary>
        /// get cookies value
        /// </summary>
        this.getCookie = function (cookieName) {
            var results = document.cookie.match('(^|;) ?' + cookieName + '=([^;]*)(;|$)');

            if (results) {
                return (results[2]);
            }
            return null;
        };
        /// <summary>
        /// set cookies value
        /// </summary>
        this.setCookie = function (cName, value, exdays) {
            var exdate = new Date(), cValue;
            exdate.setDate(exdate.getDate() + exdays);
            cValue = escape(value) + ((exdays === null) ? "" : "; expires=" + exdate.toUTCString()) + "; path=/";
            document.cookie = cName + "=" + cValue;
        };

        /// <summary>
        /// clear cookies value
        /// </summary>
        this.clearCookie = function (cName) {
            var exdate = new Date(), cValue;
            exdate.setDate(exdate.getDate() - 1);
            cValue = escape('') + "; expires=" + exdate.toUTCString() + "; path=/";
            document.cookie = cName + "=" + cValue;
        };

        /// <summary>
        /// call helper to apply resource,
        /// after that format string
        /// </summary>
        /// <param name="key">resource key</param>
        /// <param name="param">array</param>
        this.applyResource = function (key, params) {
            if (!params) {
                return localize.getLocalizedString(key);
            }

            var param = _.isArray(params) ? params : [params];
            return _.string.formatArgs(localize.getLocalizedString(key), param);
        };

        /// <summary>
        /// check today in range [from, to]
        /// return true if no range (mean both from & to are undefined)
        /// </summary>
        this.isTodayInRange = function (from, to) {
            var today = new Date().setHours(0, 0, 0, 0);
            // from, to have value
            if (!!from && !!to) return new Date(from).setHours(0, 0, 0, 0) <= today && today <= new Date(to).setHours(0, 0, 0, 0);
            // from undefined
            if (!from && !!to) return today <= new Date(to).setHours(0, 0, 0, 0);
            // to undefined
            if (!!from && !to) return new Date(from).setHours(0, 0, 0, 0) <= today;
            // from, to undefined
            return true;
        };

        /// <summary>
        /// remove unnecessary characters before call action to saving
        /// </summary>
        this.removeUnnecessaryCharacters = function (word) {
            word = word.replace(/[^\x21-\x7E]+/g, ' '); // change non-printing chars to spaces
            return word.replace(/^\s+|\s+$/g, '');      // remove leading/trailing spaces
        };

        /// <summary>
        /// get Date Now UTC
        /// </summary>
        this.getDateNowUTC = function () {
            var now = new Date(),
                dateUtc = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());
            return dateUtc;
        };

        /// <summary>
        /// Wait until the callback returns true. Callback will be called every interval time.
        /// The interval time defaults to 500ms if it is not given a value
        /// </summary>        
        this.spinUntil = function (scope, callback, intervalTime) {
            var def = $q.defer(), intervalId;

            intervalTime = !!intervalTime ? intervalTime : 500;
            if (angular.isFunction(callback)) {
                intervalId = setInterval(function () {
                    var resultObj = callback();
                    if (angular.isFunction(resultObj.then)) {
                        resultObj.then(function (result) {
                            if (!!result) {
                                clearInterval(intervalId);
                                def.resolve();
                            }
                        });
                    } else if (!!resultObj) {
                        clearInterval(intervalId);
                        def.resolve();
                    }
                }, intervalTime);
            }

            // need to clear intervalId interval when page is closed
            if (!!scope) {
                scope.$on('$destroy', function () {
                    if (!!intervalId) {
                        clearInterval(intervalId);
                    }
                });
            }
            return def.promise;
        };
    }]);
});