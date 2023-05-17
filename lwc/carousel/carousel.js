import { LightningElement } from 'lwc';
import BANNER1 from '@salesforce/resourceUrl/Banner1';
import BANNER2 from '@salesforce/resourceUrl/Banner2';
import BANNER3 from '@salesforce/resourceUrl/Banner3';

export default class Basic extends LightningElement {
    banner1 = BANNER1;
    banner2 = BANNER2;
    banner3 = BANNER3;
}