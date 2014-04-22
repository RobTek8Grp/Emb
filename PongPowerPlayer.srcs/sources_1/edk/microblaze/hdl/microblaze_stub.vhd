-------------------------------------------------------------------------------
-- microblaze_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity microblaze_stub is
  port (
    reset_i : in std_logic;
    uart_rx_i : in std_logic;
    uart_tx_o : out std_logic;
    direction_gpio_i : in std_logic_vector(1 downto 0);
    ball_position_gpio_i : in std_logic_vector(31 downto 0);
    bat_posiion_gpio_i : in std_logic_vector(15 downto 0);
    clk_i : in std_logic
  );
end microblaze_stub;

architecture STRUCTURE of microblaze_stub is

  component microblaze is
    port (
      reset_i : in std_logic;
      uart_rx_i : in std_logic;
      uart_tx_o : out std_logic;
      direction_gpio_i : in std_logic_vector(1 downto 0);
      ball_position_gpio_i : in std_logic_vector(31 downto 0);
      bat_posiion_gpio_i : in std_logic_vector(15 downto 0);
      clk_i : in std_logic
    );
  end component;

  attribute BOX_TYPE : STRING;
  attribute BOX_TYPE of microblaze : component is "user_black_box";

begin

  microblaze_i : microblaze
    port map (
      reset_i => reset_i,
      uart_rx_i => uart_rx_i,
      uart_tx_o => uart_tx_o,
      direction_gpio_i => direction_gpio_i,
      ball_position_gpio_i => ball_position_gpio_i,
      bat_posiion_gpio_i => bat_posiion_gpio_i,
      clk_i => clk_i
    );

end architecture STRUCTURE;

