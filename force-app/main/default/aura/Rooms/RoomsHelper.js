({ 
    showRoom : function(component, room) {
         var action = component.getEvent("showRoom");
         action.setParams({
             "room": room
         });
         action.fire();
     },
 })