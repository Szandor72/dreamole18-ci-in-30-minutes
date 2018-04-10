@isTest
private class AppConfigMainTest {
    @istest
    private static void testConfigurationVariables() {
        system.assertNotEquals(null, AppConfigMain.isActive, 'isActive must not be null');
    }
}
