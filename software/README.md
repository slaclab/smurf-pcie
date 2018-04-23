# How to load the PCIe driver

```
# Programing the KCU1500 FPGA for the first time
https://docs.google.com/presentation/d/10eIsAbLmslcNk94yV-F1D3hBfxudBf0EFo4xjcn9qPk/edit?usp=sharing

# Confirm that you have the board the computer with VID=1a4a ("SLAC") and PID=2030 ("DataDev")
$ lspci -nn | grep SLAC
04:00.0 Signal processing controller [1180]: SLAC National Accelerator Lab PPA-REG Device [1a4a:2030]

# Clone the driver github repo:
$ git clone --recursive https://github.com/slaclab/aes-stream-drivers

# Go to the driver directory
$ cd aes-stream-drivers/data_dev/driver/

# Build the driver
$ make

# add new driver
$ sudo /sbin/insmod datadev.ko || exit 1

# give appropriate group/permissions
$ sudo chmod 666 /dev/data_dev*

# Check for the loaded device
$ cat /proc/data_dev0

```

# How to configure and run the PCIe based software

```
# Load the driver (see section above)
$ cat /proc/data_dev0

# Go to software directory
$ cd cryo-det/software

# Source the setup script with respect to your application
# In this example, our application is CryoDetCmbHcd 
$ source setup_CryoDetCmbHcd.csh

# Configure the PCIe card
$ python3 scripts/PcieLoadConfig.py --yaml config/pcie_rssi_config.yml

# How to launch the GUI
# In this example, ATCA Slot# is 4
$ python3 scripts/AmccGui.py --commType pcie-rssi-interleaved --slot 4

# How to Reprogram the AMC carrier's FPGA
$ python3 scripts/AmccProgramFpga.py --commType pcie-rssi-interleaved --slot 4 -mcs <PATH_TO_MCS_FILE>

# How to Reprogram the PCIe's FPGA
# Note: A power cycle (not reboot) of the PC required after running the PcieProgramKcu1500.py script
$ python3 scripts/PcieProgramKcu1500.py --mcs_pri <PATH_TO_PRIMARY_MCS_FILE> --mcs_sec <PATH_TO_SECONDARY_MCS_FILE>

```
