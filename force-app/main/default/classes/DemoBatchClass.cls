public class DemoBatchClass implements Database.Batchable<sObject>, Schedulable{
    
    public Set<Id> accountIds;
    public DemoBatchClass() {
        
    }
    
    
    public DemoBatchClass(Set<Id> accountIds) {
        this.accountIds = accountIds;
    }
    
    public void execute(SchedulableContext ctx) {
        // awesome code here
        // 
        System.debug('SchedulableClass');
        
       
        
        Database.executeBatch(this, 10);
    }
    
    public List<Account> start(Database.BatchableContext bc) {
        System.debug('start: ' );
        // collect the batches ox`f records or objects to be passed to execute
        return [SELECT Id FROM Account];
    }
    public void execute(Database.BatchableContext bc, List<Account> records){
        // process each batch of records
        // 
        System.debug('records: ' + records);
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        // 
        System.debug('finish: ' );
    }
    public void runInNSeconds(Integer delayInSeconds) {
        DateTime jobDate = DateTime.now().addSeconds(delayInSeconds);
        String cron = jobDate.second() + ' ' + jobDate.minute() + ' ' + jobDate.hour() + ' ' + jobDate.day() + ' ' + jobDate.month() + ' ? ' + jobDate.year(); 
        String jobName = 'DemoBatchClass ' + jobDate; 
        
        System.schedule(jobName, cron, this); 
    }
}