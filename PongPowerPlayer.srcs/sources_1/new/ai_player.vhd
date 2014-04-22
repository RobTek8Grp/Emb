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
    Port ( 
            clock_200M_i : in STD_LOGIC;
            ai_enable : in STD_LOGIC;
            ball_position_i : in pixelPosition;
            bat_position_i : in pixelPosition;
            bat_control_key_up_i : in STD_LOGIC;
            bat_control_key_down_i : in STD_LOGIC;
            uart_tx_o : out STD_LOGIC
           );
end ai_player;

architecture Behavioral of ai_player is
    
    signal clk_200M : std_logic;
    signal reset : std_logic;
    
    signal uart_rx : std_logic;
    signal uart_tx : std_logic;
    
    signal direction_gpio : std_logic_vector(1 downto 0);
    signal ball_position_gpio : std_logic_vector(31 downto 0);
    signal bat_posiion_gpio : std_logic_vector(15 downto 0);

    component microblaze is
        port(
            clk_i : in std_logic;
            reset_i : in std_logic;
            
            uart_rx_i : in std_logic;
            uart_tx_o : out std_logic;
            
            direction_gpio_i : in std_logic_vector(1 downto 0);
            ball_position_gpio_i : in std_logic_vector(31 downto 0);
            bat_posiion_gpio_i : in std_logic_vector(15 downto 0)
              );
    end component;

    attribute BOX_TYPE : STRING;
    attribute BOX_TYPE of microblaze : component is "user_black_box";
    
begin
    clk_200M <= clock_200M_i;
    reset <= not ai_enable;
    ball_position_gpio <= "000000" & ball_position_i.hpos & "0000000" & ball_position_i.vpos;
    bat_posiion_gpio <= "0000000" & bat_position_i.vpos;
    direction_gpio <= bat_control_key_up_i & bat_control_key_down_i;
    uart_tx_o <= uart_tx;
    uart_rx <= '1';

    microblaze_i : microblaze
        port map (
            reset_i => reset,     -- in std_logic;
            clk_i => clk_200M,     -- in std_logic;
            uart_rx_i => uart_rx,     -- in std_logic;
            uart_tx_o => uart_tx,     -- out std_logic;
            direction_gpio_i => direction_gpio,     -- in std_logic_vector(1 downto 0);
            ball_position_gpio_i => ball_position_gpio,     -- in std_logic_vector(31 downto 0);
            bat_posiion_gpio_i => bat_posiion_gpio     -- in std_logic_vector(15 downto 0);
           );

end Behavioral;
