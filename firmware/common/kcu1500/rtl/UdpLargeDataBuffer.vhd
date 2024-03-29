-------------------------------------------------------------------------------
-- File       : UdpLargeDataBuffer.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- This file is part of 'PGP PCIe APP DEV'.
-- It is subject to the license terms in the LICENSE.txt file found in the
-- top-level directory of this distribution and at:
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
-- No part of 'PGP PCIe APP DEV', including this file,
-- may be copied, modified, propagated, or distributed except according to
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;
use surf.EthMacPkg.all;
use surf.SsiPkg.all;

library axi_pcie_core;
use axi_pcie_core.MigPkg.all;

entity UdpLargeDataBuffer is
   generic (
      TPD_G    : time    := 1 ns;
      BYPASS_G : boolean := false);
   port (
      -- UDP Large Data Buffer (axiClk domain)
      axiClk           : in  sl;
      axiRst           : in  sl;
      ddrIbMasters     : in  AxiStreamMasterArray(1 downto 0);
      ddrIbSlaves      : out AxiStreamSlaveArray(1 downto 0);
      ddrObMasters     : out AxiStreamMasterArray(1 downto 0);
      ddrObSlaves      : in  AxiStreamSlaveArray(1 downto 0);
      -- AXI-Lite Interface (axiClk domain)
      axilReadMasters  : in  AxiLiteReadMasterArray(1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
      axilReadSlaves   : out AxiLiteReadSlaveArray(1 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);
      axilWriteMasters : in  AxiLiteWriteMasterArray(1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
      axilWriteSlaves  : out AxiLiteWriteSlaveArray(1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
      -- DDR Interface (ddrClk domain)
      ddrClk           : in  sl;
      ddrRst           : in  sl;
      ddrWriteMaster   : out AxiWriteMasterType                  := AXI_WRITE_MASTER_FORCE_C;
      ddrWriteSlave    : in  AxiWriteSlaveType                   := AXI_WRITE_SLAVE_FORCE_C;
      ddrReadMaster    : out AxiReadMasterType                   := AXI_READ_MASTER_FORCE_C;
      ddrReadSlave     : in  AxiReadSlaveType                    := AXI_READ_SLAVE_FORCE_C);
end UdpLargeDataBuffer;

architecture mapping of UdpLargeDataBuffer is

   constant AXIS_CONFIG_C : AxiStreamConfigType := (
      TSTRB_EN_C    => false,           -- Unused
      TDATA_BYTES_C => EMAC_AXIS_CONFIG_C.TDATA_BYTES_C,
      TDEST_BITS_C  => 0,      -- TDEST is assigned in the EthTrafficSwitch.vhd
      TID_BITS_C    => 0,               -- Unused
      TKEEP_MODE_C  => EMAC_AXIS_CONFIG_C.TKEEP_MODE_C,
      TUSER_BITS_C  => SSI_TUSER_BITS_C,
      TUSER_MODE_C  => EMAC_AXIS_CONFIG_C.TUSER_MODE_C);

   constant AXI_CONFIG_C : AxiConfigType := (
      ADDR_WIDTH_C => MEM_AXI_CONFIG_C.ADDR_WIDTH_C,
      DATA_BYTES_C => AXIS_CONFIG_C.TDATA_BYTES_C,  -- Matches the AXIS stream
      ID_BITS_C    => MEM_AXI_CONFIG_C.ID_BITS_C,
      LEN_BITS_C   => MEM_AXI_CONFIG_C.LEN_BITS_C);

   constant AXI_RESIZE_16B_C : AxiConfigType := (
      ADDR_WIDTH_C => 40,  -- Work around to recycle axi-pcie-core FW
      DATA_BYTES_C => AXI_CONFIG_C.DATA_BYTES_C,
      ID_BITS_C    => AXI_CONFIG_C.ID_BITS_C,
      LEN_BITS_C   => AXI_CONFIG_C.LEN_BITS_C);

   constant AXI_RESIZE_64B_C : AxiConfigType := (
      ADDR_WIDTH_C => 40,  -- Work around to recycle axi-pcie-core FW
      DATA_BYTES_C => MEM_AXI_CONFIG_C.DATA_BYTES_C,
      ID_BITS_C    => MEM_AXI_CONFIG_C.ID_BITS_C,
      LEN_BITS_C   => MEM_AXI_CONFIG_C.LEN_BITS_C);

   component AxiDdr64BCrossbarIpCore
      port (
         INTERCONNECT_ACLK    : in  std_logic;
         INTERCONNECT_ARESETN : in  std_logic;
         S00_AXI_ARESET_OUT_N : out std_logic;
         S00_AXI_ACLK         : in  std_logic;
         S00_AXI_AWID         : in  std_logic_vector(0 downto 0);
         S00_AXI_AWADDR       : in  std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         S00_AXI_AWLEN        : in  std_logic_vector(7 downto 0);
         S00_AXI_AWSIZE       : in  std_logic_vector(2 downto 0);
         S00_AXI_AWBURST      : in  std_logic_vector(1 downto 0);
         S00_AXI_AWLOCK       : in  std_logic;
         S00_AXI_AWCACHE      : in  std_logic_vector(3 downto 0);
         S00_AXI_AWPROT       : in  std_logic_vector(2 downto 0);
         S00_AXI_AWQOS        : in  std_logic_vector(3 downto 0);
         S00_AXI_AWVALID      : in  std_logic;
         S00_AXI_AWREADY      : out std_logic;
         S00_AXI_WDATA        : in  std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         S00_AXI_WSTRB        : in  std_logic_vector(MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         S00_AXI_WLAST        : in  std_logic;
         S00_AXI_WVALID       : in  std_logic;
         S00_AXI_WREADY       : out std_logic;
         S00_AXI_BID          : out std_logic_vector(0 downto 0);
         S00_AXI_BRESP        : out std_logic_vector(1 downto 0);
         S00_AXI_BVALID       : out std_logic;
         S00_AXI_BREADY       : in  std_logic;
         S00_AXI_ARID         : in  std_logic_vector(0 downto 0);
         S00_AXI_ARADDR       : in  std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         S00_AXI_ARLEN        : in  std_logic_vector(7 downto 0);
         S00_AXI_ARSIZE       : in  std_logic_vector(2 downto 0);
         S00_AXI_ARBURST      : in  std_logic_vector(1 downto 0);
         S00_AXI_ARLOCK       : in  std_logic;
         S00_AXI_ARCACHE      : in  std_logic_vector(3 downto 0);
         S00_AXI_ARPROT       : in  std_logic_vector(2 downto 0);
         S00_AXI_ARQOS        : in  std_logic_vector(3 downto 0);
         S00_AXI_ARVALID      : in  std_logic;
         S00_AXI_ARREADY      : out std_logic;
         S00_AXI_RID          : out std_logic_vector(0 downto 0);
         S00_AXI_RDATA        : out std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         S00_AXI_RRESP        : out std_logic_vector(1 downto 0);
         S00_AXI_RLAST        : out std_logic;
         S00_AXI_RVALID       : out std_logic;
         S00_AXI_RREADY       : in  std_logic;
         S01_AXI_ARESET_OUT_N : out std_logic;
         S01_AXI_ACLK         : in  std_logic;
         S01_AXI_AWID         : in  std_logic_vector(0 downto 0);
         S01_AXI_AWADDR       : in  std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         S01_AXI_AWLEN        : in  std_logic_vector(7 downto 0);
         S01_AXI_AWSIZE       : in  std_logic_vector(2 downto 0);
         S01_AXI_AWBURST      : in  std_logic_vector(1 downto 0);
         S01_AXI_AWLOCK       : in  std_logic;
         S01_AXI_AWCACHE      : in  std_logic_vector(3 downto 0);
         S01_AXI_AWPROT       : in  std_logic_vector(2 downto 0);
         S01_AXI_AWQOS        : in  std_logic_vector(3 downto 0);
         S01_AXI_AWVALID      : in  std_logic;
         S01_AXI_AWREADY      : out std_logic;
         S01_AXI_WDATA        : in  std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         S01_AXI_WSTRB        : in  std_logic_vector(MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         S01_AXI_WLAST        : in  std_logic;
         S01_AXI_WVALID       : in  std_logic;
         S01_AXI_WREADY       : out std_logic;
         S01_AXI_BID          : out std_logic_vector(0 downto 0);
         S01_AXI_BRESP        : out std_logic_vector(1 downto 0);
         S01_AXI_BVALID       : out std_logic;
         S01_AXI_BREADY       : in  std_logic;
         S01_AXI_ARID         : in  std_logic_vector(0 downto 0);
         S01_AXI_ARADDR       : in  std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         S01_AXI_ARLEN        : in  std_logic_vector(7 downto 0);
         S01_AXI_ARSIZE       : in  std_logic_vector(2 downto 0);
         S01_AXI_ARBURST      : in  std_logic_vector(1 downto 0);
         S01_AXI_ARLOCK       : in  std_logic;
         S01_AXI_ARCACHE      : in  std_logic_vector(3 downto 0);
         S01_AXI_ARPROT       : in  std_logic_vector(2 downto 0);
         S01_AXI_ARQOS        : in  std_logic_vector(3 downto 0);
         S01_AXI_ARVALID      : in  std_logic;
         S01_AXI_ARREADY      : out std_logic;
         S01_AXI_RID          : out std_logic_vector(0 downto 0);
         S01_AXI_RDATA        : out std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         S01_AXI_RRESP        : out std_logic_vector(1 downto 0);
         S01_AXI_RLAST        : out std_logic;
         S01_AXI_RVALID       : out std_logic;
         S01_AXI_RREADY       : in  std_logic;
         M00_AXI_ARESET_OUT_N : out std_logic;
         M00_AXI_ACLK         : in  std_logic;
         M00_AXI_AWID         : out std_logic_vector(3 downto 0);
         M00_AXI_AWADDR       : out std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         M00_AXI_AWLEN        : out std_logic_vector(7 downto 0);
         M00_AXI_AWSIZE       : out std_logic_vector(2 downto 0);
         M00_AXI_AWBURST      : out std_logic_vector(1 downto 0);
         M00_AXI_AWLOCK       : out std_logic;
         M00_AXI_AWCACHE      : out std_logic_vector(3 downto 0);
         M00_AXI_AWPROT       : out std_logic_vector(2 downto 0);
         M00_AXI_AWQOS        : out std_logic_vector(3 downto 0);
         M00_AXI_AWVALID      : out std_logic;
         M00_AXI_AWREADY      : in  std_logic;
         M00_AXI_WDATA        : out std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         M00_AXI_WSTRB        : out std_logic_vector(MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         M00_AXI_WLAST        : out std_logic;
         M00_AXI_WVALID       : out std_logic;
         M00_AXI_WREADY       : in  std_logic;
         M00_AXI_BID          : in  std_logic_vector(3 downto 0);
         M00_AXI_BRESP        : in  std_logic_vector(1 downto 0);
         M00_AXI_BVALID       : in  std_logic;
         M00_AXI_BREADY       : out std_logic;
         M00_AXI_ARID         : out std_logic_vector(3 downto 0);
         M00_AXI_ARADDR       : out std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         M00_AXI_ARLEN        : out std_logic_vector(7 downto 0);
         M00_AXI_ARSIZE       : out std_logic_vector(2 downto 0);
         M00_AXI_ARBURST      : out std_logic_vector(1 downto 0);
         M00_AXI_ARLOCK       : out std_logic;
         M00_AXI_ARCACHE      : out std_logic_vector(3 downto 0);
         M00_AXI_ARPROT       : out std_logic_vector(2 downto 0);
         M00_AXI_ARQOS        : out std_logic_vector(3 downto 0);
         M00_AXI_ARVALID      : out std_logic;
         M00_AXI_ARREADY      : in  std_logic;
         M00_AXI_RID          : in  std_logic_vector(3 downto 0);
         M00_AXI_RDATA        : in  std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         M00_AXI_RRESP        : in  std_logic_vector(1 downto 0);
         M00_AXI_RLAST        : in  std_logic;
         M00_AXI_RVALID       : in  std_logic;
         M00_AXI_RREADY       : out std_logic);
   end component;

   component XilinxKcu1500MigClkConvt
      port (
         s_axi_aclk     : in  std_logic;
         s_axi_aresetn  : in  std_logic;
         s_axi_awid     : in  std_logic_vector(3 downto 0);
         s_axi_awaddr   : in  std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         s_axi_awlen    : in  std_logic_vector(7 downto 0);
         s_axi_awsize   : in  std_logic_vector(2 downto 0);
         s_axi_awburst  : in  std_logic_vector(1 downto 0);
         s_axi_awlock   : in  std_logic_vector(0 downto 0);
         s_axi_awcache  : in  std_logic_vector(3 downto 0);
         s_axi_awprot   : in  std_logic_vector(2 downto 0);
         s_axi_awregion : in  std_logic_vector(3 downto 0);
         s_axi_awqos    : in  std_logic_vector(3 downto 0);
         s_axi_awvalid  : in  std_logic;
         s_axi_awready  : out std_logic;
         s_axi_wdata    : in  std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         s_axi_wstrb    : in  std_logic_vector(MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         s_axi_wlast    : in  std_logic;
         s_axi_wvalid   : in  std_logic;
         s_axi_wready   : out std_logic;
         s_axi_bid      : out std_logic_vector(3 downto 0);
         s_axi_bresp    : out std_logic_vector(1 downto 0);
         s_axi_bvalid   : out std_logic;
         s_axi_bready   : in  std_logic;
         s_axi_arid     : in  std_logic_vector(3 downto 0);
         s_axi_araddr   : in  std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         s_axi_arlen    : in  std_logic_vector(7 downto 0);
         s_axi_arsize   : in  std_logic_vector(2 downto 0);
         s_axi_arburst  : in  std_logic_vector(1 downto 0);
         s_axi_arlock   : in  std_logic_vector(0 downto 0);
         s_axi_arcache  : in  std_logic_vector(3 downto 0);
         s_axi_arprot   : in  std_logic_vector(2 downto 0);
         s_axi_arregion : in  std_logic_vector(3 downto 0);
         s_axi_arqos    : in  std_logic_vector(3 downto 0);
         s_axi_arvalid  : in  std_logic;
         s_axi_arready  : out std_logic;
         s_axi_rid      : out std_logic_vector(3 downto 0);
         s_axi_rdata    : out std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         s_axi_rresp    : out std_logic_vector(1 downto 0);
         s_axi_rlast    : out std_logic;
         s_axi_rvalid   : out std_logic;
         s_axi_rready   : in  std_logic;
         m_axi_aclk     : in  std_logic;
         m_axi_aresetn  : in  std_logic;
         m_axi_awid     : out std_logic_vector(3 downto 0);
         m_axi_awaddr   : out std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         m_axi_awlen    : out std_logic_vector(7 downto 0);
         m_axi_awsize   : out std_logic_vector(2 downto 0);
         m_axi_awburst  : out std_logic_vector(1 downto 0);
         m_axi_awlock   : out std_logic_vector(0 downto 0);
         m_axi_awcache  : out std_logic_vector(3 downto 0);
         m_axi_awprot   : out std_logic_vector(2 downto 0);
         m_axi_awregion : out std_logic_vector(3 downto 0);
         m_axi_awqos    : out std_logic_vector(3 downto 0);
         m_axi_awvalid  : out std_logic;
         m_axi_awready  : in  std_logic;
         m_axi_wdata    : out std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         m_axi_wstrb    : out std_logic_vector(MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         m_axi_wlast    : out std_logic;
         m_axi_wvalid   : out std_logic;
         m_axi_wready   : in  std_logic;
         m_axi_bid      : in  std_logic_vector(3 downto 0);
         m_axi_bresp    : in  std_logic_vector(1 downto 0);
         m_axi_bvalid   : in  std_logic;
         m_axi_bready   : out std_logic;
         m_axi_arid     : out std_logic_vector(3 downto 0);
         m_axi_araddr   : out std_logic_vector(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0);
         m_axi_arlen    : out std_logic_vector(7 downto 0);
         m_axi_arsize   : out std_logic_vector(2 downto 0);
         m_axi_arburst  : out std_logic_vector(1 downto 0);
         m_axi_arlock   : out std_logic_vector(0 downto 0);
         m_axi_arcache  : out std_logic_vector(3 downto 0);
         m_axi_arprot   : out std_logic_vector(2 downto 0);
         m_axi_arregion : out std_logic_vector(3 downto 0);
         m_axi_arqos    : out std_logic_vector(3 downto 0);
         m_axi_arvalid  : out std_logic;
         m_axi_arready  : in  std_logic;
         m_axi_rid      : in  std_logic_vector(3 downto 0);
         m_axi_rdata    : in  std_logic_vector(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0);
         m_axi_rresp    : in  std_logic_vector(1 downto 0);
         m_axi_rlast    : in  std_logic;
         m_axi_rvalid   : in  std_logic;
         m_axi_rready   : out std_logic);
   end component;

   signal dmaWriteMasters : AxiWriteMasterArray(1 downto 0) := (others => AXI_WRITE_MASTER_INIT_C);
   signal dmaWriteSlaves  : AxiWriteSlaveArray(1 downto 0)  := (others => AXI_WRITE_SLAVE_INIT_C);
   signal dmaReadMasters  : AxiReadMasterArray(1 downto 0)  := (others => AXI_READ_MASTER_INIT_C);
   signal dmaReadSlaves   : AxiReadSlaveArray(1 downto 0)   := (others => AXI_READ_SLAVE_INIT_C);

   signal ddrWriteMasters : AxiWriteMasterArray(1 downto 0) := (others => AXI_WRITE_MASTER_INIT_C);
   signal ddrWriteSlaves  : AxiWriteSlaveArray(1 downto 0)  := (others => AXI_WRITE_SLAVE_INIT_C);
   signal ddrReadMasters  : AxiReadMasterArray(1 downto 0)  := (others => AXI_READ_MASTER_INIT_C);
   signal ddrReadSlaves   : AxiReadSlaveArray(1 downto 0)   := (others => AXI_READ_SLAVE_INIT_C);

   signal axiWriteMaster : AxiWriteMasterType := AXI_WRITE_MASTER_INIT_C;
   signal axiWriteSlave  : AxiWriteSlaveType  := AXI_WRITE_SLAVE_INIT_C;
   signal axiReadMaster  : AxiReadMasterType  := AXI_READ_MASTER_INIT_C;
   signal axiReadSlave   : AxiReadSlaveType   := AXI_READ_SLAVE_INIT_C;

   signal axiResetVec : slv(1 downto 0) := (others => '1');
   signal axiReset    : sl              := '1';
   signal axiRstL     : sl              := '0';

   signal ddrReset : sl := '1';
   signal ddrRstL  : sl := '0';

begin

   BYPASS_LOGIC : if (BYPASS_G = true) generate
      ddrObMasters <= ddrIbMasters;
      ddrIbSlaves  <= ddrObSlaves;
   end generate;

   BUILD_LOGIC : if (BYPASS_G = false) generate

      U_axiRst : entity surf.RstPipeline
         generic map (
            TPD_G => TPD_G)
         port map (
            clk    => axiClk,
            rstIn  => axiRst,
            rstOut => axiReset);

      U_ddrRstL : entity surf.RstPipeline
         generic map (
            TPD_G => TPD_G)
         port map (
            clk    => ddrClk,
            rstIn  => ddrRst,
            rstOut => ddrReset);

      axiRstL <= not(axiReset);
      ddrRstL <= not(ddrReset);

      GEN_VEC : for i in 1 downto 0 generate

         U_axiRstVec : entity surf.RstPipeline
            generic map (
               TPD_G => TPD_G)
            port map (
               clk    => axiClk,
               rstIn  => axiReset,
               rstOut => axiResetVec(i));

         U_DmaFiFo : entity surf.AxiStreamDmaFifo
            generic map (
               TPD_G              => TPD_G,
               -- FIFO Configuration
               MAX_FRAME_WIDTH_G  => 14,  -- 2^14 = 16KB > 9000B ETH jumbo frame
               ------------------------------------------------------
               -- AXI_BUFFER_WIDTH_G => 28,  -- 256MB per DMA FIFO: ReadQueue = 8 x BRAM36
               -- AXI_BUFFER_WIDTH_G => 29,  -- 512MB per DMA FIFO = 16 x BRAM36
               -- AXI_BUFFER_WIDTH_G => 30,  -- 1GB per DMA FIFO = 32 x BRAM36
               AXI_BUFFER_WIDTH_G => 31,  -- 2GB per DMA FIFO = 64 x BRAM36
               -- AXI Stream Configurations
               ------------------------------------------------------
               AXIS_CONFIG_G      => AXIS_CONFIG_C,
               -- AXI4 Configurations
               AXI_BASE_ADDR_G    => ite(i = 0, x"0000_0000_0000_0000", x"0000_0000_8000_0000"),
               AXI_CONFIG_G       => AXI_CONFIG_C)
            port map (
               axiClk          => axiClk,
               axiRst          => axiResetVec(i),
               -- AXI Stream Interface
               sAxisMaster     => ddrIbMasters(i),
               sAxisSlave      => ddrIbSlaves(i),
               mAxisMaster     => ddrObMasters(i),
               mAxisSlave      => ddrObSlaves(i),
               -- AXI4 Interface
               axiReadMaster   => dmaReadMasters(i),
               axiReadSlave    => dmaReadSlaves(i),
               axiWriteMaster  => dmaWriteMasters(i),
               axiWriteSlave   => dmaWriteSlaves(i),
               -- Optional: AXI-Lite Interface
               axilReadMaster  => axilReadMasters(i),
               axilReadSlave   => axilReadSlaves(i),
               axilWriteMaster => axilWriteMasters(i),
               axilWriteSlave  => axilWriteSlaves(i));

         U_Resize : entity axi_pcie_core.AxiPcie64BResize
            generic map (
               TPD_G             => TPD_G,
               AXI_DMA_CONFIG_G  => AXI_RESIZE_16B_C,
               AXI_PCIE_CONFIG_G => AXI_RESIZE_64B_C)
            port map (
               -- Clock and Reset
               axiClk          => axiClk,
               axiRst          => axiResetVec(i),
               -- Slaves
               sAxiWriteMaster => dmaWriteMasters(i),
               sAxiWriteSlave  => dmaWriteSlaves(i),
               sAxiReadMaster  => dmaReadMasters(i),
               sAxiReadSlave   => dmaReadSlaves(i),
               -- Master
               mAxiWriteMaster => ddrWriteMasters(i),
               mAxiWriteSlave  => ddrWriteSlaves(i),
               mAxiReadMaster  => ddrReadMasters(i),
               mAxiReadSlave   => ddrReadSlaves(i));

      end generate GEN_VEC;

      U_AxiCrossbar : AxiDdr64BCrossbarIpCore
         port map (
            INTERCONNECT_ACLK    => ddrClk,
            INTERCONNECT_ARESETN => ddrRstL,
            -- SLAVE[0]
            S00_AXI_ARESET_OUT_N => open,
            S00_AXI_ACLK         => axiClk,
            S00_AXI_AWID(0)      => '0',
            S00_AXI_AWADDR       => ddrWriteMasters(0).awaddr(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0),
            S00_AXI_AWLEN        => ddrWriteMasters(0).awlen,
            S00_AXI_AWSIZE       => ddrWriteMasters(0).awsize,
            S00_AXI_AWBURST      => ddrWriteMasters(0).awburst,
            S00_AXI_AWLOCK       => ddrWriteMasters(0).awlock(0),
            S00_AXI_AWCACHE      => ddrWriteMasters(0).awcache,
            S00_AXI_AWPROT       => ddrWriteMasters(0).awprot,
            S00_AXI_AWQOS        => ddrWriteMasters(0).awqos,
            S00_AXI_AWVALID      => ddrWriteMasters(0).awvalid,
            S00_AXI_AWREADY      => ddrWriteSlaves(0).awready,
            S00_AXI_WDATA        => ddrWriteMasters(0).wdata(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0),
            S00_AXI_WSTRB        => ddrWriteMasters(0).wstrb(MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0),
            S00_AXI_WLAST        => ddrWriteMasters(0).wlast,
            S00_AXI_WVALID       => ddrWriteMasters(0).wvalid,
            S00_AXI_WREADY       => ddrWriteSlaves(0).wready,
            S00_AXI_BID          => ddrWriteSlaves(0).bid(0 downto 0),
            S00_AXI_BRESP        => ddrWriteSlaves(0).bresp,
            S00_AXI_BVALID       => ddrWriteSlaves(0).bvalid,
            S00_AXI_BREADY       => ddrWriteMasters(0).bready,
            S00_AXI_ARID(0)      => '0',
            S00_AXI_ARADDR       => ddrReadMasters(0).araddr(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0),
            S00_AXI_ARLEN        => ddrReadMasters(0).arlen,
            S00_AXI_ARSIZE       => ddrReadMasters(0).arsize,
            S00_AXI_ARBURST      => ddrReadMasters(0).arburst,
            S00_AXI_ARLOCK       => ddrReadMasters(0).arlock(0),
            S00_AXI_ARCACHE      => ddrReadMasters(0).arcache,
            S00_AXI_ARPROT       => ddrReadMasters(0).arprot,
            S00_AXI_ARQOS        => ddrReadMasters(0).arqos,
            S00_AXI_ARVALID      => ddrReadMasters(0).arvalid,
            S00_AXI_ARREADY      => ddrReadSlaves(0).arready,
            S00_AXI_RID          => ddrReadSlaves(0).rid(0 downto 0),
            S00_AXI_RDATA        => ddrReadSlaves(0).rdata(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0),
            S00_AXI_RRESP        => ddrReadSlaves(0).rresp,
            S00_AXI_RLAST        => ddrReadSlaves(0).rlast,
            S00_AXI_RVALID       => ddrReadSlaves(0).rvalid,
            S00_AXI_RREADY       => ddrReadMasters(0).rready,
            -- SLAVE[1]
            S01_AXI_ARESET_OUT_N => open,
            S01_AXI_ACLK         => axiClk,
            S01_AXI_AWID(0)      => '0',
            S01_AXI_AWADDR       => ddrWriteMasters(1).awaddr(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0),
            S01_AXI_AWLEN        => ddrWriteMasters(1).awlen,
            S01_AXI_AWSIZE       => ddrWriteMasters(1).awsize,
            S01_AXI_AWBURST      => ddrWriteMasters(1).awburst,
            S01_AXI_AWLOCK       => ddrWriteMasters(1).awlock(0),
            S01_AXI_AWCACHE      => ddrWriteMasters(1).awcache,
            S01_AXI_AWPROT       => ddrWriteMasters(1).awprot,
            S01_AXI_AWQOS        => ddrWriteMasters(1).awqos,
            S01_AXI_AWVALID      => ddrWriteMasters(1).awvalid,
            S01_AXI_AWREADY      => ddrWriteSlaves(1).awready,
            S01_AXI_WDATA        => ddrWriteMasters(1).wdata(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0),
            S01_AXI_WSTRB        => ddrWriteMasters(1).wstrb(MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0),
            S01_AXI_WLAST        => ddrWriteMasters(1).wlast,
            S01_AXI_WVALID       => ddrWriteMasters(1).wvalid,
            S01_AXI_WREADY       => ddrWriteSlaves(1).wready,
            S01_AXI_BID          => ddrWriteSlaves(1).bid(0 downto 0),
            S01_AXI_BRESP        => ddrWriteSlaves(1).bresp,
            S01_AXI_BVALID       => ddrWriteSlaves(1).bvalid,
            S01_AXI_BREADY       => ddrWriteMasters(1).bready,
            S01_AXI_ARID(0)      => '0',
            S01_AXI_ARADDR       => ddrReadMasters(1).araddr(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0),
            S01_AXI_ARLEN        => ddrReadMasters(1).arlen,
            S01_AXI_ARSIZE       => ddrReadMasters(1).arsize,
            S01_AXI_ARBURST      => ddrReadMasters(1).arburst,
            S01_AXI_ARLOCK       => ddrReadMasters(1).arlock(0),
            S01_AXI_ARCACHE      => ddrReadMasters(1).arcache,
            S01_AXI_ARPROT       => ddrReadMasters(1).arprot,
            S01_AXI_ARQOS        => ddrReadMasters(1).arqos,
            S01_AXI_ARVALID      => ddrReadMasters(1).arvalid,
            S01_AXI_ARREADY      => ddrReadSlaves(1).arready,
            S01_AXI_RID          => ddrReadSlaves(1).rid(0 downto 0),
            S01_AXI_RDATA        => ddrReadSlaves(1).rdata(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0),
            S01_AXI_RRESP        => ddrReadSlaves(1).rresp,
            S01_AXI_RLAST        => ddrReadSlaves(1).rlast,
            S01_AXI_RVALID       => ddrReadSlaves(1).rvalid,
            S01_AXI_RREADY       => ddrReadMasters(1).rready,
            -- MASTER
            M00_AXI_ARESET_OUT_N => open,
            M00_AXI_ACLK         => ddrClk,
            M00_AXI_AWID         => ddrWriteMaster.awid(3 downto 0),
            M00_AXI_AWADDR       => ddrWriteMaster.awaddr(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0),
            M00_AXI_AWLEN        => ddrWriteMaster.awlen,
            M00_AXI_AWSIZE       => ddrWriteMaster.awsize,
            M00_AXI_AWBURST      => ddrWriteMaster.awburst,
            M00_AXI_AWLOCK       => ddrWriteMaster.awlock(0),
            M00_AXI_AWCACHE      => ddrWriteMaster.awcache,
            M00_AXI_AWPROT       => ddrWriteMaster.awprot,
            M00_AXI_AWQOS        => ddrWriteMaster.awqos,
            M00_AXI_AWVALID      => ddrWriteMaster.awvalid,
            M00_AXI_AWREADY      => ddrWriteSlave.awready,
            M00_AXI_WDATA        => ddrWriteMaster.wdata(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0),
            M00_AXI_WSTRB        => ddrWriteMaster.wstrb(MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0),
            M00_AXI_WLAST        => ddrWriteMaster.wlast,
            M00_AXI_WVALID       => ddrWriteMaster.wvalid,
            M00_AXI_WREADY       => ddrWriteSlave.wready,
            M00_AXI_BID          => ddrWriteSlave.bid(3 downto 0),
            M00_AXI_BRESP        => ddrWriteSlave.bresp,
            M00_AXI_BVALID       => ddrWriteSlave.bvalid,
            M00_AXI_BREADY       => ddrWriteMaster.bready,
            M00_AXI_ARID         => ddrReadMaster.arid(3 downto 0),
            M00_AXI_ARADDR       => ddrReadMaster.araddr(MEM_AXI_CONFIG_C.ADDR_WIDTH_C-1 downto 0),
            M00_AXI_ARLEN        => ddrReadMaster.arlen,
            M00_AXI_ARSIZE       => ddrReadMaster.arsize,
            M00_AXI_ARBURST      => ddrReadMaster.arburst,
            M00_AXI_ARLOCK       => ddrReadMaster.arlock(0),
            M00_AXI_ARCACHE      => ddrReadMaster.arcache,
            M00_AXI_ARPROT       => ddrReadMaster.arprot,
            M00_AXI_ARQOS        => ddrReadMaster.arqos,
            M00_AXI_ARVALID      => ddrReadMaster.arvalid,
            M00_AXI_ARREADY      => ddrReadSlave.arready,
            M00_AXI_RID          => ddrReadSlave.rid(3 downto 0),
            M00_AXI_RDATA        => ddrReadSlave.rdata(8*MEM_AXI_CONFIG_C.DATA_BYTES_C-1 downto 0),
            M00_AXI_RRESP        => ddrReadSlave.rresp,
            M00_AXI_RLAST        => ddrReadSlave.rlast,
            M00_AXI_RVALID       => ddrReadSlave.rvalid,
            M00_AXI_RREADY       => ddrReadMaster.rready);

   end generate;

end mapping;
