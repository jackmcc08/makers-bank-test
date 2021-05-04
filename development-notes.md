# Bank tech test - From README

## Specification

### Requirements

* You should be able to interact with your code via a REPL like IRB or the JavaScript console.  (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012  
**And** a deposit of 2000 on 13-01-2012  
**And** a withdrawal of 500 on 14-01-2012  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```

### User Stories - developed the following user stories based off the above Requirements.

As a client
In order to save money
I would like to be able to make a deposit into my account


As a client
In order to get money
I would like to be able to make a withdrawal from my account

As a client
In order to know how much money I have
I would like to be able to see my account balance

As a client
In order to remember what I have done with my account
I would like to be able to see my deposits and withdrawals to and from my account and on which date (date, amount, balance).

As a client
In order to save the pennys
I would like to be able to deposit and withdraw fractions of a pound

Other requirements:
- IRB interface
- Data stored in memory - no database
- need some form of date advancement
- Amounts are floats

### Domain Model

Developed basic domain model off the user stories above, and identified potential classes and methods.

https://docs.google.com/spreadsheets/d/1AjcWln0lPN11SqrGuDqgrx5RsbHTMIJ4ty3bb10P3Rg/edit?usp=sharing

### Edge Cases

No negative values on deposit or withdrawal
Empty parameters are caught on entry
Potentially something around dates

### Input/Ouput Table

MVP table

Balance || Account balance: £0.00
Deposit 1500 || You have deposited £1500.00.
Withdraw 500 || You have withdrawn £500.00.
Deposit 50.50 || You have deposited £50.50.
Balance || Account balance: £1050.50.


### Development Plan

Plan is to develop the app through TDD, working on the above user stories.
I will work to develop the MVP initially (deposit, withdraw, balance). And then proceed to add additional features through TDD.


#### Completed MVP
Added deposit, withdraw and see_balance methods to the Account class.

As part of MVP, added in error catching for the inputs and a lot of private methods to keep code DRY and SRP'd.

MVP included basic error messaging and basic user friendly confirmation of action messages.

Next step is to add records and dates

<!-- finish refactoring out the record class

refactor out a terminal class which does the displaying -->
