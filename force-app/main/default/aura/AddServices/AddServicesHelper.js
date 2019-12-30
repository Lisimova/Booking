({
	addService : function(component, beer, internet, sauna) {
		
        var action = component.getEvent("addService");
        action.setParams({
            "beer": beer,
            "internet": internet,
            "sauna": sauna
        });
        
        action.fire();
	}
})