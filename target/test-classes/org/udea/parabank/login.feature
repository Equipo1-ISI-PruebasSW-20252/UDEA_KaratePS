@parabank_login
Feature: Login to Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Customer Login
    Given path 'login'
    And path 'john' //userName
    And path 'demo' //password
    When method GET
    Then status 200
    And match response ==
    """
    {
       "id": '#number',
       "firstName": '#string',
       "lastName": '#string',
       "address": {
            "street": '#string',
            "city": '#string',
            "state": '#string',
            "zipCode": '#string'
        },
       "phoneNumber": '#string',
       "ssn": '#string'
    }
    """

    Scenario: Failed Customer Login
      Given def fakeUserName = 'invalidUser'
      And def fakePassword = 'invalidPass'
      And path 'login'
      And path fakeUserName
      And path fakePassword
      When method GET
      Then status 400
      And match response == "Invalid username and/or password"