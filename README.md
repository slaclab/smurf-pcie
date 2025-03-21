# smurf-pcie

[DOE Code](https://www.osti.gov/doecode/biblio/79260)

<!--- ######################################################## -->

# Clone the GIT repository

Install git large filesystems (git-lfs) in your .gitconfig (1-time step per unix environment)
```bash
git lfs install
```
Clone the git repo with git-lfs enabled
```bash
git clone --recursive https://github.com/slaclab/smurf-pcie.git
```

Note: `recursive flag` used to initialize all submodules within the clone

<!--- ######################################################## -->

# How to build the firmware

1) Setup Xilinx licensing
```bash
source smurf-pcie/firmware/setup_env_slac.sh
```

2) Go to the target directory and make the firmware:
```bash
cd smurf-pcie/firmware/targets/SmurfKcu1500RssiOffload10GbE/
make
```

5) Optional: Review the results in GUI mode
```
$ make gui
```

<!--- ######################################################## -->

# How to run the emulation software setup

1) Install SmurfKcu1500RssiOffload10GbE into the motherboard so driver will make it /dev/datadev_0 and /dev/datadev_1 

2) Install SmurfC1100FebEmu on the same motherboard but at a higher PCIe slot# so driver will make it  /dev/datadev_2

3) Connect the SmurfKcu1500RssiOffload10GbE 10GbE lanes (QSFP interface) to the SmurfC1100FebEmu either directly or ATCA ETH switch

4) Go to software dir and setup conda
```bash
cd smurf-pcie/software
source setup.sh
```

5) Load the UDP client and RSSI client configuration into the SmurfKcu1500RssiOffload10GbE
```bash
$ python scripts/PcieLoadConfig.py
Rogue/pyrogue version v6.4.0. https://github.com/slaclab/rogue
Path         = pcie.Core.AxiPcieCore.AxiVersion
FwVersion    = 0x3020000
UpTime       = 6:42:08
GitHash      = 0xb2c620b6638eee10bd1c31d83f82e4b5799c3c79
XilinxDnaId  = 0x400200010117f1801c512445
FwTarget     = SmurfKcu1500RssiOffload10GbE
BuildEnv     = Vivado v2023.1
BuildServer  = rdsrv411 (Ubuntu 20.04.6 LTS)
BuildDate    = Fri 13 Sep 2024 01:52:25 PM PDT
Builder      = ruckman
Loading config/SmurfPcieConfig.yml YAML file
```

6) Launch the GUI with a desired RAW UDP streaming rate:
```bash
$ python scripts/SmurfFebEmuGui.py --febConfig config/SmurfFebEmu/10kHz_8320B.yml
Rogue/pyrogue version v6.4.0. https://github.com/slaclab/rogue
Start: Started zmqServer on ports 9099-9101
    To start a gui: python -m pyrogue gui --server='localhost:9099'
    To use a virtual client: client = pyrogue.interfaces.VirtualClient(addr='localhost', port=9099)
Loading config/SmurfFebEmu/10kHz_8320B.yml YAML file
WARNING:pyrogue.Variable.RemoteVariable.Root.RawUdpMon.AxiVersion.BOOT_PROM_G:Invalid enum value 4294967295 in variable 'Root.RawUdpMon.AxiVersion.BOOT_PROM_G'
Root.Core.AxiPcieCore.AxiVersion count reset called
Root.RawUdpMon.AxiVersion count reset called
Root.Feb[0].AxiVersion count reset called
Root.DbgFeb[0].AxiVersion count reset called
ZmqClient::setTimeout: Setting timeout to 1000 msecs, waitRetry = 0
Connected to Root at 127.0.0.1:9099
ZmqClient::setTimeout: Setting timeout to 1000 msecs, waitRetry = 1
Running GUI. Close window, hit cntrl-c or send SIGTERM to 4894 to exit.
```

<!--- ######################################################## -->
