@isTest
global class RecordTypeControllerTest {

    
    @isTest global static void GetRecordTypeTest() {
        
         Hotel__c testHot = new Hotel__c (City__c = 'NY', Name = 'NY Hotel', Address__c = 'testAddress');
        insert testHot;
        
        Room__c testRoom = new Room__c (Name = 'King Room', Price_per_night__c = 54, Maximum_guests__c = 3, 
                                        Hotel__c = testHot.Id, Price__c = 432);
        insert testRoom;
        
        Reservation__c reservationTest = new Reservation__c(City__c = 'NY', Check_inDate__c = Date.newInstance(2019, 12, 29), 
                                                       Check_out_Date__c = Date.newInstance(2020, 01, 10), Count_of_guests__c = 2,
                                                       First_Name__c = 'Zhenya', Last_Name__c = 'Tit', Email_Address__c = 'sd@gmail.com',
                                                       Room__c = testRoom.Id, Total_Price__c = 100);
        
        insert reservationTest;
        
        Reservation__c reservationTest2 = new Reservation__c(City__c = 'NY', Check_inDate__c = Date.newInstance(2019, 12, 29), 
                                                       Check_out_Date__c = Date.newInstance(2020, 01, 10), Count_of_guests__c = 2,
                                                       First_Name__c = 'Zhenya', Last_Name__c = 'Tit', Email_Address__c = 'sd@gmail.com',
                                                       Room__c = testRoom.Id, Total_Price__c = 100, RecordTypeId = '0122v000002HTgiAAG');
        
        insert reservationTest2;

       String testResult = RecordTypeController.GetRecordType(reservationTest.Id);
       String testResult2 = RecordTypeController.GetRecordType(reservationTest2.Id);
    }
    
    @isTest global static void ChangeLabelTest() {
        
        Hotel__c testHot = new Hotel__c (City__c = 'NY', Name = 'NY Hotel', Address__c = 'testAddress');
        insert testHot;
        
        Room__c testRoom = new Room__c (Name = 'King Room', Price_per_night__c = 54, Maximum_guests__c = 3, 
                                        Hotel__c = testHot.Id, Price__c = 432);
        insert testRoom;
        
        Reservation__c reservationTest = new Reservation__c(City__c = 'NY', Check_inDate__c = Date.newInstance(2019, 12, 29), 
                                                       Check_out_Date__c = Date.newInstance(2020, 01, 10), Count_of_guests__c = 2,
                                                       First_Name__c = 'Zhenya', Last_Name__c = 'Tit', Email_Address__c = 'sd@gmail.com',
                                                       Room__c = testRoom.Id, Total_Price__c = 100);
        
        insert reservationTest;
        
        
       String testResult = RecordTypeController.ChangeLabel(reservationTest.Id);
        
    }
}