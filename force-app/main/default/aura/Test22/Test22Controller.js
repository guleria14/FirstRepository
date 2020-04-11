({
	doInIt : function(component, event, helper) {
		 var id = component.get("v.pageReference").state.message; 
                 var toastEvent=$A.get('e.force:showToast');
                    toastEvent.setParams({
                      title:'Rendering page',
                      message:id,
                      key:'info_alt',
                      type:'info',
                      mode:'pester'
               });
        toastEvent.fire();
	}
})