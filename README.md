# Fidelity

This project is a study case to learn Solidity, OpenZeppelin, Hardhat and other ethereum developer stuff.

## Documentation

Fidelity is an ERC-20 which gives you 1 token everyday for your "fidelity".

Can be usefull in a DAO for voting purpose since older members have more votes than newbie.

Contract owner of the Fidelity contract can add and remove address for his "fidels" with the timestamp of his first day.

This ERC-20 is kind of wierd because nobody can send those tokens, even the fidels or owner.

Example :
```typescript
  // Add a fidel since timestamp 1413874800
  fidelity.addFidel("0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", 1413874800);

  // Return 2612 tokens because 2612 days since timestamp 1413874800 
  fidelity.balanceOf("0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266");
```
