trigger AccountTrigger on Account (before insert,after insert ,after update) {
    if(trigger.isBefore && Trigger.isInsert){
        Set<Id>setAccOwner=new Set<Id>(); 
        for(Account Acc: trigger.new) 
        { 
            setAccOwner.add(Acc.OwnerId); 
            Acc.Account_Rep__c = Acc.owner.name;
        }
        map<id,user>userMap=new map<id,user>();
        for(user u:[select id,Name from user where id IN:setAccOwner]){
            userMap.put(u.id,u);
        }
        for(Account Acc: Trigger.new)
            
        { 
            
            Acc.Account_Rep__c=UserMap.get(Acc.OwnerId).Name; 
        }
    }
    if(Trigger.isAfter){
        List<Opportunity> oppInsert = new List<Opportunity>();
        Map<Id,Account> accWithOpp = new Map<Id,Account>([Select id,name,(select Id,name from Opportunities) from Account where Id IN:Trigger.New]);
        for(Account acc : Trigger.New){
            if(accWithOpp.get(acc.Id).Opportunities.Size()==0){
                Opportunity opp = new Opportunity();
                opp.Name = 'Test Opportunity' + acc.Name;
                opp.StageName='Prospecting';
                opp.CloseDate = System.today().addMonths(1);
                opp.AccountId = acc.id;
                oppInsert.add(opp);
            } 
        }
        if(oppInsert!=null && !oppInsert.isEmpty()){
            insert oppInsert;
        }

    }
    
}