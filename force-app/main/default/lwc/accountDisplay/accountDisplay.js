import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/ServerSideController.getAccounts';
const columns = [
    { label: 'Account Name', fieldName: 'Name',type:'text' },
    { label: 'Type', fieldName: 'Type', type: 'text' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
   ];
export default class AccountDisplay extends LightningElement {
    accList;
    col = columns;
    @wire(getAccounts)
wiredAccounts({ error, data }) {
    if (data) {
        this.accList = data; 
    } else if (error) {
        this.error = error;
         console.error(JSON.stringify(error));
    }
}
}