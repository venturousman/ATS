'use strict';
define(['modules/attendanceTrackingSystem/services/courses'], function () {
    /// constructor to load default data or register all listening events
    function coursesController($scope, coursesServices) {

        initModel();
        loadCourseList();

        function initModel() {
            $scope.data = {
                courseList: [],
                selectedCourse: null,
                //isGridRowSelected: false
            };
        }

        function loadCourseList() {

            //angular.element('#divAppointmentGrid table tbody.tableScroll1, #cusDetContent').perfectScrollbar({
            //    wheelSpeed: 1,
            //    wheelPropagation: true
            //});

            coursesServices.getCourses().then(function (data) {
                //console.log('courses', data);
                //$scope.data.courseList = _.filter(data, function (item, i) {
                //    return item.smsAppointmentStatus == 'Appointment';
                //});
                $scope.data.courseList = data;
            }).then(function () {
                //if ($scope.data.courseList != null && $scope.data.courseList.length > 0) {
                //    //Select the first appointment row--starts
                //    $scope.data.selectedAppointment = $scope.data.courseList[0];
                //    $scope.data.selectedVehicle = getVehicle($scope.data.selectedAppointment);
                //    getPreviousAppointments($scope.data.selectedAppointment);
                //    //Select the first appointment row--ends
                //    $rootScope.appointmentNo = $scope.data.selectedAppointment.AppointmentNo;
                //    $timeout(function () {
                //        $scope.data.isGridRowSelected = true;
                //        angular.element('#divAppointmentGrid table tbody.tableScroll1, #cusDetContent').perfectScrollbar('update');
                //        appPanelsWidth();
                //        appPanelsHeight();
                //        angular.element('#divAppointmentGrid table tbody tr:nth-child(1)').addClass('rowSelect');
                //    }, 200);
                //}
            });
        }

        $scope.selectCourse = function ($event, selectedCourse) {
            var target = $event.currentTarget;
            //var chkSelected = angular.element(target).hasClass('rowSelect');
            //if (chkSelected) {
            //    return;
            //}
            //$rootScope.appointmentNo = selectedAppointment.AppointmentNo;
            //$scope.data.isGridRowSelected = true;
            //$scope.data.selectedAppointment = selectedAppointment;
            //$scope.data.selectedVehicle = getVehicle(selectedAppointment);
            ////console.log(selectedAppointment);
            //getPreviousAppointments(selectedAppointment);
            //$timeout(function () {
            //    if (!chkSelected) {
            //        angular.element('#divAppointmentGrid .tableScroll1 tr').removeClass('rowSelect');
            //        angular.element(target).addClass('rowSelect');
            //    }
            //}, 100);
        };


    }
    // inject courses controller to attendanceTrackingSystem module
    angular.module('attendanceTrackingSystem').register.controller('courses', ['$scope', 'coursesServices', coursesController]);

    return coursesController;
});