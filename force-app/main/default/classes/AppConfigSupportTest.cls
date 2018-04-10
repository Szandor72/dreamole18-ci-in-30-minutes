@isTest
private class AppConfigSupportTest {
    @istest
    private static void testConfigurationVariables() {
        system.assertNotEquals(null, AppConfigSupport.enableLogging, 'enableLogging must not be null');
    }
}

