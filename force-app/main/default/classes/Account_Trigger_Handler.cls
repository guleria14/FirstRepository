public class Account_Trigger_Handler {
    Account_Trigger_Action acx = new Account_Trigger_Action();
    public void afterUpdate(Map<Id,Account>newMap, Map<Id,Account> oldMap){
        acx.oppTeamMember(newMap.values(), oldMap);
    }

}