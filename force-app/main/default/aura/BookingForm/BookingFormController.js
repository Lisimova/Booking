({
    cancel: function(component, event, helper) {
        document.getElementById("book").style.display = "block";
        document.getElementById("roomId").style.display = "none";
    },
    
    reserve: function(component, event, helper) {
        
        document.getElementById("successful").style.display = "block";
        document.getElementById("roomId").style.display = "none";
        
        var validReservation = component.find('bookingform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validReservation){
            // Create the new reservation
            var newReservation = component.get("v.booking");
            console.log("Create reservation: " + JSON.stringify(newReservation));
            helper.reserve(component, newReservation);
    	}
    },
})