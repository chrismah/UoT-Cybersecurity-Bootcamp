# Blue Team: Summary of Operations

## Table of Contents
- Network Topology
- Description of Targets
- Monitoring the Targets
- Patterns of Traffic & Behavior
- Suggestions for Going Further

## Network Topology
![topology](images/network_topology.png)

The following machines were identified on the network:
- Kali
  - **Operating System**: Kali Linux 2020.1
  - **Purpose**: Attacker Machine
  - **IP Address**: 192.168.1.90
- ELK
  - **Operating System**: Ubuntu 18.04.4 LTS
  - **Purpose**: Monitoring System
  - **IP Address**: 192.168.1.100
- Capstone
  - **Operating System**: Ubuntu (18.04 LTS)
  - **Purpose**: Apache Web Server (Victim)
  - **IP Address**: 192.168.1.105
- Target 1
  - **Operating System**: Debian GNU/Linux 8
  - **Purpose**: Apache Web Server (Victim)
  - **IP Address**: 192.168.1.110
- Target 2
  - **Operating System**: Debian GNU/Linux 8
  - **Purpose**: Apache web Server (Victim)
  - **IP Address**: 192.168.1.115

## Description of Targets

The target of this attack was: `Target 1` (192.168.1.110).

Target 1 is an Apache web server and has SSH enabled, so ports 80 and 22 are possible ports of entry for attackers. As such, the following alerts have been implemented:

## Monitoring the Targets

Traffic to these services should be carefully monitored. To this end, we have implemented the alerts below:

### Excessive HTTP Errors

Excessive HTTP Errors is implemented as follows:
  - **Metric**: `WHEN count() GROUPED OVER top 5 'http.response.status_code' IS ABOVE 400 FOR THE LAST 5 minutes`
  - **Threshold**: Above 400
  - **Vulnerability Mitigated**: Enumeration / Brute Force Attack / DDOS
  - **Reliability**: High Reliability - normal traffic should not exceed this amount on a regular basis

### HTTP Request Size Monitor
HTTP Request Size Monitor is implemented as follows:
  - **Metric**: `WHEN sum() of http.request.bytes OVER all documents IS ABOVE 3500 FOR THE LAST 1 minute`
  - **Threshold**: Above 3500
  - **Vulnerability Mitigated**: HTTP Header Injection
  - **Reliability**: Low Reliability - false positives are possible since there can be legitimate larger requests

### CPU Usage Monitor
CPU Usage Monitor is implemented as follows:
  - **Metric**: `WHEN max() OF system.process.cpu.total.pct OVER all documents IS ABOVE 0.5 FOR THE LAST 5 minutes`
  - **Threshold**: Above 0.5
  - **Vulnerability Mitigated**: Malicious processes running on the machine (malware, spyware, viruses)
  - **Reliability**: High Reliability - the increased CPU activity over baseline should alert to potential problems



## Suggestions for Going Further
The logs and alerts generated during the assessment suggest that this network is susceptible to several active threats, identified by the alerts above. In addition to watching for occurrences of such threats, the network should be hardened against them. The Blue Team suggests that IT implement the fixes below to protect the network:
- Weak User Password (`michael`)
  - **Patch**: Increase complexity of user `michael`'s password
  - **Why It Works**: The initial attack vector was possible due to `michael`'s simple password which was easily brute forced.
- Weak user Password (`steven`)
  - **Patch**: Increase complexity of user `steven`'s password
  - **Why It Works**: Access to a user account with more privleges is what allowed escalation to root. If `steven`'s password wasn't available in common wordlists, this could have been avoided.
- Misconfiguration of user privileges leading to privilege escalation
  - **Patch**: Remove 
  - **Why It Works**: TODO: E.g., _`special-security-package` scans the system for viruses every day_


