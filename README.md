# smurf-pcie

<!--- ######################################################## -->

# Clone the GIT repository

Install git large filesystems (git-lfs) in your .gitconfig (1-time step per unix environment)
```bash
$ git lfs install
```
Clone the git repo with git-lfs enabled
```bash
$ git clone --recursive https://github.com/slaclab/smurf-pcie.git
```

Note: `recursive flag` used to initialize all submodules within the clone

<!--- ######################################################## -->

# How to build the firmware

1) Update your submodules to the latest version
```
$ cd smurf-pcie/
$ ./set_submodule_tags
```

2) Setup Xilinx licensing

> In C-Shell: 
```
$ source smurf-pcie/firmware/setup_env_slac.csh
```

> In Bash:
```
$ source smurf-pcie/firmware/setup_env_slac.sh
```

3) If not done yet, make a symbolic link to the firmware/
```
$ ln -s /u1/$USER/build smurf-pcie/firmware/build
```

4) Go to the target directory and make the firmware:
```
$ cd smurf-pcie/firmware/targets/SmurfKcu1500RssiOffload10GbE/
$ make
```

5) Optional: Review the results in GUI mode
```
$ make gui
```

# How to reprogram PCIe FPGA
```
$ source setup_rogue.sh
$ cd smurf-pcie/firmware/submodules/axi-pcie-core/python/
$ python3 updateKcu1500.py /path/to/mcs 
```
