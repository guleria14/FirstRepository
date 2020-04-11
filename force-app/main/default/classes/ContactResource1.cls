@RestResource(urlMapping='/ContactAPI1/*')
global with sharing class ContactResource1 {

    // Get Method
    @HTTPGet
    global static List<Contact> getContactIdNameAndLeadSource() {
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the URL parameters from the request
        Map<String, String> contactRequestParams = contactRequest.params;
        system.debug('contactRequestParams===>'+contactRequestParams);
        // Getting the limit and leadsource from the request URL params
        Integer contactLimit = Integer.valueOf(contactRequestParams.get('limit'));
        String leadSource = contactRequestParams.get('leadsource');
        // Querying contacts
        List<Contact> contactList = [SELECT Id, Name, LeadSource FROM Contact WHERE LeadSource =:leadSource LIMIT :contactLimit];
        // Returning the contacts in the response
        return contactList;
    }
    @HTTPPost
    global static Contact createNewContact(){
        RestRequest contactRequest = RestContext.request;
        //getting the body
        String requestBody = contactRequest.requestBody.toString();
        system.debug('requestBody===>'+requestBody);
        Contact contact = (Contact)JSON.deserialize(requestBody, Contact.class);
        system.debug('contact==>'+contact);
        insert contact;
        return contact;
    }
    @HTTPDelete
    global static void deleteContacts(){
        RestRequest contactRequest = RestContext.request;
        String contactRequestURI = contactRequest.requestURI;
        String[] contactIds = (contactRequestURI.substring(contactRequestURI.lastIndexOf('/')+1)).split(',');
        List<Contact> contactDelete = new List<Contact>();
        for(string st:contactIds){
            Contact con = new Contact(Id=st);
            contactDelete.add(con);
        }
        system.debug('List to delete'+contactDelete);
        Database.DeleteResult[] deleteResults = Database.delete(contactDelete, false);
        
    }

}