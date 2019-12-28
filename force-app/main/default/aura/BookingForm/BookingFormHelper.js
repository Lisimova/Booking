({
	reserve : function(component, newReservation) {
        
		var action = component.getEvent("saveReservation");
        action.setParams({
            "reservation": newReservation
        });
        action.fire();
	},  
})