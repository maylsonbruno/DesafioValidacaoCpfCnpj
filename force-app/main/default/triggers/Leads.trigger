/**
 * @author MaylsonBruno
 */

trigger Leads on Lead (before insert,before update) {

    List<Lead> newLeads= Trigger.new;

    Map<Id,Lead> oldLeads = Trigger.oldMap;

    Map<String, RecordTypeInfo> recordTypes = Lead.getSObjectType()
        .getDescribe()
        .getRecordTypeInfosByDeveloperName();

    switch on Trigger.operationType {
        
        when BEFORE_INSERT  {

            for (Lead lead : newLeads) {
                 
              if ( String.isNotEmpty(lead.CpfCnpj__c)){
                
                 if(lead.RecordTypeId== recordTypes.get('PessoaFisica').getRecordTypeId()) {
                     if (!LeadCpfValidator.validatorCPF(lead.CpfCnpj__c)){
                      lead.CpfCnpj__c.addError('Documento Inválido');
                     }
                           
                 }

                 if(lead.RecordTypeId== recordTypes.get('PessoaJuridica').getRecordTypeId()){
                   if (!LeadCnpjValidator.validatorCNPJ(lead.CpfCnpj__c)) {
                   lead.CpfCnpj__c.addError('Documento Inválido');
                 }
              }

            }
            }
          }
    
         when BEFORE_UPDATE {

            for (Lead lead : newLeads) {

                Lead oldLead = oldLeads.get(lead.Id);                
              
                if ( String.isNotEmpty(lead.CpfCnpj__c)){
                 
                    if(lead.RecordTypeId== recordTypes.get('PessoaFisica').getRecordTypeId()) {
                       if (!LeadCpfValidator.validatorCPF(lead.CpfCnpj__c) && lead.CpfCnpj__c != oldLead.CpfCnpj__c){
                        lead.CpfCnpj__c.addError('Documento Inválido');
                       }
                             
                   }
  
                    if(lead.RecordTypeId== recordTypes.get('PessoaJuridica').getRecordTypeId()){
                      if (!LeadCnpjValidator.validatorCNPJ(lead.CpfCnpj__c) && lead.CpfCnpj__c != oldLead.CpfCnpj__c) {
                     lead.CpfCnpj__c.addError('Documento Inválido');
                   }
                }
  
              }

         }

      }
    }

  }