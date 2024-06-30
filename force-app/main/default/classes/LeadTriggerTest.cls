/**
 * @author MaylsonBruno
 */

@isTest
public class LeadTriggerTest {
  
    @isTest
    public static void shouldValidateToInsertLeadWithWrong(){

       Lead lead = new Lead();
       lead.LastName = 'MaylsonBruno';
       lead.Company = 'MaylsonCompany';
       lead.CpfCnpj__c = '11';

       Test.startTest();

       try{

        insert lead;
        

       } catch (DmlException e){
         
        Assert.areEqual('Documento Inválido', e.getDmlMessage(0));
       }
       
       Test.stopTest();
     
    }

    @isTest
    public static void shouldValidateToChangeLeadWithWrong(){

       Lead lead = new Lead();
       lead.LastName = 'MaylsonBruno';
       lead.Company = 'MaylsonCompany';
       lead.CpfCnpj__c = '76363217008';

       insert lead;

       Assert.isNotNull(lead.Id,'Id expected');

       Test.startTest();

       try{
         
        lead.CpfCnpj__c = '02387238712ss';
        update lead;

       } catch (DmlException e){
        
        Assert.areEqual('Documento Inválido', e.getDmlMessage(0));
       }
       
       Test.stopTest();
     
    }
}