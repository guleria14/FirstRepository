public class AccountHandler {
    public static Account insertNewAccount(String Name){
        Account newAccount = new Account();
        newAccount.Name = Name;
        try{
            insert newAccount;
        }
        catch(DmlException  e){
            return null;
        }
        return newAccount;
    }

}