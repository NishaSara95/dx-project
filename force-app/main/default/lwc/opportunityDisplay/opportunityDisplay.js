import getOpportunity from "@salesforce/apex/OpportunityController.getOpportunity";
import { LightningElement, wire } from "lwc";

const columns= [
        { label: 'Opportunity Name', fieldName: 'Name',type:'text' },
    { label: 'Stage Name', fieldName: 'StageName', type: 'text' },
    { label: 'Amount', fieldName: 'Amount', type: 'Currency' },
    { label: 'Close Date', fieldName: 'CloseDate', type: 'Date' },
    { label: 'Account Name', fieldName: 'AccountName', type: 'text' }

]

export default class OpportunityDisplay extends LightningElement{

     searchKey = '';
    oppList;
    error;
    col=columns;
   @wire(getOpportunity, { searchKey: '$searchKey' })
wiredOpps({ error, data }) {
    if (data) {
             // Flatten count.Name so the datatable can display it
            this.oppList = data.map(row => ({
                ...row,
                AccountName: row.Account ? row.Account.Name : ''
            }));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.oppList = undefined;
            console.error(JSON.stringify(error));
        }
}

 handleChange(event) {
        this.searchKey = event.target.value;
    }

}


