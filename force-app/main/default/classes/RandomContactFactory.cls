public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer con,String LName){
        List<Contact> cons = new List<Contact>();
        
        for(Integer i=0;i<con;i++) {
            Contact con1 = new Contact(FirstName='Test' + i,LastName = LName );
            cons.add(con1);
        }
        return cons;
    }

}