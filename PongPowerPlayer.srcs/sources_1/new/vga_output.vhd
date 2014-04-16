----------------------------------------------------------------------------------
--
-- This file is based on and inspired by the work of Anders Blaabjerg Lange from Univerity of Southern Denmark
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library mylibs;
use mylibs.mytypes.all;

entity vga_output is
    Port ( clk_100M_i : in STD_LOGIC;
           pixel_RGB_i : in pixelRGB;
           hsync_o : out STD_LOGIC;
           vsync_o : out STD_LOGIC;
           r_channel_o : out STD_LOGIC_VECTOR(2 downto 0);
           g_channel_o : out STD_LOGIC_VECTOR(2 downto 0);
           b_channel_o : out STD_LOGIC_VECTOR(2 downto 0));
end vga_output;

architecture Behavioral of vga_output is
    signal r_channel : STD_LOGIC_VECTOR(2 downto 0) := (others=>'0');
    signal g_channel : STD_LOGIC_VECTOR(2 downto 0) := (others=>'0');
    signal b_channel : STD_LOGIC_VECTOR(2 downto 0) := (others=>'0');
    signal hsync : STD_LOGIC := '0';
    signal vsync : STD_LOGIC := '0';

begin
    -- Connect outputs
    hsync_o <= hsync;
    vsync_o <= vsync;
    r_channel_o <= r_channel;
    g_channel_o <= g_channel;
    b_channel_o <= b_channel;

    -- Clock controlled output
    output_vga : process(clk_100M_i) -- Clock can be changed to 25MHz
    begin
        if rising_edge(clk_100M_i) then
            r_channel <= pixel_RGB_i.intensity_red;
            g_channel <= pixel_RGB_i.intensity_green;
            b_channel <= pixel_RGB_i.intensity_blue;
            hsync <= pixel_RGB_i.header.hsync;
            vsync <= pixel_RGB_i.header.vsync;            
        end if;      
    end process;

end Behavioral;
