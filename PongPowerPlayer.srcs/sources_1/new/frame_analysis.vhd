----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2014 01:28:39 PM
-- Design Name: 
-- Module Name: frame_analysis - Behavioral
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

entity frame_analysis is
    Port ( clock_200M_i : in STD_LOGIC;
           pixel_binary_i : in pixelBinary;
           pixel_binary_o : out pixelBinary;
           ball_velocity_o : out velocity;
           ball_position_o : out pixelPosition;
           bat_position_o : out pixelPosition);
end frame_analysis;

architecture Behavioral of frame_analysis is

begin


end Behavioral;
