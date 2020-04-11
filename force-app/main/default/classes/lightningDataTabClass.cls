public with sharing class lightningDataTabClass {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getAllOpps(String recordId) {
        system.debug('recordId--->'+RecordId );
        List<Opportunity> oppList = new List<Opportunity>();
        oppList = [SELECT Id, Name ,StageName, Amount,CloseDate from Opportunity where AccountId =:RecordId];
        return oppList;
    }

}