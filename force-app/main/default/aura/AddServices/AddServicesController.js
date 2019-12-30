({
	clickChange : function(component, event, helper) {
		
        var beer = component.get("v.beer");
        var internet = component.get("v.internet");
        var sauna = component.get("v.sauna");
        
        helper.addService(component, beer, internet, sauna);
	},
})