import ballerina/test;
import ballerina/io;

@test:Config{}
function simpleTestCase() {
    io:println("This is a test-message");
}