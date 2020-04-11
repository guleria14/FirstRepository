/* eslint-disable no-console */
import { LightningElement, track , api , wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { NavigationMixin } from 'lightning/navigation';
import { getRecord } from 'lightning/uiRecordApi';
import getPriceBookEntry from '@salesforce/apex/addProductsClass.getPriceBookEntry';
const FIELDS = [
    'Opportunity.Name',
    'Opportunity.StageName',
    'Opportunity.Amount'
]
export default class ModalLwc extends NavigationMixin(LightningElement) {
     @track bShowModal = false;
     @api recordId;
     @track record;
     @track dd;
     @track productName;
    @track error;
     @track pentry;
    @wire (getRecord,{recordId:'$recordId',fields: FIELDS})
    record;
    formFields;
   /* @wire (getPriceBookEntry,{recordId :'$recordId',name : 'FIRST PARTY DATA ENHANCEMENT'})
    pEntry;*/
    handleSubmit(event){
        event.preventDefault();
        const fields = event.detail.fields;
        this.formFields = JSON.parse(JSON.stringify(fields));
        this.productName = this.formFields.Product_Names__c;
        window.clearTimeout(this.delayTimeout);
    // eslint-disable-next-line @lwc/lwc/no-async-operation
   
        getPriceBookEntry({
            recordId :'$recordId',name :this.productName
        }).then(result => {

            //this.pentry = result;
            fields.PricebookEntryId = result;
        })
            .catch(error => {
                this.error = error;
            });
    
        
       //fields.PricebookEntryId = this.pentry;
        console.log('fields--->',fields);
        
        //console.log('fields--->',fields);
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }
    handleSuccess(){
        //const updatedRecord = event.detail.id;
        
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                actionName: 'view',
            },
        }).then(url => {
            const event = new ShowToastEvent({
                "title": "Success!",
                "message": "Record {0} created! See it {1}!",
                "messageData": [
                    'Salesforce',
                    {
                        url,
                        label: 'here'
                    }
                ]
            });
            this.dispatchEvent(event);
        });
        
        this.bShowModal = false;
        // eslint-disable-next-line no-eval
        eval("$A.get('e.force:refreshView').fire();");
    }
    get name(){
        var dd = this.record.data;
        /*var x = this.record.data.fields.Name.value;
        console.log('---x----',x);
        return x;*/
        return dd;
    }
    /* javaScipt functions start */ 
    openModal() {    
        // to open modal window set 'bShowModal' tarck value as true
        this.bShowModal = true;
        console.log('recordid ==>',this.recordId);
    }
    closeModal() {    
        // to close modal window set 'bShowModal' tarck value as false
        this.bShowModal = false;
    }
    /* javaScipt functions end */ 
}