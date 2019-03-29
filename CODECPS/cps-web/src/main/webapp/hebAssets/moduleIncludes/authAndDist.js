
function isValidDom(el){
	if(null != el && el != undefined){
		return true;
	}
	return false;
}


function arrangeVendors(data){
		var tbody = document.getElementById('venTbody');	
		for(var i=0;i<tbody.rows.length;i++){
			tbody.deleteRow(i);
		}
		var newRow = tbdoy.insertRow(-1);
		
		
	}
	
	function arrangeWHS(data){
		var tbody = document.getElementById('wareTbody');
	
	}
	
	function calculateMasterCube(){
		var maxMasterCube = 999.99;
		var masterLength1 = YAHOO.util.Dom.get("masterLength").value;
		var masterWidth1 = YAHOO.util.Dom.get("masterWidth").value;
		var masterHeight1 = YAHOO.util.Dom.get("masterHeight").value;
		if(null != masterLength1 && null != masterWidth1 && null != masterHeight1){
		var reslt = ((masterLength1*masterWidth1*masterHeight1)/1728);
			var rndReslt = Math.round(reslt * 100)/100;
			if (rndReslt <= maxMasterCube){
				if(rndReslt == 0.0 || rndReslt == 0.00 || rndReslt == 0.000 || rndReslt == 0){
					if(masterLength1 != 0 && masterWidth1 != 0 && masterHeight1 != 0){
						rndReslt = 0.001;
					}
				}
				document.getElementById('masterCubeLabel').innerText = ''+rndReslt;
			} else {
	           alert('The calculated Master pack Cube value [' + rndReslt + '] is above the maximum limit ['+ maxMasterCube +']'+"\n"+
	           'Please re-enter the Master Pack dimensions');
            }
		}
		
	}
	function calculateShipCube(){
		var masterShipCube = 999.99;
		var shipLength1 = YAHOO.util.Dom.get("shipLength").value;
		var shipWidth1 = YAHOO.util.Dom.get("shipWidth").value;
		var shipHeight1 = YAHOO.util.Dom.get("shipHeight").value;
		if(null != shipLength1 && null != shipWidth1 && null != shipHeight1){
			var reslt = ((shipLength1*shipWidth1*shipHeight1)/1728);
			var rndReslt = Math.round(reslt * 100)/100;//rounding to two decimal places..
			if (rndReslt <= masterShipCube){
				if(rndReslt == 0.0 || rndReslt == 0.00 || rndReslt == 0.000 || rndReslt == 0){
					if(shipLength1 != 0 && shipWidth1 != 0 && shipHeight1 != 0){
						rndReslt = 0.001;
					}
				}
				document.getElementById('shipCubeLabel').innerText = ''+rndReslt;
			} else {
				alert('The calculated Ship pack Cube value [' + rndReslt + '] is above the maximum limit ['+ masterShipCube +' ]'+ "\n"+'Please re-enter the Ship Pack dimensions');
            }
		}
	}
	
	function clearCaseDetailsForChannelChange(){	
	   		
			setValue(document.getElementById('caseUpcText'),'');
			setValue(document.getElementById('caseCheckDigit'),'');
			setValue(document.getElementById('unitFactor'),'');
			setValue(document.getElementById('masterLength'),'');
			setValue(document.getElementById('masterHeight'),'');
			setValue(document.getElementById('masterWeight'),'');
			setValue(document.getElementById('masterWidth'),'');
			setValue(document.getElementById('shipPackText'),'');
			setValue(document.getElementById('shipLength'),'');
			setValue(document.getElementById('shipWeight'),'');
			setValue(document.getElementById('shipHeight'),'');
			setValue(document.getElementById('shipWidth'),'');
			setValue(document.getElementById('shelfDays'),'');
			setValue(document.getElementById('inboundDays'),'');
			setValue(document.getElementById('reactionDays'),'');
			setValue(document.getElementById('guaranteestoreDays'),'');
			setValue(document.getElementById('oneTouchType'),'');
			setValue(document.getElementById('itmCategory'),'');
			setValue(document.getElementById('maxShipText'),'');
			setValue(document.getElementById('masterPackText'),'');
			//setValue(document.getElementById('purchaseStatus'),'');
			document.getElementById('purchaseStatus').selectedIndex = 0;
		 	if(document.getElementById('catchRadio')){
		 		document.getElementById('catchRadio').checked = false;
		 	}
		 	if(document.getElementById('variableRadio')){
		 		document.getElementById('variableRadio').checked = false;
		 	}
		 	if(document.getElementById('noneRadio')){
		 		document.getElementById('noneRadio').checked = false;
		 	}
		 	if(document.getElementById('masterCubeLabel')){
				document.getElementById('masterCubeLabel').innerText = '';		
			}
		 	if(document.getElementById('shipCubeLabel')){
	 			document.getElementById('shipCubeLabel').innerText = '';
	 		}
		}
	
	function showWhs_details(sho){
		for(i = 0; i < 8; i++){
			var whs_details = document.getElementById('whs_details'+i);
			
			if(whs_details){
				if(sho == true){
					whs_details.style.visibility = 'visible';
					whs_details.style.position = 'static';
				}else{
					whs_details.style.visibility = 'hidden';
					whs_details.style.position = 'absolute';
				}
			}
		}
	}
	
	function changePurchaseStatus() {
		for(i=0;i<document.all('purchaseStatus').length;i++)
		{
			if(document.all('purchaseStatus').options[i].value=="S")
			{
				document.all('purchaseStatus').selectedIndex=i;
				break;
			}
		}
	}
	
	/*called on selecting values from the channel*/
	function selectChannel(){
	  var sel = document.getElementById('actions3');
	  var caseUpcDiv = document.getElementById('caseUpcDiv');
	  var oneTuchTypeDiv = document.getElementById('oneTuchTypeDiv');
	  var shipPackDiv = document.getElementById('shipPackDiv');
      var whs_details = document.getElementById('whs_details');
      var masterPackDiv = document.getElementById('masterPackDiv');
      var codeDateDiv = document.getElementById('codeDateDiv');
      var venTierText = document.getElementById('venTierText');
      var venTier = document.getElementById('venTier');
      var venTieText = document.getElementById('venTieText');
      var venTie = document.getElementById('venTie');
      
      var orderRes = document.getElementById('orderRes');
      var orderResLabel= document.getElementById('orderResLabel');

      var costLink = document.getElementById('costLink');
      var costLinkLabel= document.getElementById('costLinkLabel');         
      var displayReadyUnitDiv = document.getElementById('displayReadyUnitDiv');  
      var dsplyDryPalSwId = document.getElementById('dsplyDryPalSwId');	
      if(sel.options[sel.selectedIndex].value == 'DSD'){
        if(whs_details){
			whs_details.style.visibility = 'hidden';
			whs_details.style.position = 'absolute';
		}
        showWhs_details(false);
		 if(caseUpcDiv){
			caseUpcDiv.style.visibility = 'hidden';
			caseUpcDiv.style.position = 'absolute';
		}
		 if(oneTuchTypeDiv){
			 oneTuchTypeDiv.style.visibility = 'hidden';
			 oneTuchTypeDiv.style.position = 'absolute';
		}
	// if(displayReadyUnitDiv){			 
		//	 displayReadyUnitDiv.style.visibility = 'hidden';
		//	 displayReadyUnitDiv.style.position = 'absolute';
		//} 
		if(displayReadyUnitDiv){
			displayReadyUnitClick();
			var typeDisplayReadyUnitId = document.getElementById('typeDisplayReadyUnitId');			
			displayReadyUnitDiv.style.visibility = 'visible';
			displayReadyUnitDiv.style.position = 'static';				
		} 
		 if(shipPackDiv){
			 shipPackDiv.style.visibility = 'hidden';
			 shipPackDiv.style.position = 'absolute';
		}
		if(masterPackDiv){
			masterPackDiv.style.visibility = 'visible';
			masterPackDiv.style.position = 'static';
			document.getElementById('masterPackText').value = "";
		}
		if(orderRes){
        	orderRes.style.display = 'none';
		}
		if(orderResLabel){
			orderResLabel.style.display = 'none';
		}
		if(costLink){
			costLink.style.display = 'none';
		}
		if(costLinkLabel){
			costLinkLabel.style.display = 'none';
		}			
		hideVendor();
		hideEWM();
		var codeDate;
		if(document.getElementById('codeDate')){
			codeDate = document.getElementById('codeDate').checked;
		}
		if(codeDate){
			document.getElementById('codeDate').checked = false;
			if(codeDateDiv){
				codeDateDiv.style.visibility = 'hidden';
				codeDateDiv.style.position = 'absolute';
			}
		}
		showCaseDetailsWtHtRadioSection(false);
		showVendorCostLinkDetails(false);
		showSubDept(true);		
		try{
		clearCaseDetailsForChannelChange();
		}catch(e){}
      }else if(sel.options[sel.selectedIndex].value == 'WHS'||sel.options[sel.selectedIndex].value == 'BOTH'){
            //document.getElementById('import').disabled = false;
    	    dispEWM();
            if(whs_details){
				whs_details.style.visibility = 'visible';
				whs_details.style.position = 'static';
			}
            showWhs_details(true);
			if(caseUpcDiv){
				caseUpcDiv.style.visibility = 'visible';
				caseUpcDiv.style.position = 'static';
			}
			if(oneTuchTypeDiv){
				oneTuchTypeDiv.style.visibility = 'visible';
				oneTuchTypeDiv.style.position = 'static';
		    }
			if(displayReadyUnitDiv){				
				 var typeDisplayReadyUnitId = document.getElementById('typeDisplayReadyUnitId');
				 displayReadyUnitClick();				
				displayReadyUnitDiv.style.visibility = 'visible';
				displayReadyUnitDiv.style.position = 'static';
				displayReadyUnitDiv.style.visibility = 'visible';
				displayReadyUnitDiv.style.position = 'static';
			} 
			
		    if(shipPackDiv){ 
		    	shipPackDiv.style.visibility = 'visible';
		    	shipPackDiv.style.position = 'static';
		    }
			if(masterPackDiv){
				masterPackDiv.style.visibility = 'visible';
				masterPackDiv.style.position = 'static';
			}
			if(venTierText){
				venTierText.style.display = 'block';
			}	
			if(venTier){
				venTier.style.display = 'block';
			}
			if(venTieText){
				venTieText.style.display = 'block';
			}
			if(venTie){
				venTie.style.display = 'block';
			}
			if(orderRes){
	        	orderRes.style.display = 'block';
			}	
			if(orderResLabel){
				orderResLabel.style.display = 'block';
			}		
			if(costLink){
				costLink.style.display = 'block';
			}
			if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			}				
			
			//HungBang added clear fields when not save Case 04Feb2016
			try{
    	  		clearCaseDetailsForChannelChange();
  			}catch(e){}
			
			var codeDate;
			if(document.getElementById('codeDate')){
				codeDate = document.getElementById('codeDate').checked;
			}
			if(codeDate){
				if(codeDateDiv){
					codeDateDiv.style.visibility = 'visible';
					codeDateDiv.style.position = 'static';
				}
			}
			showCaseDetailsWtHtRadioSection(true);
			showVendorCostLinkDetails(true)
			setDefaultMaxShipValue();
			if(sel.options[sel.selectedIndex].value == 'BOTH'){
				showSubDept(true);
			}else{
				showSubDept(false);
			}
			changePurchaseStatus();
      }else{
            if(whs_details){
				whs_details.style.visibility = 'hidden';
				whs_details.style.position = 'absolute';
			}
            showWhs_details(false);
			 if(caseUpcDiv){
				caseUpcDiv.style.visibility = 'hidden';
				caseUpcDiv.style.position = 'absolute';
			}
			 if(oneTuchTypeDiv){
			   oneTuchTypeDiv.style.visibility = 'hidden';
			   oneTuchTypeDiv.style.position = 'absolute';
		    }
			 if(displayReadyUnitDiv){
				 if(document.getElementById('dsplyDryPalSwId').checked){					 
					 document.getElementById('dsplyDryPalSwId').checked = false;
				 }
				 displayReadyUnitClick();
				displayReadyUnitDiv.style.visibility = 'hidden';
				displayReadyUnitDiv.style.position = 'absolute';
			}			
		     if(shipPackDiv){
		   	   shipPackDiv.style.visibility = 'hidden';
			   shipPackDiv.style.position = 'absolute';
		    }
			if(masterPackDiv){
				masterPackDiv.style.visibility = 'hidden';
				masterPackDiv.style.position = 'absolute';
			}
			if(document.getElementById('codeDate')){
				document.getElementById('codeDate').checked = false;
			}
			if(codeDateDiv){
				codeDateDiv.style.visibility = 'hidden';
				codeDateDiv.style.position = 'absolute';
			}
			if(orderRes){
	        	orderRes.style.display = 'block';
			}	
			if(orderResLabel){
				orderResLabel.style.display = 'block';
			}	
			if(costLink){
				costLink.style.display = 'block';
			}
			if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			}			
			if(venTierText){
				venTierText.style.display = 'block';
			}	
			if(venTier){
				venTier.style.display = 'block';
			}
			if(venTieText){
				venTieText.style.display = 'block';
			}
			if(venTie){
				venTie.style.display = 'block';
			}
			showCaseDetailsWtHtRadioSection(false);
			showVendorCostLinkDetails(true);
			showSubDept(false);
      }
      if(document.getElementById('buttonHolder')){
	      if(sel.options[sel.selectedIndex].value == ''){
	      	if(document.getElementById('buttonHolder')){
	      		document.getElementById('buttonHolder').style.display = 'none';
	      	} 
	      }else{
	        if(document.getElementById('buttonHolder')){
	      		document.getElementById('buttonHolder').style.display = 'block';
	      	}
	      }
	   }
	}
	
	//DRU
	function onReadyUnitChange(sel){		
		var selected = sel.options[sel.selectedIndex].value;			
		if(selected == 9){			
			document.getElementById('orientationOfDrp').innerHTML = 'Orientation Of RRP on shelf<em><font color="red"><b>*</b></font></em>';
			document.getElementById('typeDisplayReadyUnitValue').style.visibility = 'visible';
			document.getElementById('typeDisplayReadyUnitValue').style.position = 'static';			
		} else if(selected == 7){			
			document.getElementById('orientationOfDrp').innerHTML = 'Orientation Of DRP<em><font color="red"><b>*</b></font></em>';
			document.getElementById('typeDisplayReadyUnitValue').style.visibility = 'visible';
			document.getElementById('typeDisplayReadyUnitValue').style.position = 'static';			
		} else {
			document.getElementById('typeDisplayReadyUnitValue').style.visibility = 'hidden';
			document.getElementById('typeDisplayReadyUnitValue').style.position = 'absolute';
			var typeDisplayReadyUnitValue = document.getElementById('typeDisplayReadyUnitValue');
			typeDisplayReadyUnitValue.style.visibility = 'hidden';
			typeDisplayReadyUnitValue.style.position = 'absolute';
		}		
	}
	function displayReadyUnitClick(){	
		var typeDisplayReadyUnitId = document.getElementById('typeDisplayReadyUnitId');		
		var dsplyDryPalSwId = document.getElementById('dsplyDryPalSwId');	
		var displayReadyfieldset = document.getElementById('displayReadyfieldset');
		if(dsplyDryPalSwId){		
			if(dsplyDryPalSwId.checked){			
				typeDisplayReadyUnitId.style.visibility = 'visible';				
				typeDisplayReadyUnitId.style.position = 'static';		
				if(displayReadyfieldset){
					displayReadyfieldset.style.visibility = 'visible';				
					displayReadyfieldset.style.position = 'static';	
				}
				onReadyUnitChange(document.getElementById('srsAffTypCdId'));				
			}else{			
				typeDisplayReadyUnitId.style.visibility = 'hidden';
				typeDisplayReadyUnitId.style.position = 'absolute';
				if(displayReadyfieldset){
					displayReadyfieldset.style.visibility = 'hidden';				
					displayReadyfieldset.style.position = 'absolute';	
				}
				var typeDisplayReadyUnitValue = document.getElementById('typeDisplayReadyUnitValue');
				typeDisplayReadyUnitValue.style.visibility = 'hidden';
				typeDisplayReadyUnitValue.style.position = 'absolute';
				if(document.getElementById("prodFcngNbrId")){
					document.getElementById("prodFcngNbrId").value = "";
				}
				if(document.getElementById("prodRowDeepNbrId")){
					document.getElementById("prodRowDeepNbrId").value = "";
				}
				if(document.getElementById("prodRowHiNbrId")){
					document.getElementById("prodRowHiNbrId").value = "";
				}
				if(document.getElementById('srsAffTypCdId')){
					document.getElementById('srsAffTypCdId').selectedIndex = 0;
				}
				if(document.getElementById('nbrOfOrintNbrId')){
					document.getElementById('nbrOfOrintNbrId').selectedIndex = 0;
				}
			}	
		}		
	}
	function displayReadyUnitMRTClick(){	
		var typeDisplayReadyUnitId = document.getElementById('typeDisplayReadyUnitId');		
		var dsplyDryPalSwId = document.getElementById('dsplyDryPalSwId');
		var displayReadyfieldset = document.getElementById('displayReadyfieldset');
		if(dsplyDryPalSwId){		
			if(dsplyDryPalSwId.checked){	
				if(displayReadyfieldset){
					displayReadyfieldset.style.visibility = 'visible';				
					displayReadyfieldset.style.position = 'static';	
				}
				typeDisplayReadyUnitId.style.visibility = 'visible';				
				typeDisplayReadyUnitId.style.position = 'static';	
				onReadyUnitChange(document.getElementById('srsAffTypCdId'));
			}else{
				if(displayReadyfieldset){
					displayReadyfieldset.style.visibility = 'hidden';				
					displayReadyfieldset.style.position = 'absolute';	
				}
				typeDisplayReadyUnitId.style.visibility = 'hidden';
				typeDisplayReadyUnitId.style.position = 'absolute';
				var typeDisplayReadyUnitValue = document.getElementById('typeDisplayReadyUnitValue');
				typeDisplayReadyUnitValue.style.visibility = 'hidden';
				typeDisplayReadyUnitValue.style.position = 'absolute';				
			}	
		}		
	}
	//END DRU
	function selectChannelAjax(){
		var sel = document.getElementById('actions3');
		var caseUpcDiv = document.getElementById('caseUpcDiv');
		var whs_details = document.getElementById('whs_details');
		var masterPackDiv = document.getElementById('masterPackDiv');
		var shipPackDiv = document.getElementById('shipPackDiv');
		var codeDateDiv = document.getElementById('codeDateDiv');
		var venTierText = document.getElementById('venTierText');
		var venTier = document.getElementById('venTier');
		var venTieText = document.getElementById('venTieText');
		var venTie = document.getElementById('venTie');  
		var orderRes = document.getElementById('orderRes');
		var orderResLabel= document.getElementById('orderResLabel');
	    var costLink = document.getElementById('costLink');
	    var costLinkLabel= document.getElementById('costLinkLabel');		
	    var displayReadyUnitDiv = document.getElementById('displayReadyUnitDiv');   
		if(sel.options[sel.selectedIndex].value == 'DSD'){
            //document.getElementById('import').disabled = true;
            if(whs_details){
            	whs_details.style.visibility = 'hidden';
				whs_details.style.position = 'absolute';
            }
            showWhs_details(false);
            if(caseUpcDiv){
            	caseUpcDiv.style.visibility = 'hidden';
				caseUpcDiv.style.position = 'absolute';
            }
            if(masterPackDiv){
            	masterPackDiv.style.visibility = 'visible';
				masterPackDiv.style.position = 'static';
            }

            if(orderRes){
            	orderRes.style.display = 'none';
    		}	
    		if(orderResLabel){
    			orderResLabel.style.display = 'none';
    		}    
    		if(costLink){
    			costLink.style.display = 'none';
    		}
    		if(costLinkLabel){
    			costLinkLabel.style.display = 'none';
    		}    		
			var codeDate = document.getElementById('codeDate').checked;
			if(codeDate){
				document.getElementById('codeDate').checked = false;
				codeDateDiv.style.visibility = 'hidden';
				codeDateDiv.style.position = 'absolute';
			}
			//if(displayReadyUnitDiv){
			//	displayReadyUnitDiv.style.visibility = 'hidden';
			//	displayReadyUnitDiv.style.position = 'absolute';
			//}			
			hideVendor();
			hideEWM();
			showCaseDetailsWtHtRadioSection(false);
			showVendorCostLinkDetails(false);
			showSubDept(true);

		}else if(sel.options[sel.selectedIndex].value == 'WHS'||sel.options[sel.selectedIndex].value == 'BOTH'){
            //document.getElementById('import').disabled = false;
			dispEWM();
            if(whs_details){
            	whs_details.style.visibility = 'visible';
            	whs_details.style.position = 'static';
            }
            showWhs_details(true);
			if(caseUpcDiv){
				caseUpcDiv.style.visibility = 'visible';
				caseUpcDiv.style.position = 'static';
			}
			if(masterPackDiv){
				masterPackDiv.style.visibility = 'visible';
				masterPackDiv.style.position = 'static';
			}
			if(shipPackDiv){
				shipPackDiv.style.visibility = 'visible';
				shipPackDiv.style.position = 'static';
			}
			if(venTierText){
				venTierText.style.display = 'block';
			}	
			if(venTier){
				venTier.style.display = 'block';
			}
			if(venTieText){
				venTieText.style.display = 'block';
			}
			if(orderRes){
	        	orderRes.style.display = 'block';
			}	
			if(orderResLabel){
				orderResLabel.style.display = 'block';
			}	
			if(costLink){
				costLink.style.display = 'block';
			}
			if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			}			
			if(venTie){
				venTie.style.display = 'block';
			}
			showCaseDetailsWtHtRadioSection(true);
			showVendorCostLinkDetails(true);
			setDefaultMaxShipValue();
			if(sel.options[sel.selectedIndex].value == 'BOTH'){
				showSubDept(true);
			}else{
				showSubDept(false);
			}

		}else{
			whs_details.style.visibility = 'hidden';
			whs_details.style.position = 'absolute';
			showWhs_details(false);
			if(caseUpcDiv){
			caseUpcDiv.style.visibility = 'hidden';
			caseUpcDiv.style.position = 'absolute';
			}
				masterPackDiv.style.visibility = 'hidden';
				masterPackDiv.style.position = 'absolute';
				document.getElementById('codeDate').checked = false;
				codeDateDiv.style.visibility = 'hidden';
				codeDateDiv.style.position = 'absolute';
				if(shipPackDiv){
		   	   		shipPackDiv.style.visibility = 'hidden';
			   		shipPackDiv.style.position = 'absolute';
		    	}
				if(orderRes){
		        	orderRes.style.display = 'block';
				}	
				if(orderResLabel){
					orderResLabel.style.display = 'block';
				}

				if(venTierText){
					venTierText.style.display = 'block';
				}	
				if(venTier){
					venTier.style.display = 'block';
				}
				if(venTieText){
					venTieText.style.display = 'block';
				}
				if(venTie){
					venTie.style.display = 'block';
				}
				if(costLink){
					costLink.style.display = 'block';
				}
				if(costLinkLabel){
					costLinkLabel.style.display = 'block';
				}				
				showCaseDetailsWtHtRadioSection(false);
				showVendorCostLinkDetails(true);
				showSubDept(false);
	      }
      
      if(document.getElementById('buttonHolder')){
	      if(sel.options[sel.selectedIndex].value == ''){
	      	document.getElementById('buttonHolder').style.display = 'none'; 
	      }else{
	      	document.getElementById('buttonHolder').style.display = 'block';
	      }
	   }
	    if(displayReadyUnitDiv){
    	  displayReadyUnitClick();
      }    
	}
	function removeVendorMatchChannel(){
//	 	remove data of Vendor
		if(document.getElementById("vendorACInput") != null){
			document.getElementById("vendorACInput").value = "";
			if(YAHOO.util.Dom.get('vendorLocationVal')){
				YAHOO.util.Dom.get('vendorLocationVal').value = "";			
				}
		}
	}
	/*called on selecting values from the channel for MRT*/
	function selectChannelMRT(){
	  var sel = document.getElementById('actions3');
      var whs_details = document.getElementById('whs_details');
      var masterPackDiv = document.getElementById('masterPackDiv');
      var codeDateDiv = document.getElementById('codeDateDiv');
      var oneTuchTypeDiv = document.getElementById('oneTuchTypeDiv');
	  var shipPackDiv = document.getElementById('shipPackDiv');
      var venTierText = document.getElementById('venTierText');
	  var venTier = document.getElementById('venTier');
	  var venTieText = document.getElementById('venTieText');
	  var venTie = document.getElementById('venTie'); 
	  var orderRes = document.getElementById('orderRes');
	  var orderResLabel= document.getElementById('orderResLabel');	
      var costLink = document.getElementById('costLink');
      var costLinkLabel= document.getElementById('costLinkLabel');
      var displayReadyUnitDiv = document.getElementById('displayReadyUnitDiv');   
	  /*
	   * check channel is empty. 
	   * @author khoapkl
	   */
	  if(sel.selectedIndex!=-1) {
		if(sel.options[sel.selectedIndex].value == 'DSD'){
    	showWhs_details(false);
        if(whs_details){
			whs_details.style.visibility = 'hidden';
			whs_details.style.position = 'absolute';
		}
        if(oneTuchTypeDiv){
        	oneTuchTypeDiv.style.visibility = 'hidden';
        	oneTuchTypeDiv.style.position = 'absolute';
		}
        if(shipPackDiv){
        	shipPackDiv.style.visibility = 'hidden';
        	shipPackDiv.style.position = 'absolute';
		}
		if(masterPackDiv){
			masterPackDiv.style.visibility = 'visible';
			masterPackDiv.style.position = 'static';
		}
		if(orderRes){
        	orderRes.style.display = 'none';
		}	
		if(orderResLabel){
			orderResLabel.style.display = 'none';
		}	
		if(costLink){
			costLink.style.display = 'none';
		}
		if(costLinkLabel){
			costLinkLabel.style.display = 'none';
		}		
		hideVendor();
		hideEWM();
		var codeDate;
		if(document.getElementById('codeDate')){
			codeDate = document.getElementById('codeDate').checked;
		}
		if(codeDate){
			document.getElementById('codeDate').checked = false;
			if(codeDateDiv){
				codeDateDiv.style.visibility = 'hidden';
				codeDateDiv.style.position = 'absolute';
			}
		}
		if(document.getElementById('masterPackText').value == ""){
			document.getElementById('masterPackText').value = "1";
		}
		showCaseDetailsWtHtRadioSection(false);
		showVendorCostLinkDetails(false);
		if(displayReadyUnitDiv){
			displayReadyUnitDiv.style.visibility = 'visible';
			displayReadyUnitDiv.style.position = 'static';
			displayReadyUnitMRTClick();
			var typeDisplayReadyUnitId = document.getElementById('typeDisplayReadyUnitId');			
			displayReadyUnitDiv.style.visibility = 'visible';
			displayReadyUnitDiv.style.position = 'static';				
		} 		
		try{
			 clearCaseDetailsForChannelChangeMRT();
		}catch(e){}
      }else if(sel.options[sel.selectedIndex].value == 'WHS'||sel.options[sel.selectedIndex].value == 'BOTH'){
    	   showWhs_details(true);
            if(whs_details){
				whs_details.style.visibility = 'visible';
				whs_details.style.position = 'static';
			}
            if(oneTuchTypeDiv){
            	oneTuchTypeDiv.style.visibility = 'visible';
            	oneTuchTypeDiv.style.position = 'static';
			}
            if(shipPackDiv){
            	shipPackDiv.style.visibility = 'visible';
            	shipPackDiv.style.position = 'static';
		    	if(document.getElementById('shipPackText').value == ""){
					document.getElementById('shipPackText').value = "1";
				}
			}
			if(masterPackDiv){
				masterPackDiv.style.visibility = 'visible';
				masterPackDiv.style.position = 'static';
				if(document.getElementById('masterPackText').value == ""){
					document.getElementById('masterPackText').value = "1";
				}
			}
			if(venTierText){
				venTierText.style.display = 'block';
			}	
			if(venTier){
				venTier.style.display = 'block';
			}
			if(venTieText){
				venTieText.style.display = 'block';
			}
			if(orderRes){
	        	orderRes.style.display = 'block';
			}	
			if(orderResLabel){
				orderResLabel.style.display = 'block';
			}		
			if(venTie){
				venTie.style.display = 'block';
			}
			if(costLink){
				costLink.style.display = 'block';
			}
			if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			}			
			var codeDate;
			if(document.getElementById('codeDate')){
			codeDate = document.getElementById('codeDate').checked;
			}
			if(codeDate){
				if(codeDateDiv){
					codeDateDiv.style.visibility = 'visible';
					codeDateDiv.style.position = 'static';
				}
			}
			showCaseDetailsWtHtRadioSection(true);
			showVendorCostLinkDetails(true);
			setDefaultMaxShipValue();
			changePurchaseStatus();
			if(displayReadyUnitDiv){
				displayReadyUnitDiv.style.visibility = 'visible';
				displayReadyUnitDiv.style.position = 'static';
				displayReadyUnitMRTClick();
				var typeDisplayReadyUnitId = document.getElementById('typeDisplayReadyUnitId');				
				displayReadyUnitDiv.style.visibility = 'visible';
				displayReadyUnitDiv.style.position = 'static';				
			} 			
      }else{
    	    showWhs_details(false);
            if(whs_details){
				whs_details.style.visibility = 'hidden';
				whs_details.style.position = 'absolute';
			}
            if(oneTuchTypeDiv){
            	oneTuchTypeDiv.style.visibility = 'hidden';
            	oneTuchTypeDiv.style.position = 'absolute';
			}
            if(shipPackDiv){
            	shipPackDiv.style.visibility = 'hidden';
            	shipPackDiv.style.position = 'absolute';
			}
			if(masterPackDiv){
				masterPackDiv.style.visibility = 'hidden';
				masterPackDiv.style.position = 'absolute';
			}
			if(document.getElementById('codeDate')){
				document.getElementById('codeDate').checked = false;
			}
			if(codeDateDiv){
				codeDateDiv.style.visibility = 'hidden';
				codeDateDiv.style.position = 'absolute';
			}
			 if(displayReadyUnitDiv){
				displayReadyUnitMRTClick();
				displayReadyUnitDiv.style.visibility = 'hidden';
				displayReadyUnitDiv.style.position = 'absolute';
			}
			if(document.getElementById('catchRadio')){
		 		document.getElementById('catchRadio').checked = false;
		 	}
		 	if(document.getElementById('variableRadio')){
		 		document.getElementById('variableRadio').checked = false;
		 	}
		 	if(document.getElementById('noneRadio')){
		 		document.getElementById('noneRadio').checked = false;
		 	}
			if(venTierText){
				venTierText.style.display = 'block';
			}	
			if(venTier){
				venTier.style.display = 'block';
			}
			if(orderRes){
	        	orderRes.style.display = 'block';
			}	
			if(orderResLabel){
				orderResLabel.style.display = 'block';
			}		
			if(venTieText){
				venTieText.style.display = 'block';
			}
			if(venTie){
				venTie.style.display = 'block';
			}
			if(costLink){
				costLink.style.display = 'block';
			}
			if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			}		
			showCaseDetailsWtHtRadioSection(false);
			showVendorCostLinkDetails(true);
      }
      }
	  if(document.getElementById('buttonHolder')){
	      if(sel.options[sel.selectedIndex].value == ''){
	      	if(document.getElementById('buttonHolder')){
	      		document.getElementById('buttonHolder').style.display = 'none';
	      	} 
	      }else{
	        if(document.getElementById('buttonHolder')){
	      		document.getElementById('buttonHolder').style.display = 'block';
	      	}
	      }
	   }
	}
	
		function clearCaseDetailsForChannelChangeMRT(){	
	   		setValue(document.getElementById('unitFactor'),'');
			setValue(document.getElementById('masterLength'),'');
			setValue(document.getElementById('masterHeight'),'');
			setValue(document.getElementById('masterWeight'),'');
			setValue(document.getElementById('masterWidth'),'');
			setValue(document.getElementById('shipPackText'),'');
			setValue(document.getElementById('shipLength'),'');
			setValue(document.getElementById('shipWeight'),'');
			setValue(document.getElementById('shipHeight'),'');
			setValue(document.getElementById('shipWidth'),'');
			setValue(document.getElementById('shelfDays'),'');
			setValue(document.getElementById('inboundDays'),'');
			setValue(document.getElementById('reactionDays'),'');
			setValue(document.getElementById('guaranteestoreDays'),'');
			setValue(document.getElementById('oneTouchType'),'');
			setValue(document.getElementById('itmCategory'),'');
			setValue(document.getElementById('maxShipText'),'');
			//setValue(document.getElementById('purchaseStatus'),'');
			document.getElementById('purchaseStatus').selectedIndex = 0;
		 	/*if(document.getElementById('catchRadio')){
		 		document.getElementById('catchRadio').checked = false;
		 	}
		 	if(document.getElementById('variableRadio')){
		 		document.getElementById('variableRadio').checked = false;
		 	}
		 	if(document.getElementById('noneRadio')){
		 		document.getElementById('noneRadio').checked = false;
		 	}*/
		 	if(document.getElementById('masterCubeLabel')){
				document.getElementById('masterCubeLabel').innerText = '';		
			}
		 	if(document.getElementById('shipCubeLabel')){
	 			document.getElementById('shipCubeLabel').innerText = '';
	 		}
			var i=0;
		}
	
	function reloadAuthAndDist(){
		YAHOO.util.Event.onDOMReady(init);
	}

	function init(){
		document.getElementById('all').style.visibility = 'visible';
		document.getElementById('f1').style.visibility = 'visible';
		document.getElementById('details').style.visibility = 'visible';
		document.getElementById('f2').style.visibility = 'visible';
		document.getElementById('tabs').style.visibility = 'visible';	
	}

	/*function call on selecting import checkbox*/
	function importFn(){
		var importDiv = document.getElementById('importDiv');
		var r = document.getElementById('vendorTable').rows.length-1;
		var b = false;
		for(i=0;i<r;i++){
			if( document.getElementById('check1'+i)){
				b =  b || document.getElementById('check1'+i).checked;
			}
		}
		
		for(i =0;i<=addCount;i++){
			if(document.getElementById('ajaxImport'+i)){
				b =  b || document.getElementById('ajaxImport'+i).checked;
			}
		}
		
		b =  b || document.getElementById('import').checked;
		if(b){
	            importDiv.style.visibility = 'visible';
	            importDiv.style.position = 'static';
		
		}else{
			importDiv.style.visibility = 'hidden';
			importDiv.style.position = 'absolute';
	    	}
	
	}
	
	
	function importClicked(){
		var importDiv = document.getElementById('importDiv');
		var importBut = document.getElementById('import');
		if(importBut.checked){
			importDiv.style.display = 'block';
			document.getElementById('enableAuthorizeWHS').style.display = "block";
			document.getElementById('enableFactoryDiv').style.display = "block";
			if(YAHOO.util.Dom.get('orderUnit') != null){
				var ordUnitTxt = YAHOO.util.Dom.get('orderUnit').options[YAHOO.util.Dom.get('orderUnit').options.selectedIndex].text;
		 		YAHOO.util.Dom.get('minType').value = filterKeyAuth(ordUnitTxt);
			}
			if(trim(YAHOO.util.Dom.get('duty').value) == "" && trim(YAHOO.util.Dom.get('freight').value) == ""){
				setDateDefaultVendorDetailsAuth();
			}
		}else{
			importDiv.style.display = 'none';
		}
		
	}
	
	function importClickedAjax(){
		var importDiv = document.getElementById('importDivAjax');
		var importBut = document.getElementById('import');
		if(importBut.checked){
			importDiv.style.display = 'block';
			if(YAHOO.util.Dom.get('orderUnit') != null){
				var ordUnitTxt = YAHOO.util.Dom.get('orderUnit').options[YAHOO.util.Dom.get('orderUnit').options.selectedIndex].text;
		 		YAHOO.util.Dom.get('minType').value = filterKeyAuth(ordUnitTxt);
			}
			if(trim(YAHOO.util.Dom.get('duty').value) == "" && trim(YAHOO.util.Dom.get('freight').value) == ""){
				setDateDefaultVendorDetailsAuth();
			}
		}else{
			importDiv.style.display = 'none';
		}
		
	}
	function filterKeyAuth(ordUnitTxt){
	 	var indx = ordUnitTxt.indexOf('[');
		if(ordUnitTxt != "" && indx > -1){
			ordUnitTxt = ordUnitTxt.substring(0,indx);
		}
		return trim(ordUnitTxt);
	}
	function setDateDefaultVendorDetailsAuth(){
<!--  		set date default for duty and freight -->
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();
		if(dd<10) {
		    dd='0'+dd
		} 
		if(mm<10) {
		    mm='0'+mm
		} 
		today = mm+'/'+dd+'/'+yyyy;
		YAHOO.util.Dom.get('duty').value = today;
		YAHOO.util.Dom.get('freight').value = today;
    }			
	function init1(){
		vendorName1.value = '';
		//vendorNumber1.value = '';
		vpc1.value = '';
		listCost1.value = '';		
		gSales1.checked=false;
		import1.checked=false;
		dealOffered1.checked=false;
		costOwner1.value = '';
		top2Top1.value = '';
		countryOfOrigin1.value = '';
		seasonality1.value = '';
		seasonalityYear1.value = '';
	}
	
	function checkedCodeDate(evt){
		boxChecked = document.getElementById("codeDate").checked;
		var cont;
		var codeDateDiv = YAHOO.util.Dom.get("codeDateDiv");
		if(boxChecked){
			codeDateDiv.style.visibility = 'visible';
			codeDateDiv.style.position = 'static';
		}else{
			if(document.getElementById("shelfDays")){
				document.getElementById("shelfDays").value = "";
			}
			if(document.getElementById("inboundDays")){
				document.getElementById("inboundDays").value = "";
			}
			if(document.getElementById("reactionDays")){
				document.getElementById("reactionDays").value = "";
			}
			if(document.getElementById("guaranteestoreDays")){
				document.getElementById("guaranteestoreDays").value = "";
			}
			codeDateDiv.style.visibility = 'hidden';
			codeDateDiv.style.position = 'absolute';	
		}
	}
	
	function selectCheckboxes() {
		var checkedValue = document.getElementById('checkAll').checked;
	    for(i=0; i<=cnt; i++) {
	    	document.getElementById('check'+i).checked = checkedValue;
	    	if(checkedValue){
		    	document.getElementById('radio'+i).disabled=false;
			}else{
		    	document.getElementById('radio'+i).disabled=true;
				document.getElementById('radio'+i).checked=false;
			}
	    }
	}
	
	function selectCheckbox() {
        var checkedValue = document.getElementById('caseCheck').checked;
        var upcTableBody = document.getElementById('caseItemTbody');
        var rowLength = upcTableBody.rows.length;
       // nb = document.all.item('check').length;
        for(i=0; i<rowLength; i++) {
           document.getElementById('checkExistingCase'+i).checked=checkedValue;
        }
    }
	
	
	function test(rowId){
	    if ( document.getElementById('check'+rowId).checked){    
			document.getElementById('radio'+rowId).disabled=false;
		}else{
			document.getElementById('radio'+rowId).disabled=true;
			document.getElementById('radio'+rowId).checked=false;
		}	
	}

	function focusMethod(){
		scrollDivToBottom();
		toggleAssoctdUPC('f4');
	}
	
		
function check(){
if ( document.getElementById("masterPackText").value == document.getElementById("shipPackText").value ){
copyTextFields();
}
return true;
}
	
	
function copyTextFields(evt){
	document.getElementById("shipLength").value= document.getElementById("masterLength").value;
	document.getElementById("shipWidth").value= document.getElementById("masterWidth").value;
	document.getElementById("shipHeight").value= document.getElementById("masterHeight").value;
	document.getElementById("shipWeight").value= document.getElementById("masterWeight").value;
	calculateShipCube();
}	


//#1205:fix the validate Master Pack & Ship Pack when enter string
function validateMasterShipPacks(){
	var mas = document.getElementById('masterPackText').value;
	var ship = document.getElementById('shipPackText').value;
	try {
		if(mas != null && mas != ""){
			mas = parseNumber(mas);
		}
		if(ship != null && ship != ""){
			ship = parseNumber(ship);
		}
		if(isNaN(mas) || isNaN(ship)) throw "Master Pack & Ship Pack must be a number";
		if(!valueMultipleOfOther(mas, ship)) throw "Master Pack should be a multiple of Ship Pack";
	}
	catch(e) {
		alert(e);
		return false;
	}
	return true;
}

function validateMasterShipPacks_old(){
	var mas = document.getElementById('masterPackText').value;
	var ship = document.getElementById('shipPackText').value;
	if(mas != null && mas != "" && ship != null && ship != ""){
		if(parseInt(ship) > parseInt (mas)){
			showMessage("Master Pack should be greater than Ship Pack");
		}else{
			if(valueMultipleOfOther(mas, ship)){
				return true;
			}else{
				showMessage("Master Pack should be a multiple of Ship Pack");
			}
		}
	}else{
		return true;
	}
	
}

function displayImport(isDisplay){
	if(document.getElementById('importDiv')){		
		var importDiv = document.getElementById('importDiv');
		importDiv.style.display = isDisplay;
	}
}


function displayImportDiv(evt){
	var importDiv = document.getElementById('importOnly');
	if (evt){
		if(evt == 'V'){
			importDiv.style.visibility = 'visible';
		}
		if(evt =='D'){
			if(document.getElementById('import'))
				document.getElementById('import').checked = false;
			importOnly.style.visibility = 'hidden';
			displayImport('none');
		}
	}else {
		var sel = document.getElementById('actions3');
		if(sel.options[sel.selectedIndex].value == 'WHS'||sel.options[sel.selectedIndex].value == 'BOTH'){
			importDiv.style.visibility = 'visible';
		}else{
			if(document.getElementById('import'))
				document.getElementById('import').checked = false;
			importOnly.style.visibility = 'hidden';
			displayImport('none');
		}
	}
}

function displayImportDivAjax(evt){
	var importDiv = document.getElementById('importOnly');
	if (evt){
		if(evt == 'V'){
			importDiv.style.visibility = 'visible';
		}
		if(evt =='D'){
			importDiv.style.visibility = 'hidden';
		}
	}else {
		var sel = document.getElementById('actions3');
		if(sel.options[sel.selectedIndex].value == 'WHS'||sel.options[sel.selectedIndex].value == 'BOTH'){
			importDiv.style.visibility = 'visible';
		}else{
			importDiv.style.visibility = 'hidden';
		}
	}
}
function calculateGrossMargin(){
	var unitRetail=document.getElementById('unitRetail');
	var retailFor=document.getElementById('retailFor');
	var unitCost=document.getElementById('unitCostLabel');
	var listCost=document.getElementById('listCost');
	var result;
	if(isValidDom(listCost) && listCost.value !="" && isValidDom(retailFor) && retailFor.value !="" && parseFloat(retailFor.value) != 0 && isValidDom(unitCost) && unitCost.innerText != ""){
		if(unitRetail== null || unitRetail == undefined){
			result =0;
		}
		else if(isValidDom(unitRetail) && parseFloat(unitRetail.value) > 1){
			result = parseFloat(retailFor.value)/parseFloat(unitRetail.value);
		}
		else {
			result =retailFor.value;
		}
		var rs=((parseFloat(result)-parseFloat(unitCost.innerText))/parseFloat(result)*100.0).toFixed(2);
		if(isValidDom(document.getElementById('grossMargin')) && !isNaN(rs)){
			document.getElementById('grossMargin').innerText=rs;
		}
		if(isValidDom(unitCost)){
			calculateGrossProfit(result,unitCost.innerText);
			enableWarnProfit(false);
		}
	}
	else{
		if(isValidDom(document.getElementById('grossMargin'))){
			document.getElementById('grossMargin').innerText="";
		}
		if(document.getElementById('grossProfit')){
			document.getElementById('grossProfit').innerText="";
		}
		var marginWarningIdAjax = document.getElementById("marginWarningIdAjax");
		if(listCost.value=="" && marginWarningIdAjax!=null) {
			marginWarningIdAjax.value="% Margin and Penny Profit are blank. Please enter List Cost value.";
		}
		enableWarnProfit(true);
	}
		
}
function calculateGrossProfit(retail,unitCost){
	var profit=(parseFloat(retail)-parseFloat(unitCost)).toFixed(2);
	var	rs="$"+profit;
		
	if(isValidDom(document.getElementById("grossProfit")) && !isNaN(profit)){
		document.getElementById("grossProfit").innerHTML = rs;
	}
}


function calculateUnitCostMRT(){
	var masterPack = YAHOO.util.Dom.get("masterPackText").value;
    //HoangVT - change from 001 -> 1
	if(null != masterPack  && "" != masterPack){
		if(parseInt(masterPack,10) == 0)
			YAHOO.util.Dom.get("masterPackText").value = "";
		else
			YAHOO.util.Dom.get("masterPackText").value = parseInt(masterPack,10);
	}
	var shipPack = YAHOO.util.Dom.get("shipPackText").value;
    //HoangVT - change from 001 -> 1
	if(null != shipPack  && "" != shipPack){
		if(parseInt(shipPack,10) == 0)
			YAHOO.util.Dom.get("shipPackText").value = "";
		else
			YAHOO.util.Dom.get("shipPackText").value = parseInt(shipPack,10);
	}
	var listCost = YAHOO.util.Dom.get("listCost").value;
	var sel = document.getElementById('actions3');
	if(sel.options[sel.selectedIndex].value == 'DSD'){
	if(null != masterPack  && "" != masterPack && null != listCost && "" != listCost){
		if(masterPack == 0){
			document.getElementById('unitCostLabel').innerText = "";
			return;
		}
		var reslt = (listCost/masterPack);
		var rndReslt = Math.round(reslt * 10000)/10000;//rounding to four decimal places..
		document.getElementById('unitCostLabel').innerText = formatValue(''+rndReslt);
		}
		else{
		document.getElementById('unitCostLabel').innerText = "";
		}
	}
	if(sel.options[sel.selectedIndex].value == 'WHS'){
	if(null != shipPack  && null != listCost && "" != shipPack && "" != listCost ){
		if(shipPack == 0){
			document.getElementById('unitCostLabel').innerText = "";
			return;
		}
		var reslt1 = (listCost/shipPack);
		var rndReslt1 = Math.round(reslt1 * 10000)/10000;//rounding to four decimal places..
			document.getElementById('unitCostLabel').innerText = formatValue(''+rndReslt1);
		}
		else{
		document.getElementById('unitCostLabel').innerHTML = "";
		}
	}
	if(sel.options[sel.selectedIndex].value == 'BOTH'){
		var sel = document.getElementById('vendorLocationVal');
		uniqueVendorIndex = sel.value;
		AddCandidateTemp.getVendorChannelType(uniqueVendorIndex, getDWRCallbackMethod(calculateUnitCostForBoth));
	}
	calculatePctMarginAndPProfitMrt();
}




function calculateUnitCost(){
    var masterPack = YAHOO.util.Dom.get("masterPackText");
    //HoangVT - change from 001 -> 1
	if(null != masterPack  && "" != masterPack.value){
		if(parseInt(masterPack.value,10) == 0)
			YAHOO.util.Dom.get("masterPackText").value = "";
		else
			YAHOO.util.Dom.get("masterPackText").value = parseInt(masterPack.value,10);
	}
	var shipPack = YAHOO.util.Dom.get("shipPackText");
    //HoangVT - change from 001 -> 1
	if(null != shipPack  && "" != shipPack.value){
		if(parseInt(shipPack.value,10) == 0)
			YAHOO.util.Dom.get("shipPackText").value = "";
		else
			YAHOO.util.Dom.get("shipPackText").value = parseInt(shipPack.value,10);
	}
	var listCost = YAHOO.util.Dom.get("listCost");
	var sel = document.getElementById('actions3');
	if(sel.options[sel.selectedIndex].value == 'DSD'){
	if(null != masterPack  && "" != masterPack.value && null != listCost && "" != listCost.value){
		if(masterPack.value == 0){
			document.getElementById('unitCostLabel').innerText = "";
			return;
		}
		var reslt = (listCost.value/masterPack.value);
		var rndReslt = Math.round(reslt * 10000)/10000;//rounding to four decimal places..
		document.getElementById('unitCostLabel').innerText = formatValue(''+rndReslt);
		}
		else{
		document.getElementById('unitCostLabel').innerText = "";
		}
	calculateGrossMargin();
	}
	if(sel.options[sel.selectedIndex].value == 'WHS'){
	if(null != shipPack  && null != listCost && "" != shipPack.value && "" != listCost.value ){
		if(shipPack.value == 0){
			document.getElementById('unitCostLabel').innerText = "";
			return;
		}
		var reslt1 = (listCost.value/shipPack.value);
		var rndReslt1 = Math.round(reslt1 * 10000)/10000;//rounding to four decimal places..
		document.getElementById('unitCostLabel').innerText = formatValue(''+rndReslt1);
		}
		else{
		document.getElementById('unitCostLabel').innerHTML = "";
		}
	calculateGrossMargin();
	}
	if(sel.options[sel.selectedIndex].value == 'BOTH'){
		var sel = document.getElementById('vendorLocationVal');
		uniqueVendorIndex = sel.value;
		AddCandidateTemp.getVendorChannelType(uniqueVendorIndex, getDWRCallbackMethod(calculateUnitCostForBoth));
	}	
}

function setMessageProfit(marginWarningId, marginWarningIdAjax, messageWarn){
	if(null != marginWarningId && marginWarningId != undefined){
		marginWarningId.value = messageWarn;
	}else{
		marginWarningIdAjax.value = messageWarn;
	}
}

function enableWarnProfit(flag){
	var profitWarning = document.getElementById("profitWarning");
	if(flag == true){
		if(isValidDom(profitWarning)){
			 profitWarning.style.display = "block";
		 }
	}else{
		if(isValidDom(profitWarning)){
			 profitWarning.style.display = "none";
		 }
	}
}

//hungbang added % Margin and Penny Profit for MRT. 12 April 2016
//============================begin=========================================
function callbackCalculate(dataRetailResult,unitCostLabel,listCost){
	var messageWarn = "";
	var rsRetail = dataRetailResult["unitRetail-average"];
	var percentMarginLabel = document.getElementById("percentMarginLabel");
	var pennyProfitLabel = document.getElementById("pennyProfitLabel");
	var profitWarning = document.getElementById("profitWarning");
	var marginWarningId = document.getElementById("marginWarningId");
	var marginWarningIdAjax = document.getElementById("marginWarningIdAjax");
	var indexOfUnitRetail = rsRetail.toString().indexOf('UPC');
	if(isValidDom(listCost) && myTrim(listCost.value) == "" && indexOfUnitRetail != -1){
		
		percentMarginLabel.innerText = "";
		pennyProfitLabel.innerText = "";
		messageWarn = rsRetail.concat(" MRT is missing List Cost.")
		setMessageProfit(marginWarningId, marginWarningIdAjax, messageWarn);
		enableWarnProfit(true);
		
	}else if(isValidDom(listCost) && myTrim(listCost.value) == ""){
		percentMarginLabel.innerText = "";
		pennyProfitLabel.innerText = "";
		messageWarn = " MRT is missing List Cost.";
		setMessageProfit(marginWarningId, marginWarningIdAjax, messageWarn);
		enableWarnProfit(true);
	}else{
		var percentMargin = "";
		var pennyProfit = "";
		
		if(rsRetail != null && indexOfUnitRetail == -1){
			 percentMargin = ((rsRetail - (isValidDom(unitCostLabel) ? unitCostLabel.innerText : 0)) / rsRetail) * 100;
			 pennyProfit = rsRetail - (isValidDom(listCost) ? listCost.value : 0);
			 enableWarnProfit(false);
		}else if(indexOfUnitRetail != -1){
			 percentMargin = "";
			 pennyProfit = "";
			 setMessageProfit(marginWarningId, marginWarningIdAjax, rsRetail);
			 enableWarnProfit(true);
		}
		
		if(isValidDom(percentMarginLabel) && percentMargin != ""){
			percentMarginLabel.innerText = parseFloat(percentMargin).toFixed(2);
		}
		if(isValidDom(pennyProfitLabel) && pennyProfit != ""){
			pennyProfitLabel.innerText = "$" + parseFloat(pennyProfit).toFixed(2);
		}
	}
	//Validated empty for retail for value
	if(rsRetail==null) {
		percentMarginLabel.innerText = "";
		pennyProfitLabel.innerText = "";
		enableWarnProfit(true);
	}
}


function calculatePctMarginAndPProfitMrt(){
	var retailHidden = document.getElementById("retailHidden");
	var retailForHidden = document.getElementById("retailForHidden");
	var unitCostLabel = document.getElementById("unitCostLabel");
	var listCost = document.getElementById("listCost");
	var dataRetailResult = null;
	showProgress();
	var callbacks = {
			success : function(o) {
				try {
					if (o != null && myTrim(o.responseText) != "") {
						dataRetailResult = YAHOO.lang.JSON.parse(myTrim(o.responseText));
						callbackCalculate(dataRetailResult,unitCostLabel,listCost);
					}
					hideTheProgress();
				} catch (e) {

					hideTheProgress();
					return;
				}
			},
			failure : function() {
				hideTheProgress();
			},
			timeout : 50000
		};
		YAHOO.util.Connect.asyncRequest('GET',
			"getRetailForMrt", callbacks);
}



function warningProfit(){
	var marginWarnAjax = document.getElementById("marginWarningIdAjax"); 
	var marginWarn = document.getElementById("marginWarningId"); 
	if(null != marginWarn  && marginWarn != undefined && myTrim(marginWarn.value) != ""){
		alert(marginWarn.value);
	}else if(null != marginWarnAjax && marginWarnAjax != undefined && myTrim(marginWarnAjax.value) != ""){
		alert(marginWarnAjax.value);
	}
}



//============================end=========================================



//Fix PIM 414
function calculateUnitCostForBoth(data){
    var masterPack = YAHOO.util.Dom.get("masterPackText").value;
    //HoangVT - change from 001 -> 1
	/*if(null != masterPack  && "" != masterPack){
		if(parseInt(masterPack,10) == 0)
			YAHOO.util.Dom.get("masterPackText").value = "";
		else
			YAHOO.util.Dom.get("masterPackText").value = parseInt(masterPack,10);
	}*/
	var shipPack = YAHOO.util.Dom.get("shipPackText").value;
    //HoangVT - change from 001 -> 1
	if(null != shipPack  && "" != shipPack){
		if(parseInt(shipPack,10) == 0)
			YAHOO.util.Dom.get("shipPackText").value = "";
		else
			YAHOO.util.Dom.get("shipPackText").value = parseInt(shipPack,10);
	}
	var listCost = YAHOO.util.Dom.get("listCost").value;
	if(null != shipPack  && null != listCost && "" != shipPack && "" != listCost ){
		var reslt1 = (listCost/shipPack);
		var rndReslt1 = Math.round(reslt1 * 10000)/10000;//rounding to four decimal places..
		document.getElementById('unitCostLabel').innerText = formatValue(''+rndReslt1);
	}
	else{
		document.getElementById('unitCostLabel').innerHTML = "";
	}
	calculateGrossMargin();
	/*if(data == 'D'){
		if(null != masterPack  && "" != masterPack && null != listCost && "" != listCost){
			var reslt = (listCost/masterPack);
			var rndReslt = Math.round(reslt * 10000)/10000;//rounding to four decimal places..
			document.getElementById('unitCostLabel').innerText = formatValue(''+rndReslt);
		}
		else{
			document.getElementById('unitCostLabel').innerText = "";
		}
	}
	else if(data == 'V'){
			if(null != shipPack  && null != listCost && "" != shipPack && "" != listCost ){
				var reslt1 = (listCost/shipPack);
				var rndReslt1 = Math.round(reslt1 * 10000)/10000;//rounding to four decimal places..
				document.getElementById('unitCostLabel').innerText = formatValue(''+rndReslt1);
			}
			else{
				document.getElementById('unitCostLabel').innerHTML = "";
			}
		}
	else{
		document.getElementById('unitCostLabel').innerHTML = "";
	}*/
}

//function displayCostlink(){
//var costLinkRadio = document.getElementById('costRadio').checked;
//var itemRadio = document.getElementById('itemRadio').checked;
//if(costLinkRadio || itemRadio ){
//document.getElementById('costlist').disabled=false;
//document.getElementById('listCost').disabled=false;
//document.getElementById('costlist').focus();
//document.getElementById('costlist').value='';
//}
//else{
//document.getElementById('costlist').disabled=true;
//document.getElementById('listCost').disabled=false;
//document.getElementById('costlist').value='';
//}
//}


//function clickRadio(element){
//    if(element.checked == true){
//                    element.checked = false;
//    }else{
//                    element.checked = true;
//    }
//    displayCostlink();
//}
function changeCostLinkBy(element){
	var valueCostLinkBy = element.value;
	displayCostlinkBy(valueCostLinkBy);
}
function displayCostlinkBy(valueCostLinkBy){
	if(valueCostLinkBy=="cl" || valueCostLinkBy=="ic" || valueCostLinkBy=="up"){
		document.getElementById('costlist').disabled=false;
		document.getElementById('listCost').disabled=false;
		document.getElementById('costlist').focus();
		document.getElementById('costlist').value='';
		if(valueCostLinkBy=="cl") {
			document.getElementById('costlist').maxLength=10;
		} else {
			document.getElementById('costlist').maxLength=13;
		}
	}
	else {
		document.getElementById('costlist').disabled=true;
		document.getElementById('listCost').disabled=false;
		document.getElementById('costlist').value='';
	}
}
function changeCostLinkByForWhs(){
	var element = document.getElementById("costLinkBy");
	if(element){
		var list = element.options;
		if(list != null && list.length > 0){
			for(var i = 0;i<list.length;i++){
				 var option = list[i];
					 if(option.value=='up'){
						 option.value = "ic";
						 option.text = "Item Code";
					 }
			} 
		}
	}
}
function changeCostLinkByForDsd(){
	var element = document.getElementById("costLinkBy");
	if(element){
		var list = element.options;
		if(list != null && list.length > 0){
			for(var i = 0;i<list.length;i++){
				 var option = list[i];
				 if(option.value=='ic'){
					 option.value = "up";
					 option.text = "UPC";
				 }
			} 
		}
	}
}
function showCaseDetailsWtHtRadioSection(flag) {
	var showHide = 'block';
	var catchWtSwLabelDiv = document.getElementById('CatchWtSwLabelDiv');
	var catchRadioDiv = document.getElementById('catchRadioDiv');
	var variableWtSwLabelDiv = document.getElementById('VariableWtSwLabelDiv');
	var variableRadioDiv = document.getElementById('variableRadioDiv');
	var noneLabelDiv = document.getElementById('NoneLabelDiv');
	var noneRadioDiv = document.getElementById('noneRadioDiv');
	
	if(flag == true) {
		showHide = 'block';
	} else {
		showHide = 'none';
	}
	
	if (catchWtSwLabelDiv) {
		catchWtSwLabelDiv.style.display = showHide;
	}
	if (catchRadioDiv) {
		catchRadioDiv.style.display = showHide;
	}
	if (variableWtSwLabelDiv) {
		variableWtSwLabelDiv.style.display = showHide;
	}
	if (variableRadioDiv) {
		variableRadioDiv.style.display = showHide;
	}
	if (noneLabelDiv) {
		noneLabelDiv.style.display = showHide;
	}
	if (noneRadioDiv) {
		noneRadioDiv.style.display = showHide;
	}
}

function showVendorCostLinkDetails(flag) {
	var showHide = 'block';
	var itemRadioLabelDiv = document.getElementById('ItemRadioLabelDiv');
//	var itemRadioDiv = document.getElementById('itemRadioDiv');
//	var costItemLabelDiv = document.getElementById('CostItemLabelDiv');
	var costlistDiv = document.getElementById('costlistDiv');
	var lblCstLink = document.getElementById('CostItemLabel');
	var sel = document.getElementById('actions3');	  
    var chanel = sel.options[sel.selectedIndex].value;
	
	if (itemRadioLabelDiv) {
//		itemRadioLabelDiv.style.display = showHide;
		if(chanel=='DSD')
		{
			ItemRadioLabel.innerHTML ="UPC";
			changeCostLinkByForDsd();
//			lblCstLink.innerHTML = "Cost Link#/UPC"
		}
		else
		{
			ItemRadioLabel.innerHTML ="Item Code";
			changeCostLinkByForWhs();
//			lblCstLink.innerHTML = "Cost Link#/Item Code";
		}
	}
//	if (itemRadioDiv) {
//		itemRadioDiv.style.display = showHide;
//	}
//	if (costItemLabelDiv) {
//		costItemLabelDiv.style.display = showHide;
//	}
	if (costlistDiv) {
		costlistDiv.style.display = showHide;
	}
	var costLink = document.getElementById('costLink');
    var costLinkLabel= document.getElementById('costLinkLabel');  
    if(costLink){
		costLink.style.display = showHide;
	}
	if(costLinkLabel){
		costLinkLabel.style.display = showHide;
	}	
}

function setDefaultMaxShipValue(){
	var maxShipText = document.getElementById('maxShipText');
	if(maxShipText){
		if(maxShipText.value == "" || maxShipText == null){
			maxShipText.value = "99999";
		}
	}
}

function showSubDept(flag) {
	var showHide = 'block';
    var subDeptLabelDiv = document.getElementById('subDeptLabelDiv');
    var subDeptDiv= document.getElementById('subDeptDiv');
	
	if(flag == true) {
		showHide = 'block';
	} else {
		showHide = 'none';
	}
	
	if (subDeptLabelDiv) {
		subDeptLabelDiv.style.display = showHide;
	}
	if (subDeptDiv) {
		subDeptDiv.style.display = showHide;
	}
	showPSSDept(showHide);
}

//958 PSS change
function showPSSDept(showHide){

    var pssLabelDiv = document.getElementById('vendPSSLabelDiv');
    var pssDiv= document.getElementById('vendPSSDiv');
	if (pssLabelDiv) {
		pssLabelDiv.style.display = showHide;
	}
	if (pssDiv) {
		pssDiv.style.display = showHide;
	}    
}

function clearCostLinkFields(){
//	if(YAHOO.util.Dom.get('costRadio')){
//		document.getElementById('costRadio').checked = false;
//	}
//	if(YAHOO.util.Dom.get('itemRadio')){
//		document.getElementById('itemRadio').checked = false;
//	}
	if(YAHOO.util.Dom.get('costLinkBy')){
		document.getElementById('costLinkBy').selectedIndex  = "0";
	}
//	if(YAHOO.util.Dom.get('costlist')){
//		document.getElementById('costlist').value = ''; 
//	}
	if(YAHOO.util.Dom.get('costlist')){
		document.getElementById('costlist').value = ''; 
	}
}
