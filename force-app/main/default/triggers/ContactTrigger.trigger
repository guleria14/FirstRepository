trigger ContactTrigger on Contact (before delete,after insert,after delete) {
    if(Trigger.isBefore){
        for(Contact con : Trigger.old){
            if(con.AccountId !=null){
                //con.addError('Contact Associated with any account Cannot be deleted');
            }
        }
    }
    if(Trigger.isAfter){
        List<Contact> cons = new List<Contact>();
        List<Account> accUpdate = new List<Account>();
        Set<Id> acctIds = new Set<Id>();
        
        if(Trigger.isInsert){
            
            for(Contact con : Trigger.New){
               acctIds.add(con.AccountId); 
            }
            
        }
        if(Trigger.isDelete){
            for(Contact con : Trigger.Old){
              acctIds.add(con.AccountId);  
            }
        }
        List<Account> accConMap = new List<Account>([Select Id,Name,Number_of_Contacts__c,(Select Id,name from Contacts) From Account where id IN :acctIds]);
        system.debug('-----123---' + accConMap);
        for(Account acc : accConMap){
            if(acc.Contacts.size()==0){
                acc.Number_of_Contacts__c = 0;
            }
            else{
                acc.Number_of_Contacts__c = acc.Contacts.size();
            }
           accUpdate.add(acc); 
        }
        if(accUpdate!=null && !accUpdate.isEmpty()){
            update accUpdate;
        }
    }
    

}