public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds){
        List<Account> accts = [Select id ,name,Number_of_Contacts__c,(Select id from Contacts where accountid IN:accountIds) From Account where Id IN:accountIds];
        List<Account> updatedAcc = new List<Account>();
        for(Account a :accts){
            a.Number_of_Contacts__c =a.Contacts.size();
            updatedAcc.add(a);
        }
        update updatedAcc;
    }

}