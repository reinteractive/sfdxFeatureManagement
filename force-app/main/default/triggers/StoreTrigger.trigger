trigger StoreTrigger on Store__c (before insert, before update,
                                  after insert, after update, after delete, after undelete) {

  if (Trigger.IsBefore) {
    // trigger to update the CurrentActiveStores integer FeatureParameter
    // each time a Store object is activated.
    Integer usedLicences = 0;
    Integer maxLicences = FeatureManagement.checkPackageIntegerValue('MaxActiveStores');

    for (Store__c store : Trigger.new) {
      if (store.Active__c == TRUE) {
        usedLicences = usedLicences + 1;
      }

      if (usedLicences > maxLicences) {
        store.addError('You have reached your active store limit, please contact storeConnect sales for an additional licence.');
      }
    }
  }

  if (Trigger.IsAfter) {
    FeatureManagementAPI.updateCurrentActiveStores();
  }
}
