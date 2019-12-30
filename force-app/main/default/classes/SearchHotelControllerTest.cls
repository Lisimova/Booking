@isTest
global class SearchHotelControllerTest {
    
    @isTest global static void FindHotelsAndRoomsTest(){
        
        Hotel__c testHot = new Hotel__c (City__c = 'NY', Name = 'NY Hotel', Address__c = 'testAddress');
        insert testHot;
        
        Room__c testRoom = new Room__c (Name = 'King Room', Price_per_night__c = 54, Maximum_guests__c = 3, 
                                        Hotel__c = testHot.Id, Price__c = 432);
        insert testRoom;
        
        Room__c testRoom2 = new Room__c (Name = 'Royal Room', Price_per_night__c = 54, Maximum_guests__c = 2, 
                                        Hotel__c = testHot.Id, Price__c = 542);
        insert testRoom2;
        
        Reservation__c testReserv = new Reservation__c(City__c = 'NY', Check_inDate__c = Date.newInstance(2019, 12, 29), 
                                                       Check_out_Date__c = Date.newInstance(2020, 01, 10), Count_of_guests__c = 2,
                                                       First_Name__c = 'Zhenya', Last_Name__c = 'Tit', Email_Address__c = 'sd@gmail.com',
                                                       Room__c = testRoom.Id, Total_Price__c = 100);
        
        insert testReserv;
        
        Map<Id, List<Room__c>> testresult = SearchHotelController.FindHotelsAndRooms(testReserv);
        
    }
    
    @IsTest
    global static void SaveReservationTest() {
         
        
        Decimal TotalPrice = 100;
        Decimal TotalPrice2 = null;
        Hotel__c testHot = new Hotel__c (City__c = 'NY', Name = 'NY Hotel', Address__c = 'testAddress');
        insert testHot;
        
        Room__c testRoom = new Room__c (Name = 'King Room', Price_per_night__c = 54, Maximum_guests__c = 3, Hotel__c = testHot.Id);
        insert testRoom;
        
        Room__c testRoom2 = new Room__c (Name = 'Royal Room', Price_per_night__c = 54, Maximum_guests__c = 2, 
                                        Hotel__c = testHot.Id, Price__c = 542);
        insert testRoom2;
        
        Reservation__c testReserv = new Reservation__c(City__c = 'NY', Check_inDate__c = Date.newInstance(2019, 12, 29), 
                                                       Check_out_Date__c = Date.newInstance(2020, 01, 10), Count_of_guests__c = 2,
                                                       First_Name__c = 'Zhenya', Last_Name__c = 'Tit', Email_Address__c = 'sd@gmail.com',
                                                       Room__c = testRoom.Id, Total_Price__c = TotalPrice);
        
        Reservation__c testpreReserv = new Reservation__c(City__c = 'NY', Check_inDate__c = Date.newInstance(2019, 12, 29), 
                                                       Check_out_Date__c = Date.newInstance(2020, 01, 10), Count_of_guests__c = 2,
                                                       First_Name__c = 'Zhenya', Last_Name__c = 'Tit', Email_Address__c = 'sd@gmail.com',
                                                       Room__c = testRoom.Id, Total_Price__c = TotalPrice2);
        
        
        Boolean beer = true;
        Boolean internet = true;
        Boolean sauna = true;
        
        
        SearchHotelController.SaveReservation(testReserv, testpreReserv, testRoom, TotalPrice, beer, internet, sauna);
        SearchHotelController.SaveReservation(testReserv, testpreReserv, testRoom, null, beer, internet, sauna);
        
        Decimal test3 = SearchHotelController.CalcTotalPrice(testRoom2, beer, internet, sauna, testReserv);
        
        SearchHotelController.sendMail(testReserv);
           
    }
   
}