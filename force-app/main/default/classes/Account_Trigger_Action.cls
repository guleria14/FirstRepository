public class Account_Trigger_Action {
    List<Opportunity> opportunities = new List<Opportunity>();
    List<OpportunityTeamMember> oppTeam = new List<OpportunityTeamMember>();
    List<OpportunityTeamMember> oppTeamDelete = new List<OpportunityTeamMember>();
    Map<ID,ID> userAccount = new Map<ID,ID>();
    Map<ID,ID> userAccountDel = new Map<ID,ID>();
    Set<ID> accId = new Set<ID>(); //account ids
    Set<Id> oldTeamUser = new Set<Id>();//old userId in opp team
    Set<Id> accountRisk = new Set<Id>();
 
    public void oppTeamMember(List<Account> newAccount, Map<Id,Account> oldAccount){    
        for(Account acc : newAccount){
            accID.add(acc.id);
            system.debug(accId);
            // if risk was null and then updated and have some value
            if(acc.Risk_Account_Executive__c!=null && oldAccount.get(acc.id).Risk_Account_Executive__c==Null){
                userAccount.put(acc.id,acc.Risk_Account_Executive__c);
                accountRisk.add(acc.Id);
                accountRisk.add(oldAccount.get(acc.id).Risk_Account_Executive__c);
                
            }
            //if risk first have old value and now have new value
            if(acc.Risk_Account_Executive__c!=null && oldAccount.get(acc.id).Risk_Account_Executive__c!=Null){
                if(acc.Risk_Account_Executive__c != oldAccount.get(acc.id).Risk_Account_Executive__c){
                    userAccount.put(acc.id,acc.Risk_Account_Executive__c); 
                    userAccountDel.put(acc.id,oldAccount.get(acc.id).Risk_Account_Executive__c);
                    accountRisk.add(acc.Id);
                }
            }
        }
        for(Opportunity opp : [select id, name, accountid, ownerid, StageName,
                               (SELECT id FROM OpportunityTeamMembers WHERE userid IN: oldTeamUser 
                                LIMIT 1 ) FROM opportunity WHERE
                               accountid IN :accountRisk]){
                                   if(opp.OwnerId!=null){
                                       oppTeam.add(insertOppTeam(opp.id,userAccount.get(opp.AccountId),'Risk - Executive','Edit'));
                                   }
                                   if(opp.OpportunityTeamMembers!=null & !opp.OpportunityTeamMembers.IsEmpty()){
                                       oppTeamDelete.add(opp.OpportunityTeamMembers[0]);
                                   }
                                   
                               }
        
        system.debug('Opp Team Member to insert ===>'  + oppTeam);
        if(oppTeam!=null && !oppTeam.isEmpty()){
            database.insert(oppTeam);
        }
        system.debug('Opp Team Member to insert ===>'  + oppTeamDelete);
        if(oppTeamDelete!=null && !oppTeam.isEmpty()){
            database.delete(oppTeamDelete);
        }
        
    }
     public OpportunityTeamMember insertOppTeam(ID OpportunityId, ID Userid, String TeamMemberRole, String OpportunityAccessLevel){
        
         return new OpportunityTeamMember(
             OpportunityId = OpportunityId,
             Userid = Userid,
             TeamMemberRole = TeamMemberRole,
             OpportunityAccessLevel = OpportunityAccessLevel
         );                                      
    }

}