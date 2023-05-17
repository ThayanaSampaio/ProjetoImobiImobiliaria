import { LightningElement, track } from 'lwc';

export default class SimuladorLocacaoImoveis extends LightningElement {
    @track numQuartos = '';
    @track numBanheiros = '';
    @track area = '';
    @track tipoImovel = '';
    @track simulacao = '';
    @track localizacaoImovel = '';

    @track showResultado = false;
    @track showRefresh = false;
    @track showError = false;

    localizacaoOptions = [
        { label: 'Capital', value: '1' },
        { label: 'Interior', value: '0.8' }
    ];

    
    imoveisOptions = [
        { label: 'Apartamento', value: '200' },
        { label: 'Kitnet', value: '300' },
        { label: 'Casa', value: '400' },
        { label: 'Casa em Condomínio', value: '500' },
    ];

    quartosOptions = [
        { label: '1', value: '100' },
        { label: '2', value: '200' },
        { label: '3', value: '300' },
        
        { label: '4', value: '400' },
        { label: '5+', value: '500' },
    ];

    banheirosOptions = [
        { label: '1', value: '100' },
        { label: '2', value: '200' },
        { label: '3', value: '300' },
        { label: '4+', value: '400' },
    ];

    areaOptions = [
        { label: '0 - 44', value: '300' },
        { label: '45 - 79', value: '400' },
        { label: '80 - 100', value: '500' },
        { label: '101 - 150', value: '600' },
        { label: '151 - 200', value: '700' },
        { label: 'Acima de 201', value: '800' },
    ];
    
    handleInputChangeLocalizacaoImovel(event) {
        this.localizacaoImovel = event.detail.value;
    }

    handleInputChangeTipoImovel(event) {
        this.tipoImovel = event.detail.value;
        if (this.tipoImovel === '300') { // 300 é o valor para a opção "Kitnet"
            this.quartosOptions = [{ label: '1', value: '100' }];
            this.banheirosOptions = [{ label: '1', value: '100' }];
            this.areaOptions = [
                { label: '0 - 44', value: '300' },
                { label: '45 - 79', value: '400' },
            ];
        } else {
            // restaurar as opções padrão para quartos, banheiros e área
            this.quartosOptions = [
                { label: '1', value: '100' },
                { label: '2', value: '200' },
                { label: '3', value: '300' },
                { label: '4', value: '400' },
                { label: '5+', value: '500' },
            ];
            this.banheirosOptions = [
                { label: '1', value: '100' },
                { label: '2', value: '200' },
                { label: '3', value: '300' },
                { label: '4+', value: '400' },
            ];
            this.areaOptions = [
                { label: '0 - 44', value: '300' },
                { label: '45 - 79', value: '400' },
                { label: '80 - 100', value: '500' },
                { label: '101 - 150', value: '600' },
                { label: '151 - 200', value: '700' },
                { label: 'Acima de 201', value: '800' },
            ];
        }
    }
    handleInputChangeNumQuartos(event) {
        this.numQuartos = event.detail.value;
    }
    handleInputChangeNumBanheiros(event) {
        this.numBanheiros = event.detail.value;
    }
    handleInputChangeArea(event) {
        this.area = event.detail.value;
    }


    calcularSimulacao() {

        this.simulacao = (this.localizacaoImovel * (parseFloat(this.tipoImovel) + parseFloat(this.numQuartos) + parseFloat(this.numBanheiros) + parseFloat(this.area))).toFixed(2);
        if (!this.tipoImovel || !this.numQuartos || !this.numBanheiros || !this.area) {
            this.showError = true;
            this.showResultado = false;
            this.showRefresh = true;
            return;
        } else {
            this.showResultado = true;
            this.showRefresh = true;
            this.showError = false;
        }


    }

    resetAction() {
        this.numQuartos = '';
        this.numBanheiros = '';
        this.area = '';
        this.tipoImovel = '';
        this.simulacao = '';
        this.showResultado = false;
        this.showRefresh = false;
        this.showError = false
    }
}