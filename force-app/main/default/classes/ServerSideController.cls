public with sharing class ServerSideController {
@AuraEnabled(Cacheable=true)
public static List<Account>  getAccounts(){
return [SELECT Id,Name,Type,Industry FROM Account];
}
@AuraEnabled
public static String createContact(String firstName, String lastName, String email) {
    try {
        Contact con = new Contact(
            FirstName = firstName,
            LastName  = lastName,
            Email     = email
        );
        insert con;
        return con.Id;
    } catch (DmlException e) {
        throw new AuraHandledException(e.getMessage());
    } catch (Exception ex) {
        throw new AuraHandledException('Unexpected error: ' + ex.getMessage());
    }
}

}