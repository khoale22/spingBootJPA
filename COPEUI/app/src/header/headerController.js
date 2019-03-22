'use strict';

(function () {
	angular.module('productMaintenanceUiApp').controller('HeaderController', headerController);

	headerController.$inject = ['appName', 'StatusApi', '$rootScope', '$window', 'AuthenticationService', '$http'];

	function headerController(appName, statusApi, $rootScope, $window, AuthenticationService, $http) {

		var self = this;
        /**
		 * Holds the content message for showing warning message when
		 * mismatch version between api and ui.
         * @type {string}
         */
		const WARNING_MESSAGE_CONTENT = 'Application Version is Mismatch. Please press Ctrl F5.';
        /**
		 * Holds the key to get the time of version check when reload page.
         * @type {string}
         */
		const NUMBER_OF_VERSION_CHECKS = 'number_of_version_checks';
        /**
         * Holds the path of app info file.
         * @type {string}
         */
        const PATH_OF_APP_INFO_FILE = 'appinfo.json';
		/**
		 * The version of the application as reported by the server.
		 *
		 * @type {string}
		 */
		self.version = "";

		/**
		 * The name of the application server that is serving up information.
		 *
		 * @type {string}
		 */
		self.applicationServerName = "";

		/**
		 * The name of the application.
		 *
		 * @type {string}
		 */
		self.appName = appName;

		/**
		 * Initializes the controller.
		 */
		self.init = function() {
			statusApi.get({}, self.setVersion)
		};

		/**
		 * Callback for the response for the backend.
		 *
		 * @param result The data passed from the backend.
		 */
		self.setVersion = function(result) {
			self.version = result.version;
			self.applicationServerName = result.applicationServerName;
			// Check mismatch version.
           self.checkMismatchVersion();
		};
        /**
		 * This method is used to check version between api and ui. If it is difference, then show mismatch version message.
         */
        self.checkMismatchVersion = function () {
            // Check mismatch version.
            $http.get(PATH_OF_APP_INFO_FILE).success(function (response) {
                $rootScope.appVersion = response.version;
                if ($rootScope.appVersion != self.version) {
                    if (self.canShowWarningMessage()) {
                        //Second tome app should show mismatch version message.
                        $rootScope.isShowWarningMessage = true;
                        $rootScope.warningMessage = WARNING_MESSAGE_CONTENT;
                    } else {
                        // Clear session
                        AuthenticationService.invalidate();
                        // clear local storage.
                        $window.localStorage.clear();
                        // First time, app need to reload a time.
                        $window.location.reload(true);
                    }
                } else {
                    $rootScope.isShowWarningMessage = false;
                    // Remove number of version checks on session storage.
                    delete $window.sessionStorage[NUMBER_OF_VERSION_CHECKS];
                }
            });
        }
        /**
		 * Check can show warning message or not. And reset status to null if is existed.
         * @returns {boolean} true show warning message, otherwise not show.
         */
        self.canShowWarningMessage = function(){
            var numberOfVersionChecks = $window.sessionStorage[NUMBER_OF_VERSION_CHECKS];
            if(numberOfVersionChecks == undefined || numberOfVersionChecks == null){
            	// if it is none existed, then set it to one.
                $window.sessionStorage[NUMBER_OF_VERSION_CHECKS] = 1;
                return false;
			}
			// else if it is existing, then remove it and return true.
			delete $window.sessionStorage[NUMBER_OF_VERSION_CHECKS];
            return true;
		}
	}
})();
