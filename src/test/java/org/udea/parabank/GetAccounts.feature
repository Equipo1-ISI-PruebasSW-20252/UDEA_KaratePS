    @parabank_get_accounts
Feature: Get user accounts from Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def customerId = 13211

  Scenario: Retrieve accounts for a customer
    Given path 'customers/' + customerId + '/accounts'
    When method GET
    Then status 200
    And match response ==
    """
    [
      {
        "id": 14787,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 265.50
      },
      {
        "id": 14898,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 90.00
      },
      {
        "id": 15009,
        "customerId": #(customerId),
        "type": "SAVINGS",
        "balance": 100.00
      },
      {
        "id": 15120,
        "customerId": #(customerId),
        "type": "LOAN",
        "balance": 50.00
      },
      {
        "id": 15231,
        "customerId": #(customerId),
        "type": "LOAN",
        "balance": 250.00
      }
    ]
    """

    Scenario: Failed Retrieve accounts for a customer
    Given def fakeCustomerId = 999990
    And path 'customers/' + fakeCustomerId + '/accounts'
    When method GET
    Then status 400
    And match response == "Could not find customer #" + fakeCustomerId