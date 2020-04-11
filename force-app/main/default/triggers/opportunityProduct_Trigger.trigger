trigger opportunityProduct_Trigger on OpportunityLineItem (after insert) {
    Set<ID> validOpps = new Set<ID>();
    List<Opportunity> allOppList = new List<Opportunity>();
    List<Opportunity> oppUpdateList = new List<Opportunity>();
    for(OpportunityLineItem OLI : Trigger.New){
    system.debug('op line item' + Trigger.New);
    if(OLI.Product_Name__c=='SLA: Gold' || OLI.Product_Name__c =='SLA: Silver'){
    system.debug('yes');
        validOpps.add(OLI.opportunityId);
    }
    }
    system.debug('opportunities are===>' + validOpps );
    allOppList = [Select id,name,Product_Amount__c,(Select id,TotalPrice,OpportunityId from OpportunityLineItems) FROM Opportunity where Id IN: validOpps ];
    for(Opportunity opp :allOppList){
        for(OpportunityLineItem oli :opp.OpportunityLineItems){
            Opportunity oppty = new Opportunity();
            oppty.id = oli.OpportunityId;
            oppty.Product_Amount__c = oli.TotalPrice;
            oppUpdateList.add(oppty);
        }
    }
    
    
    if(oppUpdateList!=null && !oppUpdateList.isEmpty()){
        Set<Opportunity> mySet = new Set<Opportunity>();
        List<Opportunity> result = new List<Opportunity>();
        myset.addAll(oppUpdateList);
        result.addAll(myset);
        update result;
    }

}