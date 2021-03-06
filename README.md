
*Check out the [in-progress front-end!](https://github.com/ps2-controller/Antidosis-front-end)*

*Check out the [CLI demo!](https://github.com/ps2-controller/Antidosis/blob/master/documents/cli-demo.md)*

# Overview

Antidosis is a [Harberger tax](https://medium.com/@simondlr/what-is-harberger-tax-where-does-the-blockchain-fit-in-1329046922c6) implementation on Ethereum that applies Harberger taxes in a non-traditional way that aims to preserve the incentive structure of traditional Harberger taxes. 

Normally, Harberger taxes are applied to nonfungible assets, targeting efficient distribution of taxed property given individual variances in valuation of nonfungible assets. 

Antidosis varies from this pattern in that rather than directly Harberger-taxing the nonfungible asset, it is broken into discrete, *fungible* shares which are ([loosely](https://medium.com/hummingbot/the-myth-of-the-erc-20-token-standard-ab0d76cf8532)) compliant with the ERC-20 standard. Share owners are expected to have diminishing returns in their valuation of each additional share, which enables a market in which valuations are determined under a Harberger scheme. Shares can be nonconsensually purchased from owners at their self-assessed valuation.

## Improvements on traditional tokenization

Traditionally, tokenization structures that break an asset into shares have poor redeemability frameworks. The total supply of shares should be redeemable for the underlying asset, so the value of the sum of all shares should equal the market value of the underlying asset. However, if this is enforced on-chain, and one owner accidentally burns or loses even a single share, the underlying asset would no longer be redeemable, and all other owners' shares would become instantly worthless. 

Workarounds for this issue tend to be some variant of the "controller" approach, in which a centralized entity is able to deterministically roll back or manipulate token ownership. This approach redistributes jurisdictional authority from the Ethereum settlement layer to a third party, vastly reducing the ownership guarantees of a blockchain. In this case, the use of a blockchain has some minor transparency benefits, but in terms of settlement offers several disadvantages in comparison with a traditional database. 

Antidosis solves this issue by removing the need for controller requirements to preserve share value. If a token-owner loses their private key, one of the two following possibilities guarantees redeemability of the underlying asset's value:

- Their escrowed funds run out, and they are no longer able to pay taxes; this opens the market for anyone to declare a nonzero valuation and claim ownership of the tokens.
- Another owner purchases the tokens from the burned address at the declared valuation. No action from the burned address is required.

This ensures that the underlying asset always remains redeemable at market rate while preserving settlement for share ownership at the blockchain layer. 




