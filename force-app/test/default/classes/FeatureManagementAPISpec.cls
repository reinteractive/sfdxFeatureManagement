@isTest
public class FeatureManagementAPISpec {
    @isTest static void testUpdateCurrentActiveStores() {
      Store__c store1 = new Store__c(Name='Store', Active__c=TRUE);
      insert store1;
      Store__c store2 = new Store__c(Name='Store', Active__c=TRUE);
      insert store2;

      Test.startTest();
      FeatureManagementAPI.updateCurrentActiveStores();
      Test.stopTest();

      System.assertEquals(2,
                          FeatureManagement.checkPackageIntegerValue('CurrentActiveStores'),
                          'Stores should be 2');

    }
}