({
    toggle: function(component, event, helper) {
        
        document.getElementById("roomId").style.display = "block";
        document.getElementById("book").style.display = "none";
        var room = component.get("v.room");
        helper.showRoom(component, room);
    },
})