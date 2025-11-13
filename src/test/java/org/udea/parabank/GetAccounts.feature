    @parabank_get_accounts
Feature: Get user accounts from Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def customerId = 13322

  Scenario: Retrieve accounts for a customer
    Given path 'customers/' + customerId + '/accounts'
    When method GET
    Then status 200
    And match response ==
    """
    [
      {
        "id": 14676,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 9729.50
      },
      {
        "id": 14787,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": -471.00
      },
      {
        "id": 14898,
        "customerId": #(customerId),
        "type": "SAVINGS",
        "balance": 486.00
      },
      {
        "id": 16008,
        "customerId": #(customerId),
        "type": "LOAN",
        "balance": -50.00
      },
      {
        "id": 16119,
        "customerId": #(customerId),
        "type": "LOAN",
        "balance": 150.00
      },
      {
        "id": 16230,
        "customerId": #(customerId),
        "type": "LOAN",
        "balance": 1000.00
      }
    ]
    """

    Scenario: Failed Retrieve accounts for a customer
    Given def fakeCustomerId = 999990
    And path 'customers/' + fakeCustomerId + '/accounts'
    When method GET
    Then status 400
    And match response == "Could not find customer #" + fakeCustomerId