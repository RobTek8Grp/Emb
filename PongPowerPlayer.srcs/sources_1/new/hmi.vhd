----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2014 03:19:15 PM
-- Design Name: 
-- Module Name: hmi - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hmi is
    Port ( btn_ai_enable_i : in STD_LOGIC;
           btn_up_i : in STD_LOGIC;
           btn_down_i : in STD_LOGIC;
           ai_enable_o : out STD_LOGIC;
           up_o : out STD_LOGIC;
           down_o : out STD_LOGIC);
end hmi;

architecture Behavioral of hmi is

begin


end Behavioral;
