    @parabank_get_accounts
Feature: Get user accounts from Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def customerId = 12212

  Scenario: Retrieve accounts for a customer
    Given path 'customers/' + customerId + '/accounts'
    When method GET
    Then status 200
    And match each response ==
    """
    {
      id: '#number',
      customerId: '#number',
      type: '#string',
      balance: '#number'
    }
    """

    Scenario: Failed Retrieve accounts for a customer
    Given def fakeCustomerId = 999990
    And path 'customers/' + fakeCustomerId + '/accounts'
    When method GET
    Then status 400
    And match response == "Could not find customer #" + fakeCustomerId