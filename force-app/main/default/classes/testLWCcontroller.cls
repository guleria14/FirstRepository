public with sharing class testLWCcontroller {
    @AuraEnabled(cacheable=true)
	public static Id getPriceBookEntry() {
        List<PricebookEntry> pBookEntry = new List<PricebookEntry>();
        pBookEntry = [select id,Pricebook2.Name from PricebookEntry where Product2.Name = 'THIRD PARTY AUDIENCES' and Pricebook2.Name = 'Standard Price Book'];
       // return [SELECT Id, Name, Title, Phone, Email, Picture__c FROM Contact WHERE Picture__c != null LIMIT 10];
       return pBookEntry[0].Id;
    }
}