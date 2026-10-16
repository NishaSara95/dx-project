import { LightningElement,track } from 'lwc';
import createContact from '@salesforce/apex/ServerSideController.createContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactCreation extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track contactId;
    @track error;

    handleChange(event) {
        const field = event.target.name;
        this[field] = event.target.value;
    }

    handleSave() {
        createContact({ 
            firstName: this.firstName, 
            lastName: this.lastName, 
            email: this.email 
        })
        .then(result => {
            this.contactId = result;
            this.error = undefined;
             this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: `Contact created successfully! Id: ${this.contactId}`,
                        variant: 'success'
                    })
                );
                 window.location.reload();
        })
        .catch(error => {
           this.error = error.body?.message || error.message || 'Unknown error';
            this.contactId = undefined;
             this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: this.error,
                        variant: 'error',
                        mode: 'sticky'
                    })
                );

        });
    }

}