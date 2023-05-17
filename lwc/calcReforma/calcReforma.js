import { LightningElement, track } from 'lwc';

export default class CalcReforma extends LightningElement {

    @track tipoReforma = '';
    @track padraoAcabamento = '';
    @track tipoPiso = '';
    @track area = '';

    @track simulacao = '';

    @track showFormTipoReforma1 = true;
    @track showFormTipoReforma2 = false;
    
    @track showResultado = false;
    @track showRefresh = false;
    @track showError = false;

    areaOptions = [
        { label: '0 - 44', value: '300' },
        { label: '45 - 79', value: '400' },
        { label: '80 - 100', value: '500' },
        { label: '101 - 150', value: '600' },
        { label: '151 - 200', value: '700' },
        { label: 'Acima de 201', value: '800' },
    ];

    tipoReformaOptions = [
        { label: 'Completa', value: '1' },
        { label: 'Banheiro', value: '2' },
        { label: 'Cozinha', value: '3' },
        { label: 'Quarto', value: '4' },
        { label: 'Sala', value: '5' },
    ];

    padraoAcabamentoOptions = [
        { label: 'Popular', value: '100' },
        { label: 'Qualidade', value: '200' },
        { label: 'Luxo', value: '300' },
    ];

    tipoPisoOptions = [
        { label: 'Porcelanato', value: '100' },
        { label: 'Cerâmico', value: '200' },
        { label: 'Laminado de madeira', value: '300' },
    ];

    handleTipoReforma(event) {
        this.tipoReforma = event.detail.value;

        this.showFormTipoReforma1 = false;
        this.showFormTipoReforma2 = true;

        if (this.tipoReforma == 1) {
            this.showFormTipoReforma1 = true;
            this.showFormTipoReforma2 = false;
        }
    }

    handlePadraoAcabamento(event) {
        this.padraoAcabamento = event.detail.value;
    }

    handleTipoPiso(event) {
        this.tipoPiso = event.detail.value;
    }

    handleArea(event) {
        this.area = event.detail.value;
    }

    isEmpty(value){
        return (value == null || value.length === 0);
    }
    
    calcularSimulacao() {

        if (this.isEmpty(this.tipoReforma)) {
            this.showError = true;
            this.showResultado = false;
            this.showRefresh = true;
            return;
        }

        if (
            (this.tipoReforma == 1) && 
            (this.isEmpty(this.padraoAcabamento) || this.isEmpty(this.area))
        ) {
            this.showError = true;
            this.showResultado = false;
            this.showRefresh = true;
            return;
        }

        if (
            (this.tipoReforma == 2 || this.tipoReforma == 3 || this.tipoReforma == 4 || this.tipoReforma == 5) && 
            (this.isEmpty(this.tipoPiso) || this.isEmpty(this.area))
        ) {
            this.showError = true;
            this.showResultado = false;
            this.showRefresh = true;
            return;
        }
            
        if (this.tipoReforma == 1) {
            this.simulacao = (parseFloat(this.padraoAcabamento) * parseFloat(this.area)).toFixed(2);
        } else {
            this.simulacao = (parseFloat(this.tipoPiso) * parseFloat(this.area)).toFixed(2);
        }

        console.log('tipoReforma: ' + this.tipoReforma);
        console.log('padraoAcabamento: ' + this.padraoAcabamento);
        console.log('tipoPiso: ' + this.tipoPiso);
        console.log('area: ' + this.area);
        console.log('simulacao: ' + this.simulacao);

        this.showResultado = true;
        this.showRefresh = true;
        this.showError = false;

    }

    resetAction() {
        this.tipoReforma = '';
        this.padraoAcabamento = '';
        this.tipoPiso = '';
        this.area = '';
        
        this.showResultado = false;
        this.showRefresh = false;
        this.showError = false
    }
}