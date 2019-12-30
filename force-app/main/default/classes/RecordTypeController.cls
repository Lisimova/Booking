global with sharing class RecordTypeController {
    
    @AuraEnabled
    global static String GetRecordType(String recordId){
        
        List<RecordType> listRec = [SELECT Id,  Name FROM RecordType  WHERE SobjectType = 'Reservation__c'];
        Reservation__c listRes = [SELECT Id,  RecordTypeId FROM Reservation__c
                                        WHERE Id = :recordId Limit 1];
        
        if( listRes.RecordTypeId == listRec[0].Id)
           {
               listRes.RecordTypeId = listRec[1].Id;
           }
        else {
            listRes.RecordTypeId = listRec[0].Id;
        }
        
        update listRes;
        
        return listRes.RecordTypeId;
    }

     @AuraEnabled
    global static String ChangeLabel(String recordId) {
        
        Reservation__c selectReservation = [Select Name, RecordTypeId From Reservation__c Where Id = :recordId];
        
        return selectReservation.RecordTypeId;
    }
}