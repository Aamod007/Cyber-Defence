---
title: IDS Attack Detection System
emoji: 🛡️
colorFrom: red
colorTo: black
sdk: docker
pinned: false
license: mit
app_port: 7860
---

# 🛡️ Real-Time Attack Detection System (IDS)

ML-powered Intrusion Detection System with real-time attack simulation, MITRE ATT&CK mapping, and explainability features.

## Features

- **ML-Based Detection** - Random Forest classifier (97.15% accuracy)
- **Attack Simulation** - UNSW-NB15 dataset samples
- **MITRE ATT&CK Mapping** - Automatic technique classification
- **Explainability (XAI)** - Detailed reasoning for alerts
- **Real-time Dashboard** - WebSocket-based live updates

## Usage

1. Wait for the app to load
2. Use terminal commands:
   - `/help` - Show all commands
   - `/attacks` - List attack types
   - `/attack dos` - Simulate DoS attack
   - `/simulate 10` - Simulate 10 random attacks
   - `/export json` - Export alerts

## Model

- **Algorithm**: Random Forest Binary Classifier
- **Dataset**: UNSW-NB15 (82K samples)
- **Accuracy**: 97.15%
- **Features**: 39 network features

## Links

- [GitHub Repository](https://github.com/Aamod007/Cyber-Defence)
- [UNSW-NB15 Dataset](https://www.unsw.adfa.edu.au/unsw-canberra-cyber/cybersecurity/UNSW-NB15-Datasets/)
