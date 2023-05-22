public with sharing class goldstatushandler {

        public static void CheckifGold(List<Account> newAccs)
        {
            List<Id> newGold = new List<Id>();
            List<User> theCEO =[SELECT Phone FROM User WHERE Name = 'David Berner' LIMIT 1];
            String ceoPhoneNumber =  theCEO[0].Phone;
            for(Account newAcc : newAccs)
            {
                if( newAcc.Customer_classification__c=='GOLD')
                {
                    SendSMS(ceoPhoneNumber, 'Grest News! A customer has hit Gold. '+newAcc.Name+' will get VIP treatment', '01234 567890');
                }
            }

        }
    @AuraEnabled
    public static String SendSMS(String phoneNo, String smsBody, String fromPhNumber){
        String accountSid = 'XXXXXXXXX'; // you can put ACCOUNT SID from twilio account
        String token = 'XXXXXXXX'; // you can put AUTH TOKEN from twilio account
        String endPoint = 'https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json';
        Blob creds = Blob.valueOf(accountSid+':' +token);
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        req.setEndpoint(endPoint);
        req.setMethod('POST');
        String VERSION  = '3.2.0';
        req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
        req.setHeader('Accept', 'application/json');
        req.setHeader('Accept-Charset', 'utf-8');
        req.setHeader('Authorization', 'Basic '+EncodingUtil.base64Encode(creds));
        req.setBody('To=' + EncodingUtil.urlEncode(phoneNo, 'UTF-8') + '&From=' + EncodingUtil.urlEncode(fromPhNumber,'UTF-8') + '&Body=' + smsBody);
        res = http.send(req);
        System.debug(res.getBody());

        if(res.getStatusCode() == 201){
            return 'SMS Sent Successfully';
        } else{
            errorWrapper er = (errorWrapper)JSON.deserialize(res.getBody(), errorWrapper.class);
            throw newMessageException('Error : ' + er.message);
        }
    }

    public class errorWrapper{
        final String code = '';
        final String message = '';
        final String moreInfo = '';
        final String status = '';
    }

    private static AuraHandledException newMessageException(String message) {
        AuraHandledException e = new AuraHandledException(message);
        e.setMessage(message);
        return e;
    }
}