import { LightningElement } from 'lwc';

export default class Progressbar extends LightningElement {
     percentage = 50;

    handlePercentageChange(event) {
        this.percentage = event.target.value;
    }
}