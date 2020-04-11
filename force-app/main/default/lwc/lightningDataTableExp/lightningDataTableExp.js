import { LightningElement,track , api,wire } from 'lwc';
import getAllOpps from '@salesforce/apex/lightningDataTabClass.getAllOpps';
const actions =[
    {label:'Edit',name:'edit'},
    {label:'Delete',name:'delete'}
];
const columns = [
    {label: 'Name',fieldName:'Name',editable:true},
    {label:'Stage',fieldName:'StageName',editable:true,type:'Picklist'},
    {label:'Amount',fieldName:'Amount',type:'currency',cellAttributes :{
        alignment:'left',
        iconName: 'utility:event'
    }},
    {label:'Close Date',fieldName:'CloseDate'},
    {
        type: 'action',
        typeAttributes : {
            rowActions :actions
        }
    }
    
];
export default class LightningDataTableExp extends LightningElement {
    @track data =[];
    @api recordId;
    @track columns = columns;
    @track loadMoreStatus;
    @api totalNumberOfRows = 5;
    
    @wire (getAllOpps,{recordId:'$recordId'})
    wiredOpps({
        error,
        data
    }) {
        if (data) {
            this.data = data;
            // eslint-disable-next-line no-console
            console.log(data);
            // eslint-disable-next-line no-console
            console.log(JSON.stringify(data, null, '\t'));
        } else if (error) {
            this.error = error;
        }
    }
    // eslint-disable-next-line no-undef
    
    

    loadMoreData(event) {
        // eslint-disable-next-line no-console
        console.log('Yes');
            //Display a spinner to signal that data is being loaded
            event.target.isLoading = true;
            //Display "Loading" when more data is being loaded
            this.loadMoreStatus = 'Loading';
            // eslint-disable-next-line no-console
            console.log('data length --->', this.data.length);
            // eslint-disable-next-line no-console
            console.log('No of Rows length --->', this.totalNumberOfRows);
            if(this.data.length>=this.totalNumberOfRows){
                // eslint-disable-next-line no-console
                console.log('length');
                event.target.enableInfiniteLoading = true;
                this.loadMoreStatus = 'Loading';

            }else{
                event.target.enableInfiniteLoading = false;
                // eslint-disable-next-line no-console
                console.log('No');
                /*const currentData = this.data;
                //const newData = currentData.concat(data)
                this.data = currentData;
                this.loadMoreStatus = '';*/
            }
          
            event.target.isLoading = false;
        }


    
}