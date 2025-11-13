@parabank_billpay_fail
Feature: Bill Payment Failed due to insufficient funds
    Background:
        * url baseUrl
        * header Accept = 'application/json'
        * def customerId = 13211
        * def fakerObj = new faker()

    Scenario: Paying a bill with an amount greater than the balance
        # Obtener cuentas del cliente para conocer el saldo de una cuenta
        Given path 'customers/' + customerId + '/accounts'
        When method GET
        Then status 200
        # seleccionar la primera cuenta (ejemplo) y tomar su balance
        * def fromAccount = response[1]
        * def fromAccountId = fromAccount.id
        * def balance = fromAccount.balance

        # Construir un monto mayor que el saldo disponible
        * def extra = fakerObj.number().numberBetween(1, 500)
        * def billAmount = balance + extra

        # Intentar pagar la factura haciendo POST a /services/bank/billpay
        Given path 'billpay'
        And param accountId = fromAccountId
        And param amount = billAmount
        And request
        """
        {
            "name": "Brent Welch",
            "address": {
                "street": "Dicki Forge",
                "city": "Erdmanshire",
                "state": "French Polynesia",
                "zipCode": "VA"
            },
            "phoneNumber": "834-333-8163",
            "accountNumber": #(fromAccountId)
        }
        """
        When method post
        Then status 400
        And match response == "Insufficient funds in account #" + fromAccountId + " to pay bill amount of $" + billAmount