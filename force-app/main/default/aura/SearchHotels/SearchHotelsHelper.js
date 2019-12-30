({
	searchHotel : function(component, newReservation) {
		var action = component.get("c.FindHotelsAndRooms");
        
        action.setParams({
            reservation: newReservation
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                var arrayMapKeys = [];
                
                for(var key in result){
                    arrayMapKeys.push({key: key, value: result[key]});
                }
                
                component.set("v.mapValues", arrayMapKeys);
            } 
        });
        $A.enqueueAction(action);
	},
    
    reservation: function(component, newReservation) {
		var action = component.get("c.SaveReservation");
        
        action.setParams({
            newRes: newReservation,
            preNewRes: component.get("v.reservation"),
            room: component.get("v.selectedRoom"),
            TotalPrice: component.get("v.TotalPrice"),
            beer: component.get("v.beer"),
            internet: component.get("v.internet"),
            sauna: component.get("v.sauna")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
               
            } 
        });
        $A.enqueueAction(action);
	},
    
    addService: function(component, beer, internet, sauna, room){
        
        var action = component.get("c.CalcTotalPrice");
        
        action.setParams({
            
            room: room,
            beer: beer,
            internet: internet,
            sauna: sauna,
            reservation: component.get("v.reservation")
        })
        
         action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                
                var totalPrice = response.getReturnValue();
                component.set("v.TotalPrice", totalPrice);
            } 
        });
        $A.enqueueAction(action);
    }

})