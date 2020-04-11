({
    handleClick: function(cmp, event, helper) {
     var navService = cmp.find("navService");
     var pageReference = {
                         "type": "standard__component",
                         "attributes": {
                                         "componentName": "Test22"
                                       }, 
                         "state": {
                             'message':'This is the target page'
                         }
                        };
     navService.navigate(pageReference);
    }
})