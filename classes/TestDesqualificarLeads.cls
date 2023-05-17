@isTest
public class TestDesqualificarLeads {
    @isTest
    static void testarLeadsComEstadoValido() {
        // Criação de um lead com estado válido
        Lead leadValido = new Lead();
        leadValido.FirstName = 'Fulano';
        leadValido.LastName = 'DeTal';
        leadValido.Company = 'ABC.';
        leadValido.Estado__c = 'CE'; // estado válido
        leadValido.Email = 'fulano@gmail.com';

        // Adiciona o lead em uma lista para inserção
        List<Lead> leads = new List<Lead>{leadValido};

        // Insere o lead
        Test.startTest();
        insert leads;
        Test.stopTest();

        // Consulta o lead novamente do banco de dados
        Lead leadConsultado = [SELECT Status FROM Lead WHERE Id = :leads[0].Id];

        // Verifica se o lead não foi desqualificado
        System.assertEquals('Novo', leadConsultado.Status);
    }

    @isTest
    static void testarLeadsComEstadoInvalido() {
        // Criação de um lead com estado inválido
        Lead leadInvalido = new Lead();
        leadInvalido.FirstName = 'Ciclano';
        leadInvalido.LastName = 'DeTal';
        leadInvalido.Company = 'ABC.';
        leadInvalido.Estado__c = 'RS'; // estado inválido
        leadInvalido.Email = 'fulano@gmail.com';

        // Adiciona o lead em uma lista para inserção
        List<Lead> leads = new List<Lead>{leadInvalido};

        // Insere o lead
        Test.startTest();
        insert leads;
        Test.stopTest();

        // Consulta o lead novamente do banco de dados
        Lead leadConsultado = [SELECT Status, Description FROM Lead WHERE Id = :leads[0].Id];

        // Verifica se o lead foi desqualificado e se a descrição da desqualificação foi definida corretamente
        System.assertEquals('Novo', leadConsultado.Status);
        System.assertEquals('Lead foi inserido como Novo', leadConsultado.Description);
    }
}