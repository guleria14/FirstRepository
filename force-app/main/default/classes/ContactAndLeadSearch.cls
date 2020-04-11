public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String Name){
        String query = 'FIND \'' + Name + '\'  IN ALL FIELDS RETURNING Contact(FirstName,LastName),lead(FirstName,LastName)';
        //List<List<sObject>> searchList = search.query(query);
        List<List<sObject>> searchList1 = [FIND :Name IN ALL FIELDS RETURNING Contact(FirstName,LastName),lead(FirstName,LastName)];
       return searchList1;
        
    }

}