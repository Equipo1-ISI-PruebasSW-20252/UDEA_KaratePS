@parabank_loan_simulation
Feature: Loan simulation in Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def fakerObj = new faker()
    * def amount = fakerObj.number().numberBetween(1, 5000)
    * def amountRejected = -amount
    * def fromAccountId = '14676'
    * def loanDuration = 12

  Scenario: Loan approval
    Given path 'requestLoan'
    And param amount = amount
    And param fromAccountId = fromAccountId
    And param loanDuration = loanDuration
    When method POST
    Then status 200
    And match response == 
    """
    {
      "responseDate": '#number',
      "loanProviderName": '#string',
      "approved": true,
      "accountId": '#number',
      "history": [
        {
          "date": '#string',
          "amount": #(amount),
          "type": "LOAN_DISBURSEMENT",
          "description": "Loan disbursement for loan of amount $" + #(amount)
        }
      ],
      "incomes": '#number'
    }
    """

  Scenario: Loan rejection
    Given path 'requestLoan'
    And param amount = amountRejected
    And param fromAccountId = fromAccountId
    And param loanDuration = loanDuration
    When method POST
    Then status 200
    And match response == 
    """
    {
      "responseDate": '#number',
      "loanProviderName": '#string',
      "approved": false,
      "accountId": '#number',
      "history": [
        {
          "date": '#string',
          "amount": #(amount),
          "type": "LOAN_DISBURSEMENT",
          "description": "Loan disbursement for loan of amount $" + #(amount)
        }
      ],
      "incomes": '#number'
    }
    """