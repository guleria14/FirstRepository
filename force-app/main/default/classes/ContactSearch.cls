public class ContactSearch {
    public static List<Contact> searchForContacts(String fName, String pCode){
        Contact[] cons = [Select Id, Name from Contact where LastName=:fName and MailingPostalCode=:pCode];
        return cons;
        
    }
}