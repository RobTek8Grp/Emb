----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2014 10:37:54 AM
-- Design Name: 
-- Module Name: vga_input - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library mylibs;
use mylibs.mytypes.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_input is
    Port ( clk_100M_i : in STD_LOGIC;
           vsync_in : in STD_LOGIC;
           hsync_in : in STD_LOGIC;
           r_channel_i : in STD_LOGIC_VECTOR(9 downto 0);
           r_clock_o : out STD_LOGIC;
           g_channel_i : in STD_LOGIC_VECTOR(9 downto 0);
           g_clock_o : out STD_LOGIC;
           b_channel_i : in STD_LOGIC_VECTOR(9 downto 0);
           b_clock_o : out STD_LOGIC;
           pixel_grey_o : out pixelGrey);
end vga_input;

architecture Behavioral of vga_input is

begin


end Behavioral;
