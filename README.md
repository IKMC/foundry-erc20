# Foundry ERC20 Token (`OurToken`)

[![Solidity Version](https://shields.io^0.8.18-blue.svg)](https://soliditylang.org)
[![Framework: Foundry](https://shields.io)](https://getfoundry.sh)
[![License: MIT](https://shields.io)](https://opensource.org)

A robust, blazing-fast implementation of an **ERC20 Token** utilizing audited **OpenZeppelin Contracts** and engineered using the **Foundry** smart contract development framework.

---

## 📌 Features & Architecture

This repository showcases advanced smart contract development and testing practices, featuring:
* 🛡️ **Secure Foundations**: Inherits directly from OpenZeppelin's audited `ERC20` contract matrix.
* 🧪 **Comprehensive Test Coverage**: Features custom scripts checking for token metadata strings, allowance allocation mechanics, and failure states for insolvent transfers.
* 🚀 **Deterministic Deployments**: Driven by custom Solidity scripts utilizing internal `vm.broadcast` routines.

```text
 ┌──────────────────────┐      ┌──────────────────────┐
 │  DeployOurToken.s.sol│ ───> │     OurToken.sol     │
 │  (Deployment Script) │      │ (ERC20 Token Core)   │
 └──────────────────────┘      └──────────────────────┘
            │                             │
            ▼                             ▼
 ┌────────────────────────────────────────────────────┐
 │                OurTokenTest.t.sol                  │
 │ (Unit testing, prank scenarios, allowance checks)  │
 └────────────────────────────────────────────────────┘
```

---

## 📂 Repository Blueprint

```text
├── .github/workflows/   # Automated CI/CD pipelines
├── .vscode/             # Tailored IDE snippet rules
├── lib/                 # External dependencies (forge-std, openzeppelin)
├── script/              # Solc automated deployment pipelines
│   └── DeployOurToken.s.sol
├── src/                 # Source smart contracts
│   └── OurToken.sol
├── test/                # Robust unit and integration testing suite
│   └── OurTokenTest.t.sol
├── Makefile             # Shorthand target automation commands
└── foundry.toml         # Framework compilation & network tuning profiles
```

---

## 🚀 Getting Started

### Prerequisites

You need Git and Foundry installed locally. If you do not have Foundry, launch:

```bash
curl -L https://bytes.dev | bash
foundryup
```

### Installation & Initialization

1. **Clone the repository:**
   ```bash
   git clone https://github.com
   cd foundry-erc20
   ```

2. **Synchronize Git Submodules & Dependencies:**
   ```bash
   forge install
   ```

---

## 🛠️ Usage Workflow

This project includes a `Makefile` to simplify repetitious commands. You can utilize direct `forge` syntaxes or their `make` equivalents below:

### Compilation
```bash
# Via Forge
forge build

# Via Makefile
make build
```

### Execution of Tests
```bash
# Run all tests normally
forge test

# Run tests with strict execution traces
forge test -vvvv
```

### Code Formatting
Ensure strict formatting alignment before shipping variations:
```bash
forge fmt
```

### Gas Diagnostics
Generate a resource consumption summary report:
```bash
forge snapshot
```

---

## 📜 Local Network & Scripting

1. Start up an isolated, instantly-mined deterministic EVM testing node:
   ```bash
   anvil
   ```

2. Deploy the token through your scripting pipeline to the local node:
   ```bash
   forge script script/DeployOurToken.s.sol:DeployOurToken --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
   ```

---

## 🛡️ License

Distributed under the **MIT License**. Check out the `LICENSE` file for more details.
