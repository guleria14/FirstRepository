@isTest
public class AccountProcessorTest {
@isTest
    static void countContactsTest(){
        Account a = new Account(Name='Test');
             insert a;
        Contact c = new Contact(FirstName='testing',LastName='Test',Accountid=a.id);
             insert c;
        Contact cn = new Contact(FirstName='Nice',LastName='Test',AccountId = a.id);
             insert cn;
       list<Account> accList = [select id ,Number_of_Contacts__C,(Select id from Contacts) From Account where id = :a.Id ];
       List <Id> nlist = new List <Id>();
        for(Account at :accList){
          nlist.add(at.id);
        }
        System.test.startTest();
        AccountProcessor.CountContacts(nlist);
        System.test.stopTest();
        Account aCnt = [Select id , Number_of_Contacts__c from Account];
       system.assertEquals(2,aCnt.Number_of_Contacts__c); 

    }
}