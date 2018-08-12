-------------------------------------------------------------------------------
-- File       : AxiPcieDmaLanePackVer2.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-08-02
-- Last update: 2018-08-12
-------------------------------------------------------------------------------
-- Description: Wrapper for AXIS DMA Engine
-------------------------------------------------------------------------------
-- This file is part of 'axi-pcie-core'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'axi-pcie-core', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.AxiPciePkg.all;

entity AxiPcieDmaLanePackVer2 is
   generic (
      TPD_G               : time                 := 1 ns;
      APP_STREAMS_G       : positive             := 1;
      APP_STREAM_ROUTES_G : Slv8Array            := (0 => "--------");
      APP_STREAM_CONFIG_G : AxiStreamConfigArray := (0 => DMA_AXIS_CONFIG_C);
      MAX_SEG_SIZE_G      : positive             := 2**20);  -- Default: 1MB
   port (
      -- Application Interfaces (RAW AXI Stream)
      appClk       : in  sl;
      appRst       : in  sl;
      appObMasters : in  AxiStreamMasterArray(APP_STREAMS_G-1 downto 0);
      appObSlaves  : out AxiStreamSlaveArray(APP_STREAMS_G-1 downto 0);
      appIbMasters : out AxiStreamMasterArray(APP_STREAMS_G-1 downto 0);
      appIbSlaves  : in  AxiStreamSlaveArray(APP_STREAMS_G-1 downto 0);
      -- DMA Interface (PackerV2 encoded, 128-bit AXI Stream)
      dmaClk       : in  sl;
      dmaRst       : in  sl;
      dmaObMaster  : in  AxiStreamMasterType;
      dmaObSlave   : out AxiStreamSlaveType;
      dmaIbMaster  : out AxiStreamMasterType;
      dmaIbSlave   : in  AxiStreamSlaveType);
end AxiPcieDmaLanePackVer2;

architecture mapping of AxiPcieDmaLanePackVer2 is

   constant AXIS_CONFIG_C : AxiStreamConfigType := (
      TSTRB_EN_C    => DMA_AXIS_CONFIG_C.TSTRB_EN_C,
      TDATA_BYTES_C => 8,               -- PackVer2 is 64-bit interface
      TDEST_BITS_C  => DMA_AXIS_CONFIG_C.TDEST_BITS_C,
      TID_BITS_C    => DMA_AXIS_CONFIG_C.TID_BITS_C,
      TKEEP_MODE_C  => DMA_AXIS_CONFIG_C.TKEEP_MODE_C,
      TUSER_BITS_C  => DMA_AXIS_CONFIG_C.TUSER_BITS_C,
      TUSER_MODE_C  => DMA_AXIS_CONFIG_C.TUSER_MODE_C);

   signal rxMasters : AxiStreamMasterArray(APP_STREAMS_G-1 downto 0);
   signal rxSlaves  : AxiStreamSlaveArray(APP_STREAMS_G-1 downto 0);
   signal txMasters : AxiStreamMasterArray(APP_STREAMS_G-1 downto 0);
   signal txSlaves  : AxiStreamSlaveArray(APP_STREAMS_G-1 downto 0);

   signal rxMaster : AxiStreamMasterType;
   signal rxSlave  : AxiStreamSlaveType;
   signal txMaster : AxiStreamMasterType;
   signal txSlave  : AxiStreamSlaveType;

   signal ibMaster : AxiStreamMasterType;
   signal ibSlave  : AxiStreamSlaveType;
   signal obMaster : AxiStreamMasterType;
   signal obSlave  : AxiStreamSlaveType;

begin

   -------------------------------------------------------------------------------
   --                   Application Outbound Path                               --
   -------------------------------------------------------------------------------

   GEN_RX :
   for i in (APP_STREAMS_G-1) downto 0 generate
      U_Rx : entity work.AxiStreamResize
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            READY_EN_G          => true,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => APP_STREAM_CONFIG_G(i),
            MASTER_AXI_CONFIG_G => AXIS_CONFIG_C)
         port map (
            -- Clock and reset
            axisClk     => appClk,
            axisRst     => appRst,
            -- Slave Port
            sAxisMaster => appObMasters(i),
            sAxisSlave  => appObSlaves(i),
            -- Master Port
            mAxisMaster => rxMasters(i),
            mAxisSlave  => rxSlaves(i));
   end generate GEN_RX;

   U_AxiStreamMux : entity work.AxiStreamMux
      generic map (
         TPD_G                => TPD_G,
         NUM_SLAVES_G         => APP_STREAMS_G,
         MODE_G               => "ROUTED",
         TDEST_ROUTES_G       => APP_STREAM_ROUTES_G,
         ILEAVE_EN_G          => true,
         ILEAVE_ON_NOTVALID_G => false,
         ILEAVE_REARB_G       => (2048/AXIS_CONFIG_C.TDATA_BYTES_C),
         PIPE_STAGES_G        => 1)
      port map (
         -- Clock and reset
         axisClk      => appClk,
         axisRst      => appRst,
         -- Slaves
         sAxisMasters => rxMasters,
         sAxisSlaves  => rxSlaves,
         -- Master
         mAxisMaster  => rxMaster,
         mAxisSlave   => rxSlave);

   U_Packetizer : entity work.AxiStreamPacketizer2
      generic map (
         TPD_G                => TPD_G,
         CRC_MODE_G           => "NONE",
         MAX_PACKET_BYTES_G   => MAX_SEG_SIZE_G,
         TDEST_BITS_G         => 8,
         INPUT_PIPE_STAGES_G  => 0,
         OUTPUT_PIPE_STAGES_G => 1)
      port map (
         axisClk     => appClk,
         axisRst     => appRst,
         sAxisMaster => rxMaster,
         sAxisSlave  => rxSlave,
         mAxisMaster => ibMaster,
         mAxisSlave  => ibSlave);

   U_IB_FIFO : entity work.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 1,
         PIPE_STAGES_G       => 1,
         SLAVE_READY_EN_G    => true,
         VALID_THOLD_G       => (2048/DMA_AXIS_CONFIG_C.TDATA_BYTES_C),  -- Hold until enough to burst into the interleaving MUX
         VALID_BURST_MODE_G  => true,
         -- FIFO configurations
         BRAM_EN_G           => true,
         GEN_SYNC_FIFO_G     => true,
         FIFO_ADDR_WIDTH_G   => 9,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => DMA_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => appClk,
         sAxisRst    => appRst,
         sAxisMaster => ibMaster,
         sAxisSlave  => ibSlave,
         -- Master Port
         mAxisClk    => dmaClk,
         mAxisRst    => dmaRst,
         mAxisMaster => dmaIbMaster,
         mAxisSlave  => dmaIbSlave);

   -------------------------------------------------------------------------------
   --                   Application Inbound Path                                --
   -------------------------------------------------------------------------------         

   U_OB_FIFO : entity work.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 0,
         PIPE_STAGES_G       => 1,
         SLAVE_READY_EN_G    => true,
         VALID_THOLD_G       => 1,
         -- FIFO configurations
         BRAM_EN_G           => false,
         USE_BUILT_IN_G      => false,
         GEN_SYNC_FIFO_G     => true,
         CASCADE_SIZE_G      => 1,
         FIFO_ADDR_WIDTH_G   => 4,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => DMA_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => dmaClk,
         sAxisRst    => dmaRst,
         sAxisMaster => dmaObMaster,
         sAxisSlave  => dmaObSlave,
         -- Master Port
         mAxisClk    => appClk,
         mAxisRst    => appRst,
         mAxisMaster => obMaster,
         mAxisSlave  => obSlave);

   U_Depacketizer : entity work.AxiStreamDepacketizer2
      generic map (
         TPD_G                => TPD_G,
         CRC_MODE_G           => "NONE",
         TDEST_BITS_G         => 8,
         INPUT_PIPE_STAGES_G  => 0,
         OUTPUT_PIPE_STAGES_G => 1)
      port map (
         axisClk     => appClk,
         axisRst     => appRst,
         linkGood    => '1',
         sAxisMaster => obMaster,
         sAxisSlave  => obSlave,
         mAxisMaster => txMaster,
         mAxisSlave  => txSlave);

   U_AxiStreamDeMux : entity work.AxiStreamDeMux
      generic map (
         TPD_G          => TPD_G,
         PIPE_STAGES_G  => 1,
         NUM_MASTERS_G  => APP_STREAMS_G,
         MODE_G         => "ROUTED",
         TDEST_ROUTES_G => APP_STREAM_ROUTES_G)
      port map (
         -- Clock and reset
         axisClk      => appClk,
         axisRst      => appRst,
         -- Slaves
         sAxisMaster  => txMaster,
         sAxisSlave   => txSlave,
         -- Master
         mAxisMasters => txMasters,
         mAxisSlaves  => txSlaves);

   GEN_TX :
   for i in (APP_STREAMS_G-1) downto 0 generate
      U_Tx : entity work.AxiStreamResize
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            READY_EN_G          => true,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => APP_STREAM_CONFIG_G(i))
         port map (
            -- Clock and reset
            axisClk     => appClk,
            axisRst     => appRst,
            -- Slave Port
            sAxisMaster => txMasters(i),
            sAxisSlave  => txSlaves(i),
            -- Master Port
            mAxisMaster => appIbMasters(i),
            mAxisSlave  => appIbSlaves(i));
   end generate GEN_TX;

end mapping;
