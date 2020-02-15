# 2GP Feature Management Error Test Case

This is a minimal test case to reproduce a support ticket (25631820) we have with Salesforce.

## Setup

To reproduce this error, do the following:

```
$ git clone git@github.com:reinteractive/sfdxFeatureManagement.git
$ cd sfdxFeatureManagement
$ sfdx force:auth:web:login -a DevHub
$ sfdx force:org:create -s -f config/project-scratch-def.json -a FeatureManagement -v DevHub
$ sfdx force:source:push -u FeatureManagement
$ sfdx force:apex:test:run -r human -c -w 10 -u FeatureManagement
```

## Error Message

The error produced is:

```
=== Apex Code Coverage
ID                  NAME                  % COVERED  UNCOVERED LINES
──────────────────  ────────────────────  ─────────  ───────────────
01p6D0000022i7CQAQ  FeatureManagementAPI  100%
01q6D000000GmVQQA0  StoreTrigger          90%        16
01p6D0000022iBPQAY  ValidationException   NaN%

=== Test Results
TEST NAME                                                     OUTCOME  MESSAGE                                                                                                                                                                                  RUNTIME (MS)
────────────────────────────────────────────────────────────  ───────  ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────  ────────────
FeatureManagementAPISpec.testUpdateCurrentActiveStores        Pass                                                                                                                                                                                              238
StoreTriggerSpec.testPreventExceedingMaxActiveStoresOnInsert  Fail     System.AssertException: Assertion Failed: Expected: false, Actual: true                                                                                                                  482
                                                                       Class.StoreTriggerSpec.testPreventExceedingMaxActiveStoresOnInsert: line 15, column 1
StoreTriggerSpec.testPreventExceedingMaxActiveStoresOnUpdate  Fail     System.UnexpectedException: Unable to retrieve value UNKNOWN_EXCEPTION: An unexpected error occurred. Please include this ErrorId if you contact support: 1946099299-205634 (933859291)  129
                                                                       Class.System.FeatureManagement.setPackageIntegerValue: line 39, column 1
                                                                       Class.FeatureManagementAPI.updateCurrentActiveStores: line 7, column 1
StoreTriggerSpec.testUpdatesCurrentActiveStoresOnDelete       Fail     System.UnexpectedException: Unable to retrieve value UNKNOWN_EXCEPTION: An unexpected error occurred. Please include this ErrorId if you contact support: 1946099299-205636 (933859291)  960
                                                                       Class.System.FeatureManagement.setPackageIntegerValue: line 39, column 1
                                                                       Class.FeatureManagementAPI.updateCurrentActiveStores: line 7, column 1
StoreTriggerSpec.testUpdatesCurrentActiveStoresOnInsert       Fail     System.UnexpectedException: Unable to retrieve value UNKNOWN_EXCEPTION: An unexpected error occurred. Please include this ErrorId if you contact support: 1946099299-205638 (933859291)  68
                                                                       Class.System.FeatureManagement.setPackageIntegerValue: line 39, column 1
                                                                       Class.FeatureManagementAPI.updateCurrentActiveStores: line 7, column 1
StoreTriggerSpec.testUpdatesCurrentActiveStoresOnUpdate       Fail     System.UnexpectedException: Unable to retrieve value UNKNOWN_EXCEPTION: An unexpected error occurred. Please include this ErrorId if you contact support: 1946099299-205640 (933859291)  87
                                                                       Class.System.FeatureManagement.setPackageIntegerValue: line 39, column 1
                                                                       Class.FeatureManagementAPI.updateCurrentActiveStores: line 7, column 1

=== Failures
FULLNAME                                                      MESSAGE
────────────────────────────────────────────────────────────  ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
StoreTriggerSpec.testPreventExceedingMaxActiveStoresOnInsert  System.AssertException: Assertion Failed: Expected: false, Actual: true
                                                              /Users/mikel/Code/sfdxFeatureManagement/force-app/test/default/triggers/StoreTriggerSpec.cls:15:1
StoreTriggerSpec.testPreventExceedingMaxActiveStoresOnUpdate  System.UnexpectedException: Unable to retrieve value UNKNOWN_EXCEPTION: An unexpected error occurred. Please include this ErrorId if you contact support: 1946099299-205634 (933859291)
                                                              /Users/mikel/Code/sfdxFeatureManagement/force-app/main/default/classes/FeatureManagementAPI.cls:7:1
StoreTriggerSpec.testUpdatesCurrentActiveStoresOnDelete       System.UnexpectedException: Unable to retrieve value UNKNOWN_EXCEPTION: An unexpected error occurred. Please include this ErrorId if you contact support: 1946099299-205636 (933859291)
                                                              /Users/mikel/Code/sfdxFeatureManagement/force-app/main/default/classes/FeatureManagementAPI.cls:7:1
StoreTriggerSpec.testUpdatesCurrentActiveStoresOnInsert       System.UnexpectedException: Unable to retrieve value UNKNOWN_EXCEPTION: An unexpected error occurred. Please include this ErrorId if you contact support: 1946099299-205638 (933859291)
                                                              /Users/mikel/Code/sfdxFeatureManagement/force-app/main/default/classes/FeatureManagementAPI.cls:7:1
StoreTriggerSpec.testUpdatesCurrentActiveStoresOnUpdate       System.UnexpectedException: Unable to retrieve value UNKNOWN_EXCEPTION: An unexpected error occurred. Please include this ErrorId if you contact support: 1946099299-205640 (933859291)
                                                              /Users/mikel/Code/sfdxFeatureManagement/force-app/main/default/classes/FeatureManagementAPI.cls:7:1
```