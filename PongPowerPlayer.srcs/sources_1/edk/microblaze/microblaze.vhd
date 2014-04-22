-- /*******************************************************************************
-- *     This file is owned and controlled by Xilinx and must be used             *
-- *     solely for design, simulation, implementation and creation of            *
-- *     design files limited to Xilinx devices or technologies. Use              *
-- *     with non-Xilinx devices or technologies is expressly prohibited          *
-- *     and immediately terminates your license.                                 *
-- *                                                                              *
-- *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"            *
-- *     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                  *
-- *     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION          *
-- *     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION              *
-- *     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS                *
-- *     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                  *
-- *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE         *
-- *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY                 *
-- *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                  *
-- *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR           *
-- *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF          *
-- *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS          *
-- *     FOR A PARTICULAR PURPOSE.                                                *
-- *                                                                              *
-- *     Xilinx products are not intended for use in life support                 *
-- *     appliances, devices, or systems. Use in such applications are            *
-- *     expressly prohibited.                                                    *
-- *                                                                              *
-- *     Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.               *
-- *******************************************************************************/

-- The following must be inserted into your VHDL file for this
-- core to be instantiated. Change the instance name and port connections
-- (in parentheses) to your own signal names.

------------- Begin Cut here for INSTANTIATION Template ---// INST_TAG

 attribute BOX_TYPE : STRING;
 attribute BOX_TYPE of microblaze : component is "user_black_box";

  microblaze_i : microblaze
    port map (
      reset_i => reset_i,     -- in std_logic;
      clk_i => clk_i,     -- in std_logic;
      uart_rx_i => uart_rx_i,     -- in std_logic;
      uart_tx_o => uart_tx_o,     -- out std_logic;
      direction_gpio_i => direction_gpio_i,     -- in std_logic_vector(1 downto 0);
      ball_position_gpio_i => ball_position_gpio_i,     -- in std_logic_vector(31 downto 0);
      bat_posiion_gpio_i => bat_posiion_gpio_i     -- in std_logic_vector(15 downto 0);
    );

-- INST_TAG_END ------ End INSTANTIATION Template ---------

