# smurf-pcie

# Before you clone the GIT repository

1) Create a github account:
> https://github.com/

2) Email Ben Reese (https://github.com/bengineerd) your github username and request to be added to the "lcls-hps" github group
> https://github.com/orgs/slaclab/teams/lcls-hps/repositories

3) On the Linux machine that you will clone the github from, generate a SSH key (if not already done)
> https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

4) Add a new SSH key to your GitHub account
> https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/

5) Setup for large filesystems on github
```
$ git lfs install
```

# Clone the GIT repository
```
$ git clone --recursive git@github.com:slaclab/smurf-pcie
```

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
