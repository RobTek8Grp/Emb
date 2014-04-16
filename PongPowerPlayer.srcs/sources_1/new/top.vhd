----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2014 09:32:52 AM
-- Design Name: 
-- Module Name: top - Behavioral
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
library mylibs;
use mylibs.mytypes.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port (
           -- Onboard resources
           clk_200M_i : in STD_LOGIC;
           
           
           -- Input VGA
           fx2_vga_hsync_i : in STD_LOGIC;
           fx2_vga_vsync_i : in STD_LOGIC;
           
           fx2_vga_red_clk_o : out STD_LOGIC;
           fx2_vga_red_i : in STD_LOGIC_VECTOR(9 downto 0);
           
           fx2_vga_green_clk_o : out STD_LOGIC;
           fx2_vga_green_i : in STD_LOGIC_VECTOR(9 downto 0);
           
           fx2_vga_blue_clk_o : out STD_LOGIC;
           fx2_vga_blue_i : in STD_LOGIC_VECTOR(9 downto 0);
           
           
           -- Output VGA
           j8_vga_hsync_o : out STD_LOGIC;
           j8_vga_vsync_o : out STD_LOGIC;
           j8_vga_red_o : out STD_LOGIC_VECTOR(2 downto 0);
           j8_vga_green_o : out STD_LOGIC_VECTOR(2 downto 0);
           j8_vga_blue_o : out STD_LOGIC_VECTOR(2 downto 0);
           
           
           -- UART           
           ft232h_rs232_tx_o : out STD_LOGIC;
           
           
           -- Hardware buttons
           j7_btn_i : in STD_LOGIC_VECTOR(1 downto 0);
           j7_dip_sw_i : in STD_LOGIC_VECTOR(7 downto 0) -- Used for enable signals: 0: enable_ai, 1: enable_filter
    );
end top;

architecture Behavioral of top is

    -- Global resources
    signal clock_200M : STD_LOGIC; -- DCM cleaned clock

    signal clk_100M  	  : std_logic; -- pipeline clock @ 4x pixel clock
    signal clk_100M_180	: std_logic; -- pipeline clock @ 4x pixel clock 180 degrees phase shifted
    
    signal resetn	   : std_logic;

    -- Buttons
    signal btn_up : STD_LOGIC;
    signal btn_down : STD_LOGIC;

    -- Enable control
    signal enable_ai : STD_LOGIC;
    signal enable_filter : STD_LOGIC;
    signal enable_frame_overlay : STD_LOGIC;

    -- Connections from: vga_input_1
    signal pixel_vga_input : pixelGrey;

    -- Connections from: filter_1
    signal pixel_filter : pixelBinary;
    
    -- Connection from: frame_analysis_1
    signal pixel_frame_analysis : pixelBinary;
    signal ball_velocity_frame_analysis : velocity;
    signal ball_position_frame_analysis : pixelPosition;
    signal bat_position_frame_analysis : pixelPosition;
    
    -- Connections from: frame_overlay_1
    signal pixel_frame_overlay : pixelRGB;

    -- Connections from hmi
    signal ai_enable_hmi : STD_LOGIC;
    signal up_hmi : STD_LOGIC;
    signal down_hmi : STD_LOGIC;


    component vga_input is
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
    end component;

    component filter is
        Port ( clk_200M_i : in STD_LOGIC;
               enable_i : in STD_LOGIC;
               pixel_grey_i : in pixelGrey;
               pixel_binary_o : out pixelBinary);
    end component;

    component frame_analysis is
        Port ( clock_200M_i : in STD_LOGIC;
               pixel_binary_i : in pixelBinary;
               pixel_binary_o : out pixelBinary;
               ball_velocity_o : out velocity;
               ball_position_o : out pixelPosition;
               bat_position_o : out pixelPosition);
    end component;

    component frame_overlay is
        Port ( clock_200M_i : in STD_LOGIC;
               enable_i : in STD_LOGIC;
               pixel_binary_i : in pixelBinary;
               velocity_i : in velocity;
               pixelRGB_o : out pixelRGB);
    end component;

    component vga_output is
        Port ( clk_100M_i : in STD_LOGIC;
               pixel_RGB_i : in pixelRGB;
               hsync_o : out STD_LOGIC;
               vsync_o : out STD_LOGIC;
               r_channel_o : out STD_LOGIC_VECTOR(2 downto 0);
               g_channel_o : out STD_LOGIC_VECTOR(2 downto 0);
               b_channel_o : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    component ai_player is
        Port ( ball_position_i : in pixelPosition;
               bat_position_i : in pixelPosition;
               bat_control_key_up_i : in STD_LOGIC;
               bat_control_key_down_i : in STD_LOGIC;
               ai_enable : in STD_LOGIC;
               uart_tx_o : out STD_LOGIC);
    end component;
    
    component hmi is
        Port ( btn_ai_enable_i : in STD_LOGIC;
               btn_up_i : in STD_LOGIC;
               btn_down_i : in STD_LOGIC;
               ai_enable_o : out STD_LOGIC;
               up_o : out STD_LOGIC;
               down_o : out STD_LOGIC);
    end component;


begin
    -- Hardware button and switch mapping
    btn_up <= j7_btn_i(0);
    btn_down <= j7_btn_i(1);
    enable_ai <= j7_dip_sw_i(0);
    enable_filter <= j7_dip_sw_i(1);

--    DCM_CLKGEN_inst : DCM_CLKGEN
--    generic map (
--        CLKFXDV_DIVIDE 	=> 2,       	-- CLKFXDV divide value (2, 4, 8, 16, 32)
--        CLKFX_DIVIDE 		=> 143,       	-- Divide value - D - (1-256)
--        CLKFX_MD_MAX		=> 0.251748,  	-- Specify maximum M/D ratio for timing anlysis
--        CLKFX_MULTIPLY 	=> 72,       	-- Multiply value - M - (2-256)
--        CLKIN_PERIOD 		=> 5.0,       	-- Input clock period specified in nS
--        SPREAD_SPECTRUM 	=> "NONE", 		-- Spread Spectrum mode "NONE", "CENTER_LOW_SPREAD", "CENTER_HIGH_SPREAD",
--                                                    -- "VIDEO_LINK_M0", "VIDEO_LINK_M1" or "VIDEO_LINK_M2" 
--        STARTUP_WAIT 		=> FALSE      	-- Delay config DONE until DCM_CLKGEN LOCKED (TRUE/FALSE)
--    )
--    port map (
--        CLKFX 		=> clk_100M,  		-- 1-bit output: Generated clock output
--        CLKFX180 	=> clk_100M_180,   	-- 1-bit output: Generated clock output 180 degree out of phase from CLKFX.
--        CLKFXDV 		=> open,			-- 1-bit output: Divided clock output
--        LOCKED 		=> resetn,     -- 1-bit output: Locked output
--        PROGDONE 	=> open,   		-- 1-bit output: Active high output to indicate the successful re-programming
--        STATUS 		=> open,     	-- 2-bit output: DCM_CLKGEN status
--        CLKIN 		=> clk_200M_i,	-- 1-bit input: Input clock
--        FREEZEDCM 	=> '0', 			-- 1-bit input: Prevents frequency adjustments to input clock
--        PROGCLK 		=> '0',    		-- 1-bit input: Clock input for M/D reconfiguration
--        PROGDATA 	=> '0',   		-- 1-bit input: Serial data input for M/D reconfiguration
--        PROGEN 		=> '0',     	-- 1-bit input: Active high program enable
--        RST 			=> '0'         -- 1-bit input: Reset input pin
--	);

    vga_input_1 : vga_input
    port map (
           clk_100M_i => clk_100M,
           vsync_in => fx2_vga_vsync_i,
           hsync_in => fx2_vga_hsync_i,
           r_channel_i => fx2_vga_red_i,
           r_clock_o => fx2_vga_red_clk_o,
           g_channel_i => fx2_vga_green_i,
           g_clock_o => fx2_vga_green_clk_o,
           b_channel_i => fx2_vga_blue_i,
           b_clock_o => fx2_vga_blue_clk_o,
           pixel_grey_o => pixel_vga_input
    );
    
    filter_1 : filter
    port map (
            clk_200M_i => clock_200M,
            enable_i => enable_filter,
            pixel_grey_i => pixel_vga_input,
            pixel_binary_o => pixel_filter
    );
    
    frame_analysis_1 : frame_analysis
    port map (
            clock_200M_i => clock_200M,
            pixel_binary_i => pixel_filter,
            pixel_binary_o => pixel_frame_analysis,
            ball_velocity_o => ball_velocity_frame_analysis,
            ball_position_o => ball_position_frame_analysis,
            bat_position_o => bat_position_frame_analysis
    );
    
    frame_overlay_1 : frame_overlay
    port map (
            clock_200M_i => clock_200M,
            enable_i => enable_frame_overlay,
            pixel_binary_i => pixel_frame_analysis,
            velocity_i => ball_velocity_frame_analysis,
            pixelRGB_o => pixel_frame_overlay
    );
    
    vga_output_1 : vga_output
    port map (
            clk_100M_i => clk_100M,
            pixel_RGB_i => pixel_frame_overlay,
            hsync_o => j8_vga_hsync_o,
            vsync_o => j8_vga_vsync_o,
            r_channel_o => j8_vga_red_o,
            g_channel_o => j8_vga_green_o,
            b_channel_o => j8_vga_blue_o
    );
    
    ai_player_1 : ai_player
    port map (
            ball_position_i => ball_position_frame_analysis,
            bat_position_i => bat_position_frame_analysis,
            bat_control_key_up_i => up_hmi,
            bat_control_key_down_i => down_hmi,
            ai_enable => enable_ai,
            uart_tx_o => ft232h_rs232_tx_o
    );
    
    hmi_1 : hmi
    port map (
            btn_ai_enable_i => enable_ai,
            btn_up_i => btn_up,
            btn_down_i => btn_down,
            ai_enable_o => ai_enable_hmi,
            up_o => up_hmi,
            down_o => down_hmi
    );
    
end Behavioral;
