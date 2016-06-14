define([], function () {
    var dwModule = angular.module('shell');
    var baseUrl = 'https://ax7rtwdw1aos.cloudax.dynamics.com/data/';
    dwModule.constant('restServiceUrl', {
        'getAppointments': baseUrl + 'AppointmentTables',
        'getAppointmentDetails': baseUrl + "AppointmentTables?$filter=AppointmentNo eq ",
        'getAppointmentByCustomerID': baseUrl + "AppointmentTables?$filter=CustomerID eq ",
        'getCustomerDetails': '',
        'getOpenAppointmentCount': '',
        'getJobCardDetails': baseUrl + "SMSJobCardDetails?$filter=smsAppointmentNo eq ",
        'getProductDetails': baseUrl + "ReleasedDistinctProducts?$select=ProductNumber,ProductSearchName,ProductGroupId",
        'getConfirmedServiceList': baseUrl + "ConfirmedServiceListTables?$select=ItemId,ItemName&$filter=AppointmentNo eq ",
        'getProductCategories':''
    });
});