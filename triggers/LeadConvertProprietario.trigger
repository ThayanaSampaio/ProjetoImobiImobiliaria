trigger LeadConvertProprietario on Lead (after update) {
    List<Contact> contactsToUpdate = new List<Contact>();
    for (Lead l : Trigger.new) {
        if (l.IsConverted && !Trigger.oldMap.get(l.Id).IsConverted) {
            // Lead acabou de ser convertido
            String intencao = l.Intencao__c;
            if (intencao != null) {
                Contact c = [SELECT Id, Cliente__c FROM Contact WHERE Id = :l.ConvertedContactId];
                if (c != null) {
                    if (intencao.equalsIgnoreCase('vender')) {
                        c.Cliente__c = 'Proprietário';
                    } else if (intencao.equalsIgnoreCase('locar')) {
                        c.Cliente__c = 'Proprietário';
                    } else if (intencao.equalsIgnoreCase('alugar')) {
                        c.Cliente__c = 'Inquilino';
                    } else if (intencao.equalsIgnoreCase('comprar')) {
                        c.Cliente__c = 'Comprador';
                    }
                    contactsToUpdate.add(c);
                }
            }
        }
    }
    if (!contactsToUpdate.isEmpty()) {
        update contactsToUpdate;
    }
}