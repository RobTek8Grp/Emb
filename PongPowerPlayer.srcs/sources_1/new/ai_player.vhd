----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2014 03:11:57 PM
-- Design Name: 
-- Module Name: ai_player - Behavioral
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

entity ai_player is
    Port ( ball_position_i : in pixelPosition;
           bat_position_i : in pixelPosition;
           bat_control_key_up_i : in STD_LOGIC;
           bat_control_key_down_i : in STD_LOGIC;
           ai_enable : in STD_LOGIC;
           uart_tx_o : out STD_LOGIC);
end ai_player;

architecture Behavioral of ai_player is

begin


end Behavioral;
