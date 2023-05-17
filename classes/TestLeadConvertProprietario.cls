@IsTest
public class TestLeadConvertProprietario {
    
    @IsTest
    public static void LeadConvertProprietarioPositivo() {
        // Criação de um Lead
        Lead lead = new Lead();
        lead.FirstName = 'Fulando';
        lead.LastName = 'Detal';
        lead.Email = 'Fulando@gmail.com';
        lead.Company = 'ABC';
        lead.Estado__c = 'RJ';
        lead.Intencao__c = 'vender';
        insert lead;
        
        // Simulação de conversão do Lead
        Database.LeadConvert leadConvert = new Database.LeadConvert();
        leadConvert.setLeadId(lead.Id);
        leadConvert.setConvertedStatus('Convertido');
        
        Database.LeadConvertResult convertResult = Database.convertLead(leadConvert);
        
        // Verificação do resultado esperado
        Contact convertedContact = [SELECT Id, Cliente__c FROM Contact WHERE Id = :convertResult.getContactId()];
        System.assertEquals('Proprietário', convertedContact.Cliente__c, 'Cliente__c deve ser "Proprietário"');
        
    }  
    
     @IsTest
    public static void LeadConvertProprietarioPositivo2() {
        // Criação de um Lead
        Lead lead = new Lead();
        lead.FirstName = 'Fulando';
        lead.LastName = 'Detal';
        lead.Email = 'Fulando@gmail.com';
        lead.Company = 'abc';
        lead.Estado__c = 'RJ';
        lead.Intencao__c = 'alugar';
        insert lead;
        
        // Simulação de conversão do Lead
        Database.LeadConvert leadConvert = new Database.LeadConvert();
        leadConvert.setLeadId(lead.Id);
        leadConvert.setConvertedStatus('Convertido');
        
        Database.LeadConvertResult convertResult = Database.convertLead(leadConvert);
        
        // Verificação do resultado esperado
        Contact convertedContact = [SELECT Id, Cliente__c FROM Contact WHERE Id = :convertResult.getContactId()];       
         System.assertEquals('Inquilino', convertedContact.Cliente__c, 'Cliente__c deve ser "Proprietário"');
    }  
     @IsTest
    public static void LeadConvertProprietarioNegativo() {
        // Criação de um Lead
        Lead lead = new Lead();
        lead.FirstName = 'Fulando';
        lead.LastName = 'Detal';
        lead.Email = 'Fulando@gmail.com';
        lead.Company = 'ABC';
        lead.Estado__c = 'RJ';
        lead.Intencao__c = 'vender';
        insert lead;
        
        // Simulação de conversão do Lead
        Database.LeadConvert leadConvert = new Database.LeadConvert();
        leadConvert.setLeadId(lead.Id);
        leadConvert.setConvertedStatus('Convertido');
        
        Database.LeadConvertResult convertResult = Database.convertLead(leadConvert);
        
        // Verificação do resultado esperado
        Contact convertedContact = [SELECT Id, Cliente__c FROM Contact WHERE Id = :convertResult.getContactId()];
        System.assertEquals('Inquilino', convertedContact.Cliente__c, 'Cliente__c deve ser "Proprietário"');
         
    }  
    
     @IsTest
    public static void LeadConvertProprietarioNegativo2() {
        // Criação de um Lead
        Lead lead = new Lead();
        lead.FirstName = 'Fulando';
        lead.LastName = 'Detal';
        lead.Email = 'Fulando@gmail.com';
        lead.Company = 'abc';
        lead.Estado__c = 'RJ';
        lead.Intencao__c = 'alugar';
        insert lead;
        
        // Simulação de conversão do Lead
        Database.LeadConvert leadConvert = new Database.LeadConvert();
        leadConvert.setLeadId(lead.Id);
        leadConvert.setConvertedStatus('Convertido');
        
        Database.LeadConvertResult convertResult = Database.convertLead(leadConvert);
        
        // Verificação do resultado esperado
        Contact convertedContact = [SELECT Id, Cliente__c FROM Contact WHERE Id = :convertResult.getContactId()];       
         System.assertEquals('Proprietário', convertedContact.Cliente__c, 'Cliente__c deve ser "Inquilino"');
    } 
}