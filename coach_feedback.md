This was a good attempt at the challenge! Here’s my detailed feedback:

Documentation
- [x] Nice README. It’s good to see details of your reasoning, design and concerns. The usage screenshot was also useful.
- [x] It would be good to detail what edge cases you handled since they were not part of the original problem statement.
- [x] In particular, explain why you decided to not allow overdrafts since you’re making an assumption here. The other edge cases are more easily justified and show good attention to detail! :)
  -  updated added explaination on edge cases and not allowing overdrafts

Object-oriented design
- [x] I like that you moved your input-checking and error management code out into its own module
- [x] It also makes sense to me that you have a dedicated class that acts as the user interface for the user.
- [x] Your formatting module is also nice, I wonder whether, since you have it, you could move more stuff in there, for example date formatting?
  - moved date formatting from record into the module
- [x] Nice use of dependency injection in your Account class initialize method!  I like that you’ve used encapsulated transaction data in its own class.
- [x] Having a Record class that knows how to format itself is a neat solution.  The trade-off with that solution though is that you’ve mixed the concerns of storing transaction data and formatting it. If in the future you needed to be able to format a statement in two different ways, you’d have to have two different Record classes and store your transaction data twice.
  - taken on board have moved this method into BankTerminal class
- [ ] Another drawback is that your BankTerminal class also does some statement formatting at the moment inside display_statement, so your Record and BankTerminal classes are actually quite tightly coupled. How could you separate the concern of formatting/printing statement more neatly from the concerns of performing deposits/withdrawals and the concern of keeping track of transaction data?
- [x] Is there a reason why your Account.deposit and Account.withdraw methods need a type argument? Would you ever pass in anything other than "deposit" into the deposit method? Removing this argument would remove a potential source of invalid user inputs.
  - this was implemented to save on lines in the code, but have changed it back, as the potential for error's make sense.

- [ ] Ideally, the user wouldn’t be required to or even be able to specify the date of transaction - what if they doctored it?  Again, removing set_date removes another potential source of invalid user inputs. You should be able to automatically determine the date that a transaction should have at the point where the user calls withdraw or deposit. In tests, you can stub methods onn the Date class to control the date when needed.
- [ ] You shouldn’t need to store the balance separately in an instance variable. It duplicates state since you’re already storing balances in each transaction. Duplicating state can easily lead to bugs creeping in where the different values go out of sync.
- [ ] You’ve used error codes and strings to flag when something goes wrong. That works but is more cumbersome and hard to follow than using exceptions, which is the more common approach to reacting to invalid states/inputs. Exceptions automatically interrupt execution and can be caught if you want to perform specific actions in response to an exception: https://rollbar.com/guides/ruby-raising-exceptions/, https://www.rubyguides.com/2019/06/ruby-rescue-exceptions/.

Testing
- [ ] Good use of mocks in your tests :)
- [ ] You’ve got a very thorough set of test cases too
- [ ] Nice feature tests! I like that you used the acceptance criteria as a test case, it helps demonstrate that you’ve met them.
- [ ] Minor: you’ve got some very long lines in your tests. This stackoverflow has
some approaches to breaking them up: https://stackoverflow.com/questions/10522414/breaking-up-long-strings-on-multiple-lines-in-ruby-without-stripping-newlines
Once you’ve revisited these points please resubmit. And let me know if you have any questions about any of the above
