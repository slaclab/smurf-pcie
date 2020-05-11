-------------------------------------------------------------------------------
-- File       : RegDmaAsyncFifo.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- DMA Mapping:
--
--    DMA[Lane=6][TDEST=0x00:0x07]: RSSI[Lane=0][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x08:0x0F]: RSSI[Lane=0][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x10:0x17]: RSSI[Lane=1][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x18:0x1F]: RSSI[Lane=1][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x20:0x27]: RSSI[Lane=2][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x28:0x2F]: RSSI[Lane=2][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x30:0x37]: RSSI[Lane=3][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x38:0x3F]: RSSI[Lane=3][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x40:0x47]: RSSI[Lane=4][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x48:0x4F]: RSSI[Lane=4][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x50:0x57]: RSSI[Lane=5][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x58:0x5F]: RSSI[Lane=5][TDEST=0x80:0x87]
--
-------------------------------------------------------------------------------
-- Note: udpObDest default is 0xC1 (refer to UdpDebug.vhd)
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

library surf;
use surf.StdRtlPkg.all;
use surf.AxiStreamPkg.all;
use surf.EthMacPkg.all;

use work.AppPkg.all;

entity RegDmaAsyncFifo is
   generic (
      TPD_G : time := 1 ns);
   port (
      -- Clocks and Resets
      axilClk       : in  sl;
      axilRst       : in  sl;
      dmaClk        : in  sl;
      dmaRst        : in  sl;
      -- DMA Interface (dmaClk domain)
      dmaObMaster   : in  AxiStreamMasterType;
      dmaObSlave    : out AxiStreamSlaveType;
      dmaIbMaster   : out AxiStreamMasterType;
      dmaIbSlave    : in  AxiStreamSlaveType;
      -- RSSI Interface (axilClk domain)
      rssiIbMasters : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      rssiIbSlaves  : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      rssiObMasters : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      rssiObSlaves  : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0));
end RegDmaAsyncFifo;

architecture mapping of RegDmaAsyncFifo is

   signal axilReset : sl;
   signal dmaReset  : sl;

   signal ibMaster : AxiStreamMasterType;
   signal ibSlave  : AxiStreamSlaveType;

   signal obMaster : AxiStreamMasterType;
   signal obSlave  : AxiStreamSlaveType;

   signal ibMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal obMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);

begin

   -----------------------------------------------------------------
   --                   Pipelined Resets
   -----------------------------------------------------------------

   U_axilRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

   U_dmaRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => dmaClk,
         rstIn  => dmaRst,
         rstOut => dmaReset);


   -----------------------------------------------------------------
   --             DMA Path: APP->DMA
   -----------------------------------------------------------------

   RSSI_OB_TDEST : process (rssiObMasters) is
      variable masters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      variable i       : natural;
   begin

      -- Init
      masters := rssiObMasters;

      -- Force the TDEST
      for i in NUM_RSSI_C-1 downto 0 loop

         -- Map TDEST[3:0] = [0x00:0x07] to [0x0:0x7] (register access)
         if rssiObMasters(i).tdest(7 downto 3) = 0 then
            masters(i).tdest := x"0" & '0' & rssiObMasters(i).tdest(2 downto 0);

         -- Map TDEST[3:0] = [0x80:0x87] to [0x8:0xF] (ASYNC MSG)
         else
            masters(i).tdest := x"0" & '1' & rssiObMasters(i).tdest(2 downto 0);

         end if;

      end loop;

      -- Outputs
      ibMasters <= masters;

   end process;

   U_MUX : entity surf.AxiStreamMux
      generic map (
         TPD_G                => TPD_G,
         NUM_SLAVES_G         => NUM_RSSI_C,
         TDEST_LOW_G          => 4,
         ILEAVE_EN_G          => true,
         ILEAVE_ON_NOTVALID_G => true,
         ILEAVE_REARB_G       => 128)
      port map (
         -- Clock and reset
         axisClk      => axilClk,
         axisRst      => axilReset,
         -- Slave
         sAxisMasters => ibMasters,
         sAxisSlaves  => rssiObSlaves,
         -- Masters
         mAxisMaster  => ibMaster,
         mAxisSlave   => ibSlave);

   U_IB_DMA : entity surf.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         -- FIFO configurations
         MEMORY_TYPE_G       => "distributed",
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 5,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axilClk,
         sAxisRst    => axilReset,
         sAxisMaster => ibMaster,
         sAxisSlave  => ibSlave,
         -- Master Port
         mAxisClk    => dmaClk,
         mAxisRst    => dmaReset,
         mAxisMaster => dmaIbMaster,
         mAxisSlave  => dmaIbSlave);

   -----------------------------------------------------------------
   --             DMA Path: DMA->APP
   -----------------------------------------------------------------

   U_OB_DMA : entity surf.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         -- FIFO configurations
         MEMORY_TYPE_G       => "distributed",
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 5,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => dmaClk,
         sAxisRst    => dmaReset,
         sAxisMaster => dmaObMaster,
         sAxisSlave  => dmaObSlave,
         -- Master Port
         mAxisClk    => axilClk,
         mAxisRst    => axilReset,
         mAxisMaster => obMaster,
         mAxisSlave  => obSlave);

   U_DEMUX : entity surf.AxiStreamDeMux
      generic map (
         TPD_G         => TPD_G,
         NUM_MASTERS_G => NUM_RSSI_C,
         TDEST_HIGH_G  => 7,
         TDEST_LOW_G   => 4)
      port map (
         -- Clock and reset
         axisClk      => axilClk,
         axisRst      => axilReset,
         -- Slave
         sAxisMaster  => obMaster,
         sAxisSlave   => obSlave,
         -- Masters
         mAxisMasters => obMasters,
         mAxisSlaves  => rssiIbSlaves);

   RSSI_IB_TDEST : process (obMasters) is
      variable masters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      variable i       : natural;
   begin

      -- Init
      masters := obMasters;

      -- Force the TDEST
      for i in NUM_RSSI_C-1 downto 0 loop

         -- Map TDEST[3:0] = [0x0:0x7] to [0x00:0x07] (register access)
         if obMasters(i).tdest(3) = '0' then
            masters(i).tdest := x"0" & '0' & obMasters(i).tdest(2 downto 0);

         -- Map TDEST[3:0] = [0x8:0xF] to [0x80:0x87] (ASYNC MSG)
         else
            masters(i).tdest := x"8" & '0' & obMasters(i).tdest(2 downto 0);

         end if;

      end loop;

      -- Outputs
      rssiIbMasters <= masters;

   end process;

end mapping;
