({
	getRecordTypes : function(component) {
		
        var action = component.get("c.GetRecordType");
       
        action.setParams({
            recordId: component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
          var state = response.getState();
            
          if(state == "SUCCESS"){
              
            }
        });
        $A.enqueueAction(action); 
        
        $A.get('e.force:refreshView').fire();
        
        
	},
    
    changeLabel : function(component) {
        
        var action = component.get("c.ChangeLabel");
       
        action.setParams({
            recordId: component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
          var state = response.getState();
            
          if(state == "SUCCESS"){
              
              component.set("v.Reservation", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
    }
                           
})