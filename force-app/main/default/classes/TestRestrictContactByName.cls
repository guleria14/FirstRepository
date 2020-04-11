@isTest
public class TestRestrictContactByName {

    static testMethod void testName() {
        List<Contact> conList = new List<Contact>();
    Contact con = new Contact();
        con.FirstName = 'Test';
        con.LastName = 'INVALIDNAME';
    Contact con2 = new Contact(FirstName = 'test1',LastName= 'INVALIDNAME');
        conList.add(con);
        conList.add(con2);
         system.Test.startTest();
        try{
            insert conList;
        }catch(Exception ee){
            
        }
        system.Test.stopTest();
}
    
}