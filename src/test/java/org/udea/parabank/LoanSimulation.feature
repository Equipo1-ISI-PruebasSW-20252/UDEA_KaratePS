@parabank_loan_simulation
Feature: Loan simulation in Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def amount = fakerObj.number().numberBetween(1, 5000)
    * def fromAccountId = '12345'
    * def loanDuration = 12
    * def customerIncome = 45000
    * def customerLowIncome = 1000
    * def customerCreditHistory = 'GOOD'

  Scenario: Loan approval
    Given path 'requestLoan'
    And request 
    """
    {
      "amount": #(amount),
      "fromAccountId": #(fromAccountId),
      "duration": #(loanDuration),
      "income": #(customerIncome),
      "creditHistory": #(customerCreditHistory)
    }
    """

    When method POST
    Then status 200
    And match response == 
    """
    {
      "responseDate": '#number',
      "loanProviderName": '#string',
      "approved": true,
      "accountId": '#number'
    }
    """

  Scenario: Loan rejection
    Given path 'requestLoan'
    And request 
    """
    {
      "amount": #(amount),
      "fromAccountId": #(fromAccountId),
      "duration": #(loanDuration),
      "income": #(customerLowIncome), // Low income for rejection
      "creditHistory": 'POOR' // Poor credit history for rejection
    }
    """

    When method POST
    Then status 200
    And match response == 
    """
    {
      "responseDate": '#number',
      "loanProviderName": '#string',
      "approved": false,
      "accountId": '#null'
    }
    """