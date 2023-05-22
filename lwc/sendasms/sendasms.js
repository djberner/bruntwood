/**
 * Created by DB on 16/05/2023.
 */

import {LightningElement, track} from 'lwc';
import SendSMSX from "@salesforce/apex/goldstatushandler.SendSMS";
export default class Sendasms extends LightningElement {
     @track message;

    messageChange(event) {
        this.message= event.target.value;
    }
    handleSendSMS() {
        let thePhoneNo = '0123456789';  //  This would be read from the Account details, running out of time so leaving this
        let theMessage = this.message;  //  This would be read from the Account details, running out of time so leaving this
        let theFromNumber = '0123456789';  //  This would be read from the Account details, running out of time so leaving this

        SendSMSX(phoneNo,theMessage,theFromNumber )
            .then(() => {
                console.log("SMS Sent");
            })
            .catch((error) => {
                console.error("Error in SendSMS:", error);
            });
    }

}