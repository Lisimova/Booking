({
	searchHotel : function(component, newReservation) {
		var action = component.getEvent("searchHotel");
        action.setParams({
            "reservation": newReservation
        });
        action.fire();
	},
})