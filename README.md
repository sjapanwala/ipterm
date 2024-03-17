# **💻 NetWise** 
## Table of Contents
- [Description](#what-is-netwise)
- [Installation](#installation)
- [Usage/Help](#usage--commands)



## What is NetWise?
####  NetWise, is a robust terminal application tailored for networking and system management tasks. Upon execution, it initializes the terminal environment by configuring variables for version, theme, and shell preferences, while also gathering pertinent system details such as vendor information, operating system, and CPU specifications. Notably, NetWise boasts a comprehensive suite of IP-centric functionalities, empowering users to designate target IPs, retrieve and display detailed IP information, and manage various IP types seamlessly. It incorporates user management features, facilitating effortless user profile switching and permissions adjustments. NetWise seamlessly handles command-line interactions, executing user-input commands promptly and effectively. From network diagnostics to IP address generation and network path tracing, NetWise offers an array of utilities with clear and concise documentation provided for user convenience. Additionally, it includes support for root user access, notification management, and streamlined file planting for enhanced functionality. As a versatile tool, NetWise excels in facilitating network troubleshooting and system administration tasks within a user-friendly command-line interface.

## Installation
### Install Using Github
- ✅ [GitHub ZIP](https://github.com/sjapanwala/netwise/archive/refs/heads/main.zip)
- ✅ [OpenSource GITHUB Script](https://github.com/sjapanwala/netwise/blob/main/netwise.cmd)
- ✅ [OpenSource GITHUB Script (RAW)](https://raw.githubusercontent.com/sjapanwala/netwise/main/netwise.cmd)

## Usage + Commands
#### Remember: Case Matters! Most commands are used with lowercase unless specified.
### General Commands
- `docu`-------------> Shows documentation about the program
- `exit`-------------> Exit the program
- `help`-------------> Shows the general help commands (these commands)
- `cls` or `clear`---> Clears the terminal
- `swusr`------------> Swaps users (higher permission commands)
- `info`-------------> Terminal information + Host information

### Root Commands
```
Root Password: root
```
#### These commands only work with root access. This can be accessed with `swusr`>`2`>`root`
- `root-h`-----------> Help menu for root commands
- `root-plant`-------> Plants the program into the user directory (C:\Users\(username)) for more functionality

### Insert Commands
- `insert-h`---------> Help menu for insert commands
- `insert-ip`--------> Allows the user to insert a target IP
- `insert-api`-------> Allows the user to insert an API key, for fewer API restraints

### IP Display
- `ipdisplay-h`------> Help menu for IP display
- `ipdisplay-l`------> Displays IP information for the Host IP
- `ipdisplay-t`------> Displays IP information for the target IP
- `ipdisplay-t2`-----> Displays IP information for the target IP (Branch 2, in case branch 1 fails to operate. Branch 2 isn't very reliable)

### Pinging
- `ping-h`-----------> Help menu for ping operations
- `ping-t`-----------> Pings the target IP (the amount can be selected)
- `ping-tb`----------> Pings the target IP, but outputs raw data

### Testing
- `test-h`-----------> Help menu for testing operations
- `test-net`---------> Tests host network connection

### Disable Operations
- `disable-h`--------> Help menu for disabling operations
- `disable-notif`----> Disables startup notifications

### Generative IP
- `genip-h`----------> Help menu for generating IPs
- `genip-create`-----> Creates a random IP and tests the authenticity of the IP
- `genip-loop`-------> Loops to create a random IP until an authentic one is found

### TracePath
- `tracepath-h`------> Help menu for trace path
- `tracepath-t`------> Traces the path it takes to go from the Host Net to the Target IP
- `tracepath-web`----> Traces the path it takes to go from the Host Net to the Target Web



