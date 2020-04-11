@RestResource(urlMapping='/Account/*/contacts/')
global class AccountManager {
    @HttpGET
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        system.debug('URI===>'+request.requestURI);
        String AccountId = request.requestURI.substringBetween('Accounts/','/contacts');
        system.debug('AccountID===>'+AccountId);
        Account objAccount = [Select id,name,(select id,name from Contacts) from Account where Id=:AccountId];
        return objAccount;
    }

}