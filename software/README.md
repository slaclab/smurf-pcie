# How to load the PCIe driver

```
# Program the KCU1500 FPGA
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

# Launch the GUI
# In this example, ATCA Slot# is 4
$ python3 scripts/AmccGui.py --commType pcie-rssi-interleaved --slot 4

```


