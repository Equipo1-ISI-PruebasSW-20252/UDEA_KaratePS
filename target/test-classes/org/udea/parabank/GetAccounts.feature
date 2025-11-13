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
    And match response ==
    """
    [
      {
        "id": 12345,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": -2300.00
      },
      {
        "id": 12456,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 10.45
      },
      {
        "id": 12567,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 91.00
      },
      {
        "id": 12678,
        "customerId": #(customerId),
        "type": "SAVINGS",
        "balance": -100.00
      },
      {
        "id": 12789,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 100.00
      },
      {
        "id": 12900,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 250.00
      },
      {
        "id": 13011,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": -150.00
      },
      {
        "id": 13122,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 1100.00
      },
      {
        "id": 13233,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 100.00
      },
      {
        "id": 13344,
        "customerId": #(customerId),
        "type": "SAVINGS",
        "balance": 1231.10
      },
      {
        "id": 13566,
        "customerId": #(customerId),
        "type": "LOAN",
        "balance": 5.00
      },
      {
        "id": 13677,
        "customerId": #(customerId),
        "type": "LOAN",
        "balance": 10.00
      },
      {
        "id": 13899,
        "customerId": #(customerId),
        "type": "LOAN",
        "balance": 21.00
      },
      {
        "id": 14010,
        "customerId": #(customerId),
        "type": "LOAN",
        "balance": 21.00
      },
      {
        "id": 54321,
        "customerId": #(customerId),
        "type": "CHECKING",
        "balance": 1351.12
      }
    ]
    """

    Scenario: Failed Retrieve accounts for a customer
    Given def fakeCustomerId = 999990
    And path 'customers/' + fakeCustomerId + '/accounts'
    When method GET
    Then status 400
    And match response == "Could not find customer #" + fakeCustomerId