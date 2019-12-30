({
	handleSearchHotel: function(component, event, helper){
        
        var newReservation = event.getParam("reservation");
        component.set("v.reservation", newReservation);
        helper.searchHotel(component, newReservation);
        
    },
    
    handlesave: function(component, event, helper){
        
        var newReservation = event.getParam("reservation");
        helper.reservation(component, newReservation);
        
    },
    
    handleshowRoom: function(component, event, helper){
        
        var room = event.getParam("room");
        component.set("v.selectedRoom", room);
        component.set("v.selectedHotel", room.Hotel__c);
    },
    
    handleAddService: function(component, event, helper) {
        
        var beer = event.getParam("beer");
        component.set("v.beer", beer);
        
       	var internet = event.getParam("internet");
        component.set("v.internet", internet);
        
        var sauna = event.getParam("sauna");
        component.set("v.sauna", sauna);
        
        var room = component.get("v.selectedRoom");
        
        helper.addService(component, beer, internet, sauna, room);
    }
    
})