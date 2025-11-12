    @parabank_get_accounts
Feature: Get user accounts from Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def customerId = 20204

  Scenario: Retrieve accounts for a customer
    Given path 'customers/' + customerId + '/accounts'
    When method GET
    Then status 200
    And match response ==
    """
    [
      {
          "id": 24999,
          "customerId": #(customerId),
          "type": "CHECKING",
          "balance": 137.50
      },
      {
          "id": 25110,
          "customerId": #(customerId),
          "type": "CHECKING",
          "balance": 378.00
      },
      {
          "id": 25221,
          "customerId": #(customerId),
          "type": "SAVINGS",
          "balance": 100.00
      }
    ]
    """

    Scenario: Failed Retrieve accounts for a customer
    Given def fakeCustomerId = 999990
    And path 'customers/' + fakeCustomerId + '/accounts'
    When method GET
    Then status 400
    And match response == "Could not find customer #" + fakeCustomerId