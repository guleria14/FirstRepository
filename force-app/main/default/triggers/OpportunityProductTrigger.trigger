trigger OpportunityProductTrigger on OpportunityLineItem (before insert,after Insert,after Delete) {
    Set<Id> oppIds = new Set<Id>();
    if(Trigger.isInsert){
        for(OpportunityLineItem opp :Trigger.New){
        oppIds.add(opp.OpportunityId);
    }
    system.debug('Opportunities===>'+oppIds);
        if(oppIds!=null &oppIds.size()>0){
            OpportunityProductClass.updateProductonOpp(oppIds,true,false);
        }
    }
    if(Trigger.isAfter && Trigger.isDelete){
        for(OpportunityLineItem opp :Trigger.old){
            oppIds.add(opp.OpportunityId);
        }
        
        if(oppIds!=null &oppIds.size()>0){
            OpportunityProductClass.updateProductonOpp(oppIds,false,true);
        }    
        
    }
}