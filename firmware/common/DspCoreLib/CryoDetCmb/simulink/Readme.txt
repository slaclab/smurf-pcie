##################################################################################################
File       : file:///afs/slac/g/reseng/svn/repos/LCLS_II/trunk/LLRF/firmware/modules/DspCoreLib/CryoDet/simulink/Readme.txt
Author     : Steve Smith   <ssmith@slac.stanford.edu>
Author     : Uros Legat <ulegat@slac.stanford.edu>
Company    : SLAC National Accelerator Laboratory
Created    : 2015-10-26
Last update: 2015-12-15 SS modify for CryoDet firmware
##################################################################################################

Step 1) Log into a SLAC System Generator Linux server (either rdusr217 or rdusr219):
   - Example:
      $ ssh rdusr219 -YC

Step 2) Check out the subversion repository:
   - Note: This step IS REQUIRED if it has not be done before.
   - Example:
      rdusr219 ~$ cd $home/projects
      rdusr219 ~$ svn co file:///afs/slac/g/reseng/svn/repos/LCLS_II/trunk/LLRF/
      
Step 3) Check that the subversion repository is up-to-date:
   - Example:
      rdusr219 ~$ cd $home/projects
      rdusr219 ~$ svn update LLRF/

Step 4) Setup the System Generator environment:      
   - Example:
      rdusr219 ~$ cd $home/projects/LLRF/firmware/modules/DspCoreLib
      rdusr219 ~$ source setup_env.csh 
   - Note: This .csh script will do the following:
      A) Makes an output build directory in the Linux server's /u1 hard drive mount
      B) Makes a symbolic link from this checkout SVN source tree 
         to the /u1's output build directory
      C) Sets up your Xilinx licensing

Step 5) Open the System Generator Software
   - Example:   
      rdusr219 ~$ cd $home/projects/LLRF/firmware/modules/DspCoreLib/CryoDet/simulink/
      rdusr219 ~$ sysgen

Step 6) Setup Matlab workspace parameters needed by simulink model and open the System Generator file
   A) Right-click on setupCryoDet.m and click "run" to set up FPGA parameters
   B) Double click on "ADCtoDACloopback.slx" on the left-hand side file navigator
   C) A System Generator GUI will pop up
   
Step 7) Develop and test the DSP core 
   - Example:  Add or remove ports
   - Example:  Matlab simulation
   
Step 8) Generate the Synthesized Checkpoint (.dcp) file
   A) Double click on the "System Generator" ICON
   B) In "Compilation", select the "Synthesized Checkpoint" option, then click "Apply" button
   C) Then click "Generate" button
   D) Wait for the compilation to complete
   
Step 9) Close the System Generator Software 
   A) Save your progress (CTRL + S)
   B) Close the System Generator GUI window
   B) Close the Matlab GUI window

Firmware    
===================================   
   
Step 10) Build the FPGA firmware and generate a .bit file and .mcs file
   
   Repeat Step 4) if running from a new terminal window or machine.

   rdusr219 ~$ cd $home/projects/LLRF/firmware/
   rdusr219 ~$ source setup_env.csh    
   rdusr219 ~$ cd $home/projects/LLRF/firmware/targets/AmcRfDemoBoard/
   rdusr219 ~$ make

   It usually takes around 20 min. Make sure you do not see any errors!
   Output should look similar to this when it finishes:

   ===================================
    Configuration Memory information
   ===================================
   File Format        MCS
   Interface          SPIX4
   Size               256M
   Start Address      0x00000000
   End Address        0x0FFFFFFF

   Addr1         Addr2         Date                    File(s)
   0x00000000    0x00F43EFB    Oct 26 11:59:06 2015    /u/re/ulegat/ProjDocs/LLRF/firmware/build/AmcRfDemoBoard/AmcRfDemoBoard_project.runs/impl_1/AmcRfDemoBoard.bit
   # exec cp ${outputFile} ${imagesFile}
   INFO: [Common 17-206] Exiting Vivado at Mon Oct 26 11:59:49 2015...

   Prom file copied to /u/re/ulegat/ProjDocs/LLRF/firmware/targets/AmcRfDemoBoard/images/AmcRfDemoBoard_00000003.mcs
   Don't forget to 'svn commit' when the image is stable!
   
Step 11)

   Check the output files!   
   
   Two files will be copied into the 
   $home/projects/LLRF/firmware/targets/AmcRfDemoBoard/images/ directory: 
      AmcRfDemoBoard_XXXXXXXX.bit
      AmcRfDemoBoard_XXXXXXXX.mcs
   where XXXXXXXX is the firmware FPGA_VERSION_C constant in the 
   $home/projects/LLRF/firmware/targets/AmcRfDemoBoard/images/version.vhd file.
   The .bit file is the FPGA programming file.  
   The .mcs file is the FPGA's boot PROM programming file.  
   
Software    
===================================
 
Step 12)    
     
   Programming the FPGA with a .bit file
  
   After performing the steps above for "Building the firmware"

   Step 1) cd $home/projects/LLRF/firmware/
   Step 1a) source setup_env.csh
   Step 1b) >>vivado  Start Vivado on your local machine (The one that has JTAG connected directly to the carrier)
   Step 2)  Open hardware manager
   Step 3)	Click Open target and choose Auto Connect or Open recent target (Localhost:3121...)
   Step 4)	Click on which Xilinx FPGA (e.g. right click on xcku040)
   Step 5)	Select programming file (browse for *.bit file)
   Step 6)	Click "Program"

Step 13)
   Programming the FPGA's PROM with a .MCS file
   
   rdusr219 ~$ cd $home/projects/LLRF/software/rfDemoBoard
   rdusr219 ~$ source setup_env.csh
   rdusr219 ~$ make clean
   rdusr219 ~$ make
   rdusr219 ~$ bin/AppFirmwareLoader ../../firmware/targets/demo/AmcCarrierDemoPgp/images/AmcRfDemoBoard_XXXXXXXX.mcs
   
Step 14)
   Make and run software GUI:
   
   rdusr219 ~$ cd $home/projects/LLRF/software/rfDemoBoard
   rdusr219 ~$ source setup_env.csh
   rdusr219 ~$ make clean
   rdusr219 ~$ make
   rdusr219 ~$ ./bin/RfDemoBoardGui &

Step 15) (Optional)
   Modify software:
   
   rdusr219 ~$ cd $home/projects/LLRF/software/rfDemoBoard/rfDemoBoard/
   rdusr219 ~$ gedit SysGen.cpp (Modify the file: Add potential Configuration or Status register links)
   rdusr219 ~$ cd $home/projects/LLRF/software/rfDemoBoard/
   rdusr219 ~$ make
   rdusr219 ~$ ./bin/RfDemoBoardGui &  
