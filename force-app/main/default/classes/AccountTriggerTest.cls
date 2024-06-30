/**
 * @author maylsonbruno
 */
@isTest
public class AccountTriggerTest {

    @isTest
    public static void shouldValidateToInsertAccountWithWrong(){
        
        Account account = new Account();
        account.Name = 'MaylsonBruno';
        account.CpfCnpj__c = '11';

        Test.startTest();

        try{

          insert account;

        }catch(DmlException e){
         
            Assert.areEqual('Documento Inválido',e.getDmlMessage(0));
        }

        Test.stopTest();
    }

      @isTest
    public static void shouldValidateToChangeAccountWithWrong(){
        
        Account account = new Account();
        account.Name = 'MaylsonBruno';
        account.CpfCnpj__c = '76363217008';

        insert account;

        Test.startTest();

        try{

            account.CpfCnpj__c = '11';
            update account;

        }catch(DmlException e){
         
            Assert.areEqual('Documento Inválido', e.getDmlMessage(0));
        }

        Test.stopTest();
    }
}