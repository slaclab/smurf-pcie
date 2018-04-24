# cryo-det

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
$ git clone --recursive git@github.com:slaclab/cryo-det
```

# How to build the firmware

1) Update your submodules to the latest version
```
$ cd cryo-det/
$ ./set_submodule_tags
```

2) Setup Xilinx licensing

> In C-Shell: 
```
$ source cryo-det/firmware/setup_env_slac.csh
```

> In Bash:
```
$ source cryo-det/firmware/setup_env_slac.sh
```

3) If not done yet, make a symbolic link to the firmware/
```
$ ln -s /u1/$USER/build cryo-det/firmware/build
```

4) Go to the target directory and make the firmware:
```
$ cd cryo-det/firmware/targets/CryoRtmEth/
$ make
```

5) Optional: Review the results in GUI mode
```
$ make gui
```

# How to reprogram your AMC Carrier's FPGA
https://confluence.slac.stanford.edu/x/aYZwD

# How to run the QT GUI Software
https://confluence.slac.stanford.edu/x/sXFODQ

# How to take data using the development ROGUE QT GUI
https://confluence.slac.stanford.edu/x/v3FODQ

# How to run EPICS Software
https://confluence.slac.stanford.edu/x/tHFODQ

# How to program FPGA and run the QT GUI (example)
```
# Log into PC
$ ssh tid-pc93130 -Y

# Program the FPGA
$ /afs/slac/g/lcls/package/cpsw/utils/ProgramFPGA/current/ProgramFPGA.bash --shelfmanager shm-b084-sp07 --slot 4 --addr 3 --mcs ~ruckman/projects/lcls/cryo-det/firmware/targets/CryoRtmEth/images/CryoRtmEth-0x00000013-20170720163850-ruckman-3fc2f4b.mcs

# Check the IPMI status
$ source /afs/slac/g/reseng/IPMC/env.csh
$ amcc_dump_bsi --all shm-b084-sp07/4

# Go to software directory
$ cd /afs/slac/g/lcls/package/pyrogue/control-server/current

# Launch the GUI
$ ./start_server.sh -a 10.0.3.104 -t ~ruckman/projects/lcls/cryo-det/firmware/targets/CryoRtmEth/images/CryoRtmEth-0x00000013-20170720163850-ruckman-3fc2f4b.pyrogue.tar.gz

# Use these default configurations
/afs/slac.stanford.edu/u/re/ruckman/projects/lcls/cryo-det/firmware/targets/CryoRtmEth/config/defaults.yml

```
