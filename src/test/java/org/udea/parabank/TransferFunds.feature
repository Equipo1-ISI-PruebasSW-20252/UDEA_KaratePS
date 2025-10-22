@parabank_transfer
Feature: Transfer funds in Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def val_fromAccountId = '15786'
    * def val_toAccountId = '15897'
    * def fakerObj = new faker()
    * def val_amount = fakerObj.number().numberBetween(1, 200)

    Scenario: Successful Transfer
        Given path 'transfer'
        And param fromAccountId = val_fromAccountId
        And param toAccountId = val_toAccountId
        And param amount = val_amount
        When method post
        Then status 200
        And match response == "Successfully transferred $" + val_amount + " from account #" + val_fromAccountId + " to account #" + val_toAccountId
