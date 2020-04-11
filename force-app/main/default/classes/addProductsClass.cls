public with sharing class addProductsClass {
    @AuraEnabled(cacheable=true)
    public static Id getPriceBookEntry( String recordId , String name) {
        system.debug('name ===>'+name +  '---Id' + recordId);
        List<PricebookEntry> pbEntry = new List<PricebookEntry>();
       pbEntry = [Select id,Pricebook2.Id,pricebook2.name  FROM PricebookEntry 
         WHERE  Product2.Name =:Name  AND Pricebook2.name = 'Acxiom Price Book'];
        system.debug('list--->'+pbEntry);
        return pbEntry[0].Id;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, Name, Title, Phone, Email FROM Contact LIMIT 1];
    }

}