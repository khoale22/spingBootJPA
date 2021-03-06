/*
 *
 * matAttributeValuesController.js
 *
 * Copyright (c) 2019 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 * @author vn73545
 * @since 2.20.0
 */
'use strict';

/**
 * The controller for the Related Products Controller.
 */
(function() {

	var app=angular.module('productMaintenanceUiApp');
	app.controller('MatAttributeValuesController', matAttributeValuesController);

	matAttributeValuesController.$inject = ['$sce','urlBase','$scope','$http','BatchUploadResultsFactory','BatchUploadApi', 'ngTableParams', '$log'];
	/**
	 * Constructs the controller.
	 * @param excelUploadResultsFactory the modal factory.
	 */
	function matAttributeValuesController($sce, urlBase, $scope, $http, batchUploadResultsFactory, batchUploadApi, ngTableParams, $log) {

		var self = this;
		self.PAGE_SIZE = 100;
		self.WAIT_TIME = 120;
		self.downloading = false;
		$scope.actionUrl = urlBase+'/pm/matAttributeValues/downloadTemplate';
		/**
		 * Whether or not the controller is waiting for data
		 * @type {boolean}
		 */
		self.isWaiting = false;

		/**
		 * Attributes for each row in the table
		 * @type {Array}
		 */
		self.attributes = [];

		/**
		 * Used to keep track of the number of columns in the table
		 * @type {Array}
		 */
		self.columns = [];
		/**
		 * The maximum number of priorities an attribute has.
		 * @type {number}
		 */
		self.maxNumberofPriorities = 0;
		/**
		 * Used to keep track of the attribute name
		 * @type {Array}
		 */
		self.attributeNames = [];

		self.success;
		self.error;
		self.disableUpload=true;

		/**
		 * Initiates the construction of the eCommerce Attribute batch upload
		 */
		self.init = function () {
		};

		self.checkShowModal = function(){
			var file = document.getElementById("ecommerce-attr");
			self.disableUpload=!file.files.length>0;
		};
		/**
		 * Batch upload related products.
		 **/
		self.uploadRelatedProductsCall = function(){
			self.success=undefined;
			self.error=undefined;
			self.isWaiting=true;
			var file = document.getElementById("ecommerce-attr").files[0];
			var name = document.getElementById("nameRequest").value;
			var fd = new FormData();
			fd.append('file', file);
			fd.append('name', name);
			batchUploadApi.uploadMatAttributeValuesFile(fd,function (resp) {
				document.getElementById('form-upload').reset();
				var ele=document.getElementById("nameRequest");
				if(ele!=null){
					ele.value='';
				}
				self.isWaiting=false;
				self.error=undefined;
				batchUploadResultsFactory.showResultsModal(resp.transactionId);
			},function(err){
				document.getElementById('form-upload').reset();
				var ele=document.getElementById("nameRequest");
				if(ele!=null){
					ele.value='';
				}
				self.isWaiting=false;
				self.success=undefined;
				self.error=err.data.message;
			});
		};
	}
})();
