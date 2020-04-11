@isTest
public class AccountManagerTest {
    static testMethod void testMethod1(){
        Account acc = new Account();
        acc.name = 'Test Account';
       insert acc;
        Contact con = new Contact(
            Lastname = 'Test Contact',
            AccountId = acc.Id);
        insert con;
            
            Id recordId = acc.Id;
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://sandeepidentity-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount!= null);
        System.assertEquals('test Account', thisAccount.Name);
        
    }
}