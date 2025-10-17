 Hello-Clarity Smart Contract

A beginner-friendly **Clarity smart contract** built using **Clarinet** on the **Stacks blockchain**.  
This contract demonstrates how to store greetings, track message counts, and implement basic admin functionality.

---

 Overview

The **hello-clarity** contract allows users to:
- Send and record greetings
- View their own and others’ greetings
- Track the total number of greetings made on-chain
- Administer contract functions such as reset and admin transfer

It serves as an ideal starting point for learning how to build and deploy Clarity contracts using **Clarinet**.

---

 Features

| Function | Description |
|-----------|--------------|
| `say-hello` | Sends a simple hello message and increases the total greeting count |
| `send-greeting` | Allows a user to submit a custom message |
| `get-total-greetings` | Returns the total number of greetings |
| `get-greeting` | Fetches the latest greeting message from a specific user |
| `get-admin` | Displays the current admin of the contract |
| `reset-greetings` | Lets the admin reset the greeting count to zero |
| `transfer-admin` | Enables the admin to assign a new administrator |

---

 Contract Details

**Language:** Clarity  
**Tool:** Clarinet  
**Network:** Stacks Blockchain  
**Contract file:** `contracts/hello-clarity.clar`  

---

 How It Works

- Every user interaction increases the total greeting count.
- Messages are stored in a map keyed by the user’s principal.
- The admin (deployer) has special privileges to reset stats or transfer control.
- Event logs are generated using the `print` function for better traceability.

---

 Testing Locally with Clarinet

 1. Run Console
```bash
clarinet console
