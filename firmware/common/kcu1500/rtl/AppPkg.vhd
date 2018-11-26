-------------------------------------------------------------------------------
-- File       : AppPkg.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-08-02
-------------------------------------------------------------------------------
-- Description: Package file for Application
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

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.AxiPciePkg.all;

package AppPkg is
 
   ---------------------------------
   -- AMC Carrier RSSI Routing Table
   ---------------------------------

   constant APP_STREAMS_C : positive := 6;

   constant SRP_IDX_C        : natural := 0;
   constant BSA_ASYNC_IDX_C  : natural := 1;
   constant DIAG_ASYNC_IDX_C : natural := 2;
   constant MEM_DATA_IDX_C   : natural := 3;
   constant RAW_DATA_IDX_C   : natural := 4;
   constant APP_ASYNC_IDX_C  : natural := 5;

   constant APP_STREAM_ROUTES_C : Slv8Array(APP_STREAMS_C-1 downto 0) := (
      SRP_IDX_C        => X"00",        -- TDEST 0 routed to stream 0 (SRPv3)
      BSA_ASYNC_IDX_C  => X"02",  -- TDEST 2 routed to stream 1 (BSA async)
      DIAG_ASYNC_IDX_C => X"03",  -- TDEST 3 routed to stream 2 (Diag async)
      MEM_DATA_IDX_C   => X"04",        -- TDEST 4 routed to stream 3 (MEM)
      RAW_DATA_IDX_C   => "10------",  -- TDEST x80-0xBF routed to stream 4 (Raw Data)            
      APP_ASYNC_IDX_C  => "11------");  -- TDEST 0xC0-0xFF routed to stream 5 (Application)  

   constant APP_AXIS_CONFIG_C : AxiStreamConfigType := (
      TSTRB_EN_C    => DMA_AXIS_CONFIG_C.TSTRB_EN_C,
      TDATA_BYTES_C => 8,               -- 64-bit interface to match RSSI/PackVer2
      TDEST_BITS_C  => DMA_AXIS_CONFIG_C.TDEST_BITS_C,
      TID_BITS_C    => DMA_AXIS_CONFIG_C.TID_BITS_C,
      TKEEP_MODE_C  => DMA_AXIS_CONFIG_C.TKEEP_MODE_C,
      TUSER_BITS_C  => DMA_AXIS_CONFIG_C.TUSER_BITS_C,
      TUSER_MODE_C  => DMA_AXIS_CONFIG_C.TUSER_MODE_C);

   constant APP_STREAM_CONFIG_C : AxiStreamConfigArray(APP_STREAMS_C-1 downto 0) := (others => APP_AXIS_CONFIG_C);      

   ---------------------------------
   --  General Configuration
   ---------------------------------

   constant NUM_LINKS_C     : positive := 1;  -- Only using 1 of the 8 QSFP links
   constant RSSI_PER_LINK_C : positive := 1;  -- 1 RSSI clients per QSFP link
   constant AXIS_PER_LINK_C : positive := RSSI_PER_LINK_C*APP_STREAMS_C;
   constant NUM_AXIS_C      : positive := NUM_LINKS_C*AXIS_PER_LINK_C;
   constant NUM_RSSI_C      : positive := NUM_LINKS_C*RSSI_PER_LINK_C;

end package AppPkg;
