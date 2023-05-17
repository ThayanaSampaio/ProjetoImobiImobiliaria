import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class OportunidadeHome extends LightningElement {
    @api objectApiName = 'Opportunity';
    @api nameField = 'Name';
    
    @api stageNameField = 'StageName';
    @api closeDateField = 'CloseDate';
    @api amountField = 'Amount';

    handleSuccess(event) {
        const recordId = event.detail.id;
        const message = `Oportunidade criada com sucesso! Id: ${recordId}`;
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Sucesso',
                message: message,
                variant: 'success',
            }),
        );
        this.handleReset();
    }

    handleError(event) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Erro',
                message: 'Ocorreu um erro ao criar a oportunidade.',
                variant: 'error',
            }),
        );
    }

    handleReset() {
        const inputFields = this.template.querySelectorAll('lightning-input-field');
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }
}