@isTest
public class TestCriarHistoricoDeVisita {
    @isTest
    public static void testPositivo() {
        // Criação dos dados de teste
        Product2 produto = new Product2();
        produto.Name = 'Fulano';
        produto.Contato__c = 'Ciclano';
        produto.Visita_Agendada__c = Date.today();

        // Inserção do registro de teste
        Test.startTest();
        insert produto;
        Test.stopTest();

        // Realiza uma nova consulta para obter o registro atualizado
        produto = [SELECT HistoricoVisita__c, Contato__c, Visita_Agendada__c FROM Product2 WHERE Id = :produto.Id];

        // Verifica se o histórico de visita foi atualizado corretamente
        String historicoEsperado = 'Contato: Ciclano, Data de visita agendada: ' + Date.today();
        System.assertEquals(historicoEsperado, produto.HistoricoVisita__c);
    }
     @isTest
    public static void testNegativo() {
        // Criação dos dados de teste
        Product2 produto = new Product2();
        produto.Name = 'Fulano';
        produto.Contato__c = null; // Define Contato__c como nulo
        produto.Visita_Agendada__c = Date.today();

        // Inserção do registro de teste
        Test.startTest();
        insert produto;
        Test.stopTest();

        // Realiza uma nova consulta para obter o registro atualizado
        produto = [SELECT HistoricoVisita__c, Contato__c, Visita_Agendada__c FROM Product2 WHERE Id = :produto.Id];

        // Verifica se os campos Contato__c e Visita_Agendada__c permanecem nulos
        String historicoEsperado = 'Contato: Ciclano, Data de visita agendada: ' + Date.today();
        System.assertEquals(historicoEsperado, produto.HistoricoVisita__c);
    }
}