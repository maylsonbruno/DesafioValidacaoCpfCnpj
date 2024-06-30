/**
 * @author maylsonbruno
 */
trigger Accounts on Account (before insert,before update) {

    List<Account> newAccounts= Trigger.new;

    Map<Id,Account> oldAccounts = Trigger.oldMap;

    Map<String, RecordTypeInfo> recordTypes = Account.getSObjectType()
        .getDescribe()
        .getRecordTypeInfosByDeveloperName();


        switch on Trigger.operationType {
        
            when BEFORE_INSERT  {
    
                for (Account account : newAccounts) {
                     
                  if ( String.isNotEmpty(account.CpfCnpj__c)){
                    
                     if(account.RecordTypeId== recordTypes.get('PessoaFisica').getRecordTypeId()) {
                         if (!AccountCpfValidator.validatorCPF(account.CpfCnpj__c)){
                            account.CpfCnpj__c.addError('Documento Inválido');
                         }
                               
                     }
    
                     if(account.RecordTypeId== recordTypes.get('PessoaJuridica').getRecordTypeId()){
                       if (!AccountCnpjValidator.validatorCNPJ(account.CpfCnpj__c)) {
                        account.CpfCnpj__c.addError('Documento Inválido');
                     }
                  }
    
                }
    
                }
              }
        
             when BEFORE_UPDATE {
    
                for (Account account : newAccounts) {
    
                    Account oldAccount = oldAccounts.get(account.Id);                
                  
                    if ( String.isNotEmpty(account.CpfCnpj__c)){
                      
                        if(account.RecordTypeId== recordTypes.get('PessoaFisica').getRecordTypeId()) {
                           if (!AccountCpfValidator.validatorCPF(account.CpfCnpj__c) && account.CpfCnpj__c != oldAccount.CpfCnpj__c){
                            account.CpfCnpj__c.addError('Documento Inválido');
                           }
                                 
                       }
      
                        if(account.RecordTypeId== recordTypes.get('PessoaJuridica').getRecordTypeId()){
                          if (!AccountCnpjValidator.validatorCNPJ(account.CpfCnpj__c) && account.CpfCnpj__c != oldAccount.CpfCnpj__c) {
                            account.CpfCnpj__c.addError('Documento Inválido');
                       }
                    }
      
                  }
    
             }
    
          }
        }
}