@isTest
private with sharing class DebugEntryServiceTest {
    
    @isTest
    private static void validateSuccess() {
        List<String> traceInfo = new List<String>{'3','2','1','3','2','1'};
        System.AssertEquals(true, DebugEntryService.isValid(traceInfo), 'Not enough info to be valid');
    }

    @isTest
    private static void validate_Error_NotEnoughInfo() {
        List<String> traceInfo = new List<String>{'3','2','1'};
        System.AssertEquals(false, DebugEntryService.isValid(traceInfo), 'Not enough info to be valid');
        System.AssertEquals(false, DebugEntryService.isValid(null), 'Null must fail validation');
    }
}
