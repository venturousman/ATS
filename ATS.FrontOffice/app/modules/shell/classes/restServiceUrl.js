define([], function () {
    var shellModule = angular.module('shell');
    var baseUrl = 'http://localhost:54543/';
    shellModule.constant('restServiceUrl', {
        'getCourses': baseUrl + 'api/Course',
        //'getAppointments': baseUrl + 'AppointmentTables',
        //'getAppointmentDetails': baseUrl + "AppointmentTables?$filter=AppointmentNo eq ",
        //'getAppointmentByCustomerID': baseUrl + "AppointmentTables?$filter=CustomerID eq ",
        //'getCustomerDetails': '',
        //'getOpenAppointmentCount': '',
        //'getJobCardDetails': baseUrl + "SMSJobCardDetails?$filter=smsAppointmentNo eq ",
        //'getProductDetails': baseUrl + "ReleasedDistinctProducts?$select=ProductNumber,ProductSearchName,ProductGroupId",
        //'getConfirmedServiceList': baseUrl + "ConfirmedServiceListTables?$select=ItemId,ItemName&$filter=AppointmentNo eq ",
        //'getProductCategories':''
    });
});