({ 
    doInit : function(component, event, helper) {
    
    helper.changeLabel(component);
}, 
 
    switch : function(component, event, helper) {
    
        if(component.get("v.Reservation") == false) {
                component.set("v.Reservation", true)
            } else {
               component.set("v.Reservation", false)
            }
    	helper.getRecordTypes(component);  
	}
})