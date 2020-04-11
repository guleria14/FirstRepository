@isTest
public class TestVerifyDate {
    static testMethod void testName() {
    Date dateFirst = Date.newInstance(2019, 12, 14);
    Date dateSecond = Date.newInstance(2019, 12, 16);
        VerifyDate.CheckDates(dateFirst, dateSecond);
}
     static testMethod void testName1() {
    Date dateFirst = Date.newInstance(2019, 12, 14);
    Date dateSecond = Date.newInstance(2020, 12, 16);
        VerifyDate.CheckDates(dateFirst, dateSecond);
}

}