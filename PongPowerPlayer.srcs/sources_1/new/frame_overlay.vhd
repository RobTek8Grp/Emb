----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2014 01:14:20 PM
-- Design Name: 
-- Module Name: frame_overlay - Behavioral
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

entity frame_overlay is
    Port ( 
           clock_200M_i : in STD_LOGIC;
           enable_i : in STD_LOGIC;
           pixel_binary_i : in pixelBinary;
           velocity_i : in velocity;
           pixelRGB_o : out pixelRGB);
end frame_overlay;

architecture Behavioral of frame_overlay is

begin


end Behavioral;
