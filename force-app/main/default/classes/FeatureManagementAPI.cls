public without sharing class FeatureManagementAPI {
  // Called to update the CurrentActiveStores integer Feature param.
  // This param reports back to the LMO and provides information on how many
  // Store objects are active in the subscriber org.
  public @future static void updateCurrentActiveStores() {
    Integer activeStores = [SELECT COUNT() FROM Store__c WHERE Active__c = TRUE];
    FeatureManagement.setPackageIntegerValue('CurrentActiveStores', activeStores);
  }
}