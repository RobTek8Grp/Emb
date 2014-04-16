library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library mylibs;
use mylibs.mytypes.all;

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
