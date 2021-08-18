## Keywords

- **storage** - where all the contract state variables reside (on the blockchain). Every contract has its own storage and it is persistent between function calls and quite expensive to use
- **memory** - used to hold temporary values. It is erased between (external) function calls and is cheaper to use
- **stack** - used to hold small local variables



## Modifiers

- **pure** - reads from storage, but doesn't write anything into storage
- **view** -  doesn't read or write storage


        Using pure and view functions allows these functions to consume zero gas, because they are not modifying state. Calling these functions with something like web3.js will result in these pure/view functions being executed by your own node, while executing a normal function that writes into storage will require a miner to execute this function, consuming gas.

---

- **public** - all can access
- **external** - Cannot be accessed internally, only externally
- **internal** - only this contract and contracts deriving from it can access
- **private** - can be accessed only from this contract