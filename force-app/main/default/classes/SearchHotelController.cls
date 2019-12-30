global with sharing class SearchHotelController { 
    
    @AuraEnabled
    global static Map<Id, List<Room__c>> FindHotelsAndRooms(Reservation__c reservation) {
        
        Map<Id, List<Room__c>> hotelsAndRooms = new Map<Id, List<Room__c>>();
        List<Id> bookedRooms = new List<Id>();
        List<Room__c> roomsForOneHotel = new List<Room__c>();
        
        List<Hotel__c> allhotels = [Select Name,Id From Hotel__c Where City__c = :reservation.City__c];
        List<Room__c> allrooms = [Select Name From Room__c Where Hotel__c in :allhotels
                                  and Maximum_guests__c >= :reservation.Count_of_guests__c];
        
        List<Reservation__c> reservationInThisTime = [Select Room__c from Reservation__c 
                Where (((Check_inDate__c <= :reservation.Check_inDate__c And Check_out_date__c > :reservation.Check_inDate__c) OR
                       (Check_out_date__c >= :reservation.Check_out_date__c AND Check_inDate__c < :reservation.Check_out_date__c) OR
                       (Check_inDate__c >= :reservation.Check_inDate__c And Check_inDate__c < :reservation.Check_out_date__c) OR 
                       (Check_out_date__c <= :reservation.Check_out_date__c AND Check_out_date__c > :reservation.Check_inDate__c))
                       AND (Room__c in :allrooms))];
        
        for (Reservation__c res : reservationInThisTime)
        {
            bookedRooms.add(res.Room__c);
        }
        
        
        List<Room__c> roomWithoutReservation = [Select Name, Price_per_night__c From Room__c 
                                                       Where ((Id in :allRooms) And (Id not in :bookedRooms))];
        
        for (Room__c room : roomWithoutReservation) {
            
            room.Price__c = room.Price_per_night__c * (reservation.Check_inDate__c).daysBetween(reservation.Check_out_date__c);
            
            update room;
        }
        
        for (Hotel__c hotel : allhotels) {
            
            roomsForOneHotel = [Select Name, Price_per_night__c, Price__c, Hotel__r.Name From Room__c where Hotel__c = :hotel.Id and Id in :roomWithoutReservation];
            
            if (roomsForOneHotel.size() > 0){

                hotelsAndRooms.put(hotel.Id, roomsForOneHotel);
            }
        }
        
        return hotelsAndRooms;
    }
    
     @AuraEnabled
    global static void SaveReservation(Reservation__c newRes, Reservation__c preNewRes, Room__c room, Decimal TotalPrice,
                               Boolean beer, Boolean internet, Boolean sauna) {
         
        ReservationService__c beerReservationService = new ReservationService__c();
        ReservationService__c internetReservationService = new ReservationService__c();
        ReservationService__c saunaReservationService = new ReservationService__c();
        List<Additional_services__c> service = new List<Additional_services__c>();
                                   
        try {
            	newRes.Check_inDate__c = preNewRes.Check_inDate__c;
            	newRes.Check_out_date__c = preNewRes.Check_out_date__c;
            	newRes.City__c = preNewRes.City__c;
            	newRes.Room__c = room.Id;
                if(TotalPrice == null)
            		TotalPrice = room.Price_per_night__c;
                newRes.Total_Price__c = TotalPrice;
            
        	    insert newRes;
            
            sendMail(newRes);
            
            if (beer == true){
                
                service = [Select Id From Additional_services__c Where Name = 'Beer'];
                beerReservationService.Additional_services__c = service[0].Id;
                beerReservationService.Reservation__c = newRes.Id;
                
                insert beerReservationService;
            }
            
            if (internet == true){
                
                service = [Select Id From Additional_services__c Where Name = 'Internet'];
                internetReservationService.Additional_services__c = service[0].Id;
                internetReservationService.Reservation__c = newRes.Id;
                
                insert internetReservationService;
            }
            
            if (sauna == true){
                
                service = [Select Id From Additional_services__c Where Name = 'Sauna'];
                saunaReservationService.Reservation__c = newRes.Id;
                saunaReservationService.Additional_services__c = service[0].Id;
                
                insert saunaReservationService;
            }
                
        }
                                   
        catch(Exception e) {
            
          Apexpages.addMessage(new Apexpages.message(ApexPages.Severity.Error,e.getMessage()));
        
        }
    }
    
    @AuraEnabled
    global static Decimal CalcTotalPrice(Room__c room, Boolean beer, Boolean internet, Boolean sauna, Reservation__c reservation) {
        
        Decimal totalPrice = 0;
        Decimal priceOfRoom = 0;
        
        Date startDay = reservation.Check_inDate__c;
        Date endDay = reservation.Check_out_date__c;
        priceOfRoom = room.Price__c;
        
        Integer numberOfDays = startDay.daysBetween(endDay);
        
        totalPrice += priceOfRoom;
        if(beer == true)
            totalPrice += 5 * numberOfDays;
        
        if(internet == true)
            totalPrice += 2 * numberOfDays;
        
        if(sauna == true)
            totalPrice += 10 * numberOfDays;
        
        return totalPrice;
        
    }
    
    @AuraEnabled 
    global static void sendMail(Reservation__c reservation){
        
        String address = reservation.Email_Address__c;
        
        List<Reservation__c> lis = [Select Room__r.Name, Room__r.Hotel__r.Name From Reservation__c where Id =: reservation.Id ];
        
        String message = 'Hi, ' + reservation.First_Name__c + ' ' + reservation.Last_Name__c + '. Your room ' 
            			+ lis[0].Room__r.Name + ' in ' + lis[0].Room__r.Hotel__r.Name + 
            			' was booked from ' + reservation.Check_inDate__c + ' to ' + reservation.Check_out_date__c +
            			'. Thanks for choosing us.';
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Booking confirmation');
        mail.setPlainTextBody(message);
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                 new Messaging.SingleEmailMessage[] { mail });
    }
}