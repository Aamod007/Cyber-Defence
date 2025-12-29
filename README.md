# 🛡️ Real-Time Attack Detection System (IDS)

A comprehensive ML-powered Intrusion Detection System with real-time attack simulation, Zeek PCAP analysis, MITRE ATT&CK mapping, and explainability features. Built with Python, aiohttp, scikit-learn, and modern web technologies.

**Live Demo:** https://ids-attack-detection.onrender.com (when deployed)

---

## 📋 Table of Contents

1. [Features](#features)
2. [Quick Start](#quick-start)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Architecture](#architecture)
6. [Model Details](#model-details)
7. [Deployment](#deployment)
8. [Commands Reference](#commands-reference)
9. [Technical Details](#technical-details)
10. [Troubleshooting](#troubleshooting)

---

## ✨ Features

### Core Capabilities
- **🤖 ML-Based Detection** - Random Forest classifier trained on UNSW-NB15 dataset (97.15% accuracy)
- **🎯 Binary Classification** - Normal vs Attack with confidence scoring
- **📊 Real-time Dashboard** - Live network flow monitoring with attack alerts
- **🔍 MITRE ATT&CK Mapping** - Automatic technique/tactic classification for detected attacks
- **💡 Explainability (XAI)** - Detailed reasoning for each alert (top features, evidence, confidence factors)
- **🧪 Attack Simulation** - Inject realistic attack samples from UNSW-NB15 dataset
- **📁 PCAP Analysis** - Process PCAP files through Zeek for ML-based detection
- **📤 Export Capabilities** - Export alerts as JSON or CSV for analysis
- **🔐 Audit Logging** - Track all commands and system events

### UI Features
- **Terminal Windows** - Draggable, resizable terminal windows with VM simulation
- **Real-time Updates** - WebSocket-based live data streaming
- **Attack Visualization** - Attacker/victim VM windows showing command streams
- **Statistics Dashboard** - Rolling metrics (flows/sec, packets/sec, bytes/sec)
- **Command Interface** - Full terminal-like command execution
- **Responsive Design** - Works on desktop and tablet

---

## 🚀 Quick Start

### Prerequisites
- **Python 3.9+**
- **pip** (Python package manager)
- **Git** (for cloning)
- **Optional:** Zeek (for PCAP analysis on Linux/WSL)

### 1. Clone Repository

```bash
git clone https://github.com/Aamod007/Cyber-Defence.git
cd Cyber-Defence/IDS-main
```

### 2. Create Virtual Environment

```bash
# Windows
python -m venv .venv
.venv\Scripts\activate

# Linux/Mac
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install Dependencies

```bash
pip install -r backend/requirements.txt
```

### 4. Run the Server

```bash
# Start backend server
python -m backend.server

# Server will start at http://127.0.0.1:8765
```

### 5. Open in Browser

```
http://127.0.0.1:8765
```

---

## 📦 Installation

### Full Setup with Dataset

```bash
# Clone repo
git clone https://github.com/Aamod007/Cyber-Defence.git
cd Cyber-Defence/IDS-main

# Create virtual environment
python -m venv .venv
.venv\Scripts\activate

# Install dependencies
pip install -r backend/requirements.txt

# Verify model exists
ls model/attack_classifier.joblib

# Verify dataset exists
ls Dataset/UNSW-NB15_*.csv

# Start server
python -m backend.server
```

### Docker Setup

```bash
# Build Docker image
docker build -t ids-attack-detection .

# Run container
docker run -p 8765:8765 ids-attack-detection

# Access at http://localhost:8765
```

### Render Deployment

```bash
# Push to GitHub
git push origin main

# Go to https://render.com/dashboard
# Create new Web Service
# Connect GitHub repo
# Set environment variables (see DEPLOYMENT section)
# Deploy!
```

---

## 💻 Usage

### Starting the System

**Option 1: Direct Python**
```bash
python -m backend.server
```

**Option 2: Windows Batch File**
```bash
start_soc.bat
```

**Option 3: Docker**
```bash
docker run -p 8765:8765 ids-attack-detection
```

### Accessing the UI

1. Open browser to `http://127.0.0.1:8765`
2. Wait for WebSocket connection (shows "Connected" in terminal)
3. Use commands in the terminal window

### Example Workflow

```
# 1. Check available attacks
/attacks

# 2. Simulate a DoS attack
/attack dos

# 3. View statistics
/stats

# 4. Export alerts
/export json

# 5. Check system status
/status
```

---

## 🏗️ Architecture

### Directory Structure

```
IDS-main/
├── backend/                          # Python backend
│   ├── server.py                    # WebSocket server (aiohttp)
│   ├── simulator.py                 # Attack simulation engine
│   ├── pipeline.py                  # Zeek log processing + ML
│   ├── ml_inference.py              # Model wrapper & inference
│   ├── zeek_controller.py           # Zeek process management
│   ├── replay_controller.py         # tcpreplay management
│   ├── command_router.py            # Command dispatcher
│   ├── state.py                     # Application state
│   ├── config.py                    # Configuration management
│   ├── mitre.py                     # MITRE ATT&CK mappings
│   ├── explainability.py            # XAI feature extraction
│   ├── enrichment.py                # Behavior enrichment
│   ├── features.py                  # Temporal feature computation
│   ├── windowing.py                 # Sliding window implementation
│   ├── tailer.py                    # Zeek log tailing
│   ├── processes.py                 # Process management
│   ├── security.py                  # Input validation
│   ├── audit.py                     # Audit logging
│   ├── __init__.py
│   └── requirements.txt              # Python dependencies
├── model/
│   └── attack_classifier.joblib     # Trained Random Forest model
├── Dataset/
│   ├── UNSW-NB15_1.csv             # Training data (raw with IPs)
│   ├── UNSW-NB15_2.csv
│   ├── UNSW-NB15_3.csv
│   ├── UNSW-NB15_4.csv
│   ├── UNSW_NB15_training-set.csv  # Processed training set
│   └── UNSW_NB15_testing-set.csv   # Processed test set
├── PCAP/                            # PCAP files for analysis
│   └── *.pcap
├── zeek-live/                       # Zeek configuration
│   └── local.zeek
├── backend_logs/                    # Runtime logs
│   ├── commands.jsonl              # Command audit log
│   └── session_*.jsonl             # Session logs
├── detection_results/               # Export directory
│   └── export_*.json/csv
├── attack-detection-viz.html        # Frontend UI (single HTML file)
├── Procfile                         # Render deployment config
├── Dockerfile                       # Docker deployment config
├── render.yaml                      # Render service config
├── .renderignore                    # Render build optimization
├── .dockerignore                    # Docker build optimization
├── start_soc.bat                    # Windows launcher
├── setup_zeek_wsl.sh               # Zeek setup script
├── COMMAND_REFERENCE.md             # Command documentation
└── README.md                        # This file
```

### System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Frontend (HTML/JS)                        │
│  - Real-time dashboard                                      │
│  - Terminal windows                                         │
│  - Attack visualization                                     │
│  - WebSocket client                                         │
└────────────────────┬────────────────────────────────────────┘
                     │ WebSocket (ws://localhost:8765/ws)
                     │
┌────────────────────▼────────────────────────────────────────┐
│              Backend Server (aiohttp)                        │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Command Router                                       │   │
│  │ - /attack, /simulate, /zeek-pcap, /export, etc.    │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Attack Simulator                                     │   │
│  │ - Loads UNSW-NB15 dataset                           │   │
│  │ - Injects attack samples                            │   │
│  │ - Generates realistic payloads                      │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ ML Pipeline                                          │   │
│  │ - Feature extraction                                │   │
│  │ - Model inference                                   │   │
│  │ - Confidence scoring                                │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Zeek Controller                                      │   │
│  │ - PCAP processing                                   │   │
│  │ - Log tailing                                       │   │
│  │ - Process management                                │   │
│  └──────────────────────────────────────────────────────┘   │
└────────────────────┬────────────────────────────────────────┘
                     │
        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
    ┌────────┐  ┌────────┐  ┌──────────┐
    │ Model  │  │Dataset │  │Zeek Logs │
    │ (RF)   │  │(UNSW)  │  │(conn.log)│
    └────────┘  └────────┘  └──────────┘
```

---

## 🤖 Model Details

### Model Specifications

| Property | Value |
|----------|-------|
| **Algorithm** | Random Forest Classifier |
| **Dataset** | UNSW-NB15 (82,332 samples) |
| **Classes** | 2 (Normal, Attack) |
| **Features** | 39 network features |
| **Accuracy** | 97.15% |
| **Precision (Attack)** | 98.51% |
| **Recall (Attack)** | 96.27% |
| **F1-Score (Attack)** | 97.37% |
| **n_estimators** | 300 |
| **max_depth** | 20 |
| **min_samples_split** | 5 |
| **Class Weights** | Balanced |
| **File Size** | ~50 MB |
| **Format** | joblib (scikit-learn) |

### Feature Set (39 Features)

**Flow Duration & Timing:**
- `dur` - Connection duration (seconds)
- `sttl` - Source TTL
- `dttl` - Destination TTL
- `tcprtt` - TCP round-trip time
- `synack` - SYN-ACK time
- `ackdat` - ACK data time

**Packet Statistics:**
- `spkts` - Source packets
- `dpkts` - Destination packets
- `sbytes` - Source bytes
- `dbytes` - Destination bytes
- `sloss` - Source packet loss
- `dloss` - Destination packet loss

**Rate Metrics:**
- `sload` - Source load (bytes/sec)
- `dload` - Destination load (bytes/sec)
- `sinpkt` - Source inter-packet time
- `dinpkt` - Destination inter-packet time
- `sjit` - Source jitter
- `djit` - Destination jitter

**Protocol & State:**
- `proto` - Protocol (tcp, udp, icmp)
- `service` - Service type (http, ftp, ssh, etc.)
- `state` - Connection state (SF, S0, REJ, etc.)

**Window Statistics:**
- `swin` - Source window size
- `dwin` - Destination window size
- `stcpb` - Source TCP base sequence
- `dtcpb` - Destination TCP base sequence
- `smean` - Source packet size mean
- `dmean` - Destination packet size mean

**Behavioral Features:**
- `trans_depth` - Transaction depth
- `response_body_len` - HTTP response body length
- `ct_srv_src` - Count of connections to same service from source
- `ct_state_ttl` - Count of connections with same state and TTL
- `ct_dst_ltm` - Count of connections to destination in last time window
- `ct_src_dport_ltm` - Count of connections from source to destination port
- `ct_dst_sport_ltm` - Count of connections to destination source port
- `ct_dst_src_ltm` - Count of connections to destination from source
- `is_ftp_login` - FTP login flag
- `ct_ftp_cmd` - FTP command count
- `ct_flw_http_mthd` - HTTP method count
- `ct_src_ltm` - Count of connections from source in time window
- `ct_srv_dst` - Count of connections to service from destination
- `is_sm_ips_ports` - Same IP and port flag

### Training Data

**UNSW-NB15 Dataset:**
- **Total Samples:** 82,332
- **Training Set:** 65,866 (80%)
- **Test Set:** 16,466 (20%)
- **Attack Categories:** 9 types
  - DoS/DDoS
  - Exploits
  - Fuzzers
  - Generic
  - Reconnaissance
  - Backdoor
  - Shellcode
  - Worms
  - Analysis

---

## 🚢 Deployment

### Local Deployment

```bash
# 1. Clone and setup
git clone https://github.com/Aamod007/Cyber-Defence.git
cd Cyber-Defence/IDS-main

# 2. Create virtual environment
python -m venv .venv
.venv\Scripts\activate

# 3. Install dependencies
pip install -r backend/requirements.txt

# 4. Run server
python -m backend.server

# 5. Open browser
# http://127.0.0.1:8765
```

### Docker Deployment

```bash
# Build image
docker build -t ids-attack-detection .

# Run container
docker run -p 8765:8765 \
  -e SOC_LISTEN_HOST=0.0.0.0 \
  -e SOC_LISTEN_PORT=8765 \
  ids-attack-detection

# Access at http://localhost:8765
```

### Render Deployment

**Step 1: Push to GitHub**
```bash
git push origin main
```

**Step 2: Create Render Service**
1. Go to https://render.com/dashboard
2. Click "New +" → "Web Service"
3. Connect GitHub repository
4. Configure:
   - **Build Command:** `pip install -r backend/requirements.txt`
   - **Start Command:** `python -m backend.server`

**Step 3: Set Environment Variables**
```
SOC_LISTEN_HOST=0.0.0.0
SOC_LISTEN_PORT=8765
SOC_ALERT_THRESHOLD=0.80
SOC_WINDOW_SECONDS=60
PYTHONUNBUFFERED=1
```

**Step 4: Deploy**
- Click "Create Web Service"
- Wait for deployment to complete
- Access at `https://your-service.onrender.com`

**Render Limitations:**
- ✅ ML inference works
- ✅ Dataset simulation works
- ✅ WebSocket works
- ❌ Zeek/tcpreplay not available
- ❌ No persistent storage (unless using Render Disk)

### Kubernetes Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ids-attack-detection
spec:
  replicas: 2
  selector:
    matchLabels:
      app: ids
  template:
    metadata:
      labels:
        app: ids
    spec:
      containers:
      - name: ids
        image: ids-attack-detection:latest
        ports:
        - containerPort: 8765
        env:
        - name: SOC_LISTEN_HOST
          value: "0.0.0.0"
        - name: SOC_LISTEN_PORT
          value: "8765"
        resources:
          requests:
            memory: "512Mi"
            cpu: "500m"
          limits:
            memory: "1Gi"
            cpu: "1000m"
```

---

## 📖 Commands Reference

### System Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/help` | Show all available commands | `/help` |
| `/status` | Display system status (Zeek, Replay, ML) | `/status` |
| `/stats` | Show rolling statistics (60s window) | `/stats` |
| `/clear` | Reset all counters and alerts | `/clear` |

### Attack Simulation

| Command | Description | Example |
|---------|-------------|---------|
| `/attacks` | List available attack types with MITRE mappings | `/attacks` |
| `/attack` | Simulate 10 random attacks from dataset | `/attack` |
| `/attack <type>` | Simulate specific attack type | `/attack dos` |
| `/simulate <n>` | Simulate N random attacks (1-100) | `/simulate 50` |

**Available Attack Types:**
- `dos` - Denial of Service
- `exploits` - Exploitation attacks
- `fuzzers` - Fuzzing attacks
- `reconnaissance` - Scanning/probing
- `backdoor` - Backdoor/C2
- `shellcode` - Shellcode injection
- `worms` - Worm propagation
- `analysis` - Traffic analysis
- `generic` - Generic attacks

### PCAP Analysis

| Command | Description | Example |
|---------|-------------|---------|
| `/zeek-pcap` | List available PCAP files | `/zeek-pcap` |
| `/zeek-pcap <file>` | Process PCAP with Zeek + ML | `/zeek-pcap capture.pcap` |

### Export & Analysis

| Command | Description | Example |
|---------|-------------|---------|
| `/export json` | Export alerts as JSON | `/export json` |
| `/export csv` | Export alerts as CSV | `/export csv` |

---

## 🔧 Technical Details

### WebSocket Protocol

**Connection:**
```javascript
ws = new WebSocket('ws://localhost:8765/ws');
```

**Message Format:**
```json
{
  "type": "command",
  "command": "/attack dos"
}
```

**Response Types:**
- `command_output` - Command execution output
- `flow` - Network flow event
- `attack_alert` - Attack detection alert
- `system_status` - System status update
- `stats_update` - Statistics update
- `vm_setup` - VM simulation setup
- `vm_stream` - VM command/packet stream

### Alert Structure

```json
{
  "type": "attack_alert",
  "timestamp": "2025-12-29T14:30:00.000000+00:00",
  "attack": "DoS",
  "confidence": 0.95,
  "src": "192.168.1.100",
  "dst": "10.0.0.1",
  "evidence": [
    "High packet rate (500 pps)",
    "Many destination ports (50 ports)"
  ],
  "ml": {
    "malicious_score": 0.95,
    "model_mode": "binary",
    "predicted_label": "Attack"
  },
  "mitre": {
    "technique_id": "T1498",
    "technique_name": "Network Denial of Service",
    "tactic_id": "TA0040",
    "tactic_name": "Impact"
  },
  "explainability": {
    "top_features": [
      "Very high packet rate (500 pps)",
      "High destination fan-out (50 unique IPs)"
    ],
    "zeek_evidence": [
      "proto=tcp",
      "state=S0",
      "duration=0.001s"
    ],
    "confidence_factors": [
      "High ML confidence",
      "Flood-like traffic pattern"
    ]
  }
}
```

### Configuration

**Environment Variables:**
```bash
SOC_LISTEN_HOST=0.0.0.0          # Server bind address
SOC_LISTEN_PORT=8765             # Server port
SOC_WS_PATH=/ws                  # WebSocket path
SOC_INTERFACE=eth0               # Network interface (for Zeek)
SOC_WINDOW_SECONDS=60            # Sliding window size
SOC_ALERT_THRESHOLD=0.80         # ML alert threshold
SOC_USE_SUDO=false               # Use sudo for Zeek
SOC_ZEEK_BIN=zeek                # Zeek binary path
SOC_TCPREPLAY_BIN=tcpreplay      # tcpreplay binary path
SOC_MODEL_PIPELINE=model/attack_classifier.joblib
```

---

## 🐛 Troubleshooting

### Server Won't Start

**Error:** `Address already in use`
```bash
# Kill process on port 8765
# Windows
netstat -ano | findstr :8765
taskkill /PID <PID> /F

# Linux
lsof -i :8765
kill -9 <PID>
```

**Error:** `ModuleNotFoundError: No module named 'backend'`
```bash
# Ensure you're in the correct directory
cd IDS-main

# Reinstall dependencies
pip install -r backend/requirements.txt
```

### WebSocket Connection Fails

**Issue:** "WebSocket connection failed"
```
1. Check server is running: http://127.0.0.1:8765/api/health
2. Check browser console for errors (F12)
3. Verify firewall allows port 8765
4. Try different browser
```

### Model Not Found

**Error:** `FileNotFoundError: model/attack_classifier.joblib`
```bash
# Verify model exists
ls model/attack_classifier.joblib

# If missing, download or train new model
python train_rf_binary.py
```

### Out of Memory

**Issue:** Process killed or slow performance
```bash
# Reduce simulation count
/simulate 5  # Instead of /simulate 100

# Clear old data
/clear

# Restart server
```

### Zeek Not Found

**Error:** `zeek: command not found`
```bash
# Install Zeek (Linux/WSL)
sudo apt update
sudo apt install zeek

# Or set custom path
export SOC_ZEEK_BIN=/opt/zeek/bin/zeek
```

---

## 📊 Performance Metrics

### Typical Performance

| Metric | Value |
|--------|-------|
| **Startup Time** | 2-3 seconds |
| **Model Inference** | 5-10 ms per sample |
| **WebSocket Latency** | <100 ms |
| **Memory Usage** | 200-500 MB |
| **CPU Usage** | 5-15% (idle) |
| **Concurrent Connections** | 100+ |
| **Alerts/Second** | 10-50 |

### Scaling Considerations

- **Single Instance:** Handles 100+ concurrent users
- **Load Balancing:** Use reverse proxy (nginx, HAProxy)
- **Database:** Add PostgreSQL for persistent storage
- **Caching:** Use Redis for session management
- **Monitoring:** Integrate Prometheus/Grafana

---

## 📝 License

MIT License - See LICENSE file for details

---

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

---

## 📧 Support

- **Issues:** GitHub Issues
- **Discussions:** GitHub Discussions
- **Email:** [Your Email]
- **Documentation:** See COMMAND_REFERENCE.md

---

## 🔗 Resources

- **UNSW-NB15 Dataset:** https://www.unsw.adfa.edu.au/unsw-canberra-cyber/cybersecurity/UNSW-NB15-Datasets/
- **MITRE ATT&CK:** https://attack.mitre.org/
- **Zeek Documentation:** https://docs.zeek.org/
- **scikit-learn:** https://scikit-learn.org/
- **aiohttp:** https://docs.aiohttp.org/

---

**Last Updated:** December 29, 2025
**Version:** 1.0.0
**Status:** Production Ready
