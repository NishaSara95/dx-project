import { LightningElement,api } from 'lwc';

export default class ProgressbarChild extends LightningElement {
     @api percentage;

    get style() {
        return `width: ${this.percentage}%`;
    }
}