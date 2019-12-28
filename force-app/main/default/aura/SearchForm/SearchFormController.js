({
    checkInValidity: function(component, event, helper) {
        
       var inputCmp = component.find("checkin");
        var value = inputCmp.get("v.value");
        var now = new Date();
        // is input valid text?
        if (Date.parse(value) < now) {
            inputCmp.setCustomValidity("You can not set a reservation for the past");
        }
        else {
            inputCmp.setCustomValidity("");
        }
        inputCmp.reportValidity();
    },
    
    checkOutValidity: function(component, event, helper) {
        
       var inputCmp = component.find("checkout");
        var value = inputCmp.get("v.value");
        
        var checkin = component.find("checkin");
        var checkinValue = checkin.get("v.value");
        
        var now = new Date();
        // is input valid text?
        if (Date.parse(value) < now) {
            inputCmp.setCustomValidity("You can not set a reservation for the past");
        }
        else if(Date.parse(value) < Date.parse(checkinValue)){
            
             inputCmp.setCustomValidity("Check out date must be later than check in date");
        }
        else {
            
             inputCmp.setCustomValidity("");
        }
        
        inputCmp.reportValidity();
    },
    
	clickSearch : function(component, event, helper){
        var validReservation = [].concat(component.find('choosehotelform'), component.find('checkin'), component.find('checkout')).reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        
        // If we pass error checking, do some real work
        if(validReservation){
            // Create the new reservation
            var newReservation = component.get("v.searchBooking");
            console.log("Create reservation: " + JSON.stringify(newReservation));
            helper.searchHotel(component, newReservation);
        }},
    
})