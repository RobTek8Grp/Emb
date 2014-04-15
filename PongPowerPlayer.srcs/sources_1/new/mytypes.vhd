library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library mylibs;
use mylibs.log_pkg.all;

package mytypes is 

    -- Position
    type pixelPosition is
    record
        hpos :std_logic_vector(log2i(640)-1 downto 0);
        vpos :std_logic_vector(log2i(480)-1 downto 0);
    end record;

    -- Pixel types
    subtype pixelIntensity is std_logic_vector(2 downto 0);

    type pixelHeader is
    record
        pos : pixelPosition;
        hsync :std_logic;
        vsync :std_logic;
    end record;

    type pixelGrey is 
    record
        header : pixelHeader;
        intensity : pixelIntensity;
    end record;
    
    type pixelBinary is
    record
        header : pixelHeader;
        isWhite : std_logic;    
    end record;
    
    type pixelRGB is
    record
        header : pixelHeader;
        intensity_red : pixelIntensity;
        intensity_green : pixelIntensity;
        intensity_blue : pixelIntensity;
    end record;
    

    -- Velocity
    subtype velocity is pixelIntensity; -- Use full resolution on pixel

    
end mytypes;
package body mytypes is
 
end mytypes;