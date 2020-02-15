@isTest public class StoreTriggerSpec {
  @isTest static void testPreventExceedingMaxActiveStoresOnInsert() {
    Store__c store1 = new Store__c(Active__c=TRUE);
    insert store1;

    try {
      Store__c store2 = new Store__c(Active__c=TRUE);
      Test.startTest();
      insert store2;
      Test.stopTest();
      throw new ValidationException('Inserting an Active store2 should have failed but did not');
    } catch(Exception e) {
      Boolean expectedExceptionThrown = e.getMessage().contains('You have reached your active store limit') ? true : false;
      System.AssertEquals(expectedExceptionThrown, true);
    }
    System.assertEquals(FeatureManagement.checkPackageIntegerValue('CurrentActiveStores'),
                        1, 'Current active stores should stay at 1');
  }

  @isTest static void testPreventExceedingMaxActiveStoresOnUpdate() {
    Store__c store1 = new Store__c(Active__c=TRUE);
    insert store1;
    Store__c store2 = new Store__c(Active__c=FALSE);
    insert store2;

    try {
      store2.Active__c = TRUE;
      Test.startTest();
      update store2;
      Test.stopTest();
      throw new ValidationException('Updating store2 to Active should have failed but did not');
    } catch(Exception e) {
      Boolean expectedExceptionThrown = e.getMessage().contains('You have reached your active store limit') ? true : false;
      System.AssertEquals(expectedExceptionThrown, true);
    }
    System.assertEquals(FeatureManagement.checkPackageIntegerValue('CurrentActiveStores'),
                        1, 'Current active stores should stay at 1');
  }

  @isTest static void testUpdatesCurrentActiveStoresOnInsert() {
    Store__c store1 = new Store__c(Active__c=TRUE);

    Test.startTest();
    insert store1;
    Test.stopTest();
    System.assertEquals(FeatureManagement.checkPackageIntegerValue('CurrentActiveStores'),
                        1, 'Current active stores should increment to 1');
  }

  @isTest static void testUpdatesCurrentActiveStoresOnUpdate() {
    Store__c store1 = new Store__c(Active__c=TRUE);
    insert store1;

    store1.Active__c = FALSE;
    Test.startTest();
    update store1;
    Test.stopTest();
    System.assertEquals(FeatureManagement.checkPackageIntegerValue('CurrentActiveStores'),
                        0, 'Current active stores be 0');
  }

  @isTest static void testUpdatesCurrentActiveStoresOnDelete() {
    Store__c store1 = new Store__c(Active__c=TRUE);
    insert store1;

    Test.startTest();
    delete store1;
    Test.stopTest();
    System.assertEquals(FeatureManagement.checkPackageIntegerValue('CurrentActiveStores'),
                        0, 'Current active stores be 0');
  }
}
