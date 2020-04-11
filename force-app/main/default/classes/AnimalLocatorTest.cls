@isTest
private class AnimalLocatorTest {
    @isTest static void AnimalLocatorMock() {
        System.Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String actual = AnimalLocator.getAnimalNameById(1);
        String expected = 'chicken';
        System.assertEquals(actual, expected);
    }
}