@RestResource(urlMapping='/ContactAPI/*')
global with sharing class ContactResource {
    //Get Method
    @HTTPGet
    global static List<Contact> getContactIdAndNames() {
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request URI
        String contactRequestURI = contactRequest.requestURI;
        system.debug('contactRequestURI===>'+contactRequestURI);
        // Getting the limit from the request URI
        Integer contactLimit = Integer.valueOf(contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1));
        // Querying contacts
        List<Contact> contactList = [SELECT Id, Name FROM Contact LIMIT  :contactLimit];
        return contactList;
    }
    
    @HTTPPost
    global static Contact createNewContact(String firstName,String lastName) {
        system.debug('yes');
        // Initializing New Contact
        Contact contact = new Contact();
        contact.FirstName = firstName;
        contact.LastName = lastName;
        system.debug('FirstNAME ===>'+ firstName + 'lastname===>'+lastName);
        //contact.LeadSource = leadSource;
        // Inserting Contact
        insert contact;
        // Returning the contact in the response*/
        return contact;
    }
    @HTTPDelete
    global static Map<String,String> deleteContact(){
        system.debug('delete');
        Map<String,String> responseMap = new Map<String,String>();
        RestRequest conRequest = RestContext.request;
        String ContactRequestURI = conRequest.requestURI;
        Id ContactID =Id.valueof(ContactRequestURI.substring(contactRequestURI.lastIndexOf('/')+1)) ;
        Contact con = new Contact(Id=ContactID);
        try{
            delete con;
            responseMap.put('Success','1');
            responseMap.put('message', 'Record Deleted Successfully');
        }
        catch(DmlException ex){
            responseMap.put('success', '0');
            responseMap.put('message', ex.getMessage());
            
        }
        
        return responseMap;
    }

}