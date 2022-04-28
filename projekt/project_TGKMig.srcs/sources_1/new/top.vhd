library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

------------------------------------------------------------
--
-- TOP design for project
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2022 PROJECT TEAM 
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

entity top is
    Port ( CLK100MHZ : in STD_LOGIC;
           light     : in STD_LOGIC_VECTOR (2 downto 0);    -- input for RGB_LED 
           s_char    : in STD_LOGIC_VECTOR (5 downto 0);    -- input for switch
           
           -- segments of display
           
           CA      : out STD_LOGIC;                         -- up
           CB      : out STD_LOGIC;                         -- up-right
           CC      : out STD_LOGIC;                         -- down-right
           CD      : out STD_LOGIC;                         -- down
           CE      : out STD_LOGIC;                         -- down_left
           CF      : out STD_LOGIC;                         -- up-left
           CG      : out STD_LOGIC;                         -- center
           AN      : out STD_LOGIC_VECTOR (7 downto 0);     -- anods power of segments
           
           -- information for every RGB bit 
           
           LED16_R : out STD_LOGIC;                         -- RED
           LED16_G : out STD_LOGIC;                         -- GREEN
           LED16_B : out STD_LOGIC;                         -- BLUE
           
           BTNC  : in STD_LOGIC                             -- button
     );
end top;

architecture Behavioral of top is
    
    
begin

  seg_7 : entity work.vision_7seg       -- Connect segment display with data
      port map(
          char_i(0) => s_char(0),
          char_i(1) => s_char(1),
          char_i(2) => s_char(2),
          char_i(3) => s_char(3),
          char_i(4) => s_char(4),
          char_i(5) => s_char(5),
          
          clk   => CLK100MHZ,
          reset => BTNC,
          
          seg_o(6) => CA,
          seg_o(5) => CB,
          seg_o(4) => CC,
          seg_o(3) => CD,
          seg_o(2) => CE,
          seg_o(1) => CF,
          seg_o(0) => CG      
      );

   transmit : entity work.transmittor  
       port map(
          clk    => CLK100MHZ,
          reset  => BTNC,
          
          char_i(0) => s_char(0),       -- Connect switshes inputs
          char_i(1) => s_char(1),
          char_i(2) => s_char(2),
          char_i(3) => s_char(3),
          char_i(4) => s_char(4),
          char_i(5) => s_char(5),
          
          light(0) => LED16_B,          -- Connect RGB outputs with data
          light(1) => LED16_G,
          light(2) => LED16_R
      );
      
   AN(7 downto 0) <= b"1111_1110";      -- Information of power
end Behavioral;
