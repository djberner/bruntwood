trigger AccountTrigger on Account (after update) {
    if (Trigger.isAfter ){
        if( Trigger.isInsert || Trigger.isUpdate)
        {
            goldstatushandler.CheckifGold(Trigger.new);
        }
    }
}