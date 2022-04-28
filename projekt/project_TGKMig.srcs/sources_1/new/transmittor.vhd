---------------------------
--
-- Transmittor using FSM.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2022 PROJECT TEAM 
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for transmittor
------------------------------------------------------------
entity transmittor is
    port(
        clk         : in     std_logic;                     -- Main clock
        reset       : in     std_logic;                     -- Synchronous reset
        char_i      : in     std_logic_vector(5 downto 0);  -- input data in binary from swithes
        
        light       : out    std_logic_vector(2 downto 0)   --  output data in 3 bit (RGB)
    );
end entity transmittor;

------------------------------------------------------------
-- Architecture declaration for transmittor
------------------------------------------------------------
architecture Behavioral of transmittor is

------------------------------------------------------------
-- Local signals
------------------------------------------------------------

    signal count_local : integer := 0;                                     -- counter of bits, that will display
    signal s_en        : std_logic;                                        -- Synchronous by real time
    signal light_temp  : std_logic;                                        -- information of bits, that will display
    signal length_i    : integer range 0 to 20:= 20;                       -- Lenght of moorse code
    signal temp        : std_logic_vector(20 downto 0);                    -- output data in morse code
    
    constant DOT	   : std_logic_vector(1 downto 0)  := "10";		       -- parametr of DOT ( . )
	constant DASH      : std_logic_vector(3 downto 0)  := "1110";		   -- parametr of DASH ( _ )
	constant ZERO      : std_logic_vector(20 DOWNTO 0) := (others => '0'); -- parametr for clean all non-used data in "temp"

    constant c_Light   : std_logic_vector(2 downto 0)  := b"111";          -- RGB parametr 'White'
    constant c_None    : std_logic_vector(2 downto 0)  := b"000";          -- RGB parametr 'nothing' 
    

begin
clk_en0 : entity work.clock_enable                                         -- Taking variables from clock_enable design
        generic map(
           g_MAX => 25000000 -- 250 ms / (1/100 MHz)                       -- Timing control 
        )
       port map(                                                            
           clk   => clk,                                                    
           reset => reset,
           ce_o  => s_en
        );

  p_clocking : process(char_i, clk, reset)                                  -- The process for changing binary into moorse
 
    begin
        if rising_edge(clk) then                                            -- synchronise whith clock
            if (reset = '1') then   -- Synchronous reset
                length_i <= 0;                                              -- clean all variables
			    temp     <= ZERO(20 downto 0);
            else 

                
                case char_i is                                               -- library input -> output
                when "001010"  => 
                    length_i<=6 ; -- DOT=2, DASH=4 ( 2 + 4 = 6 )
					temp <= DOT & DASH & ZERO(20-6 downto 0); -- A
					
				when "001011"  => 
				    length_i <= 10;
					temp <= DASH & DOT & DOT & DOT & ZERO(20-10 downto 0); -- B
					
				when "001100"  => 
				    length_i<=12;
					temp <= DASH & DOT & DASH & DOT & ZERO(20-12 downto 0); -- C
					
				when "001101"  => 
				    length_i<=8; 
					temp <= DASH & DOT & DOT & ZERO(20-8 downto 0); -- D
					
				when "001110"  => 
				    length_i<=2 ; 
					temp <= DOT & ZERO(20-2 downto 0); -- E
					
				when "001111"  => 
				    length_i<=10; 
					temp <= DOT & DOT & DASH & DOT & ZERO(20-10 downto 0); -- F
					
				when "010000"  => 
				    length_i<=10; 
					temp <= DASH & DASH & DOT & ZERO(20-10 downto 0); -- G
					
				when "010001"  => 
				    length_i<=8; 
					temp <= DOT & DOT & DOT & DOT & ZERO(20-8 downto 0); -- H
					
				when "010010"  => 
				    length_i<=4 ; 
					temp <= DOT & DOT & ZERO(20-4 downto 0); -- I
					
				when "010011"  => 
				    length_i<=14; 
					temp <= DOT & DASH & DASH & DASH & ZERO(20-14 downto 0); -- J
					
				when "010100"  => 
				    length_i<=10; 
					temp <= DASH & DOT & DASH & ZERO(20-10 downto 0); -- K
					
				when "010101"  => 
				    length_i<=10; 
					temp <= DOT & DASH & DOT & DOT & ZERO(20-10 downto 0); -- L 					
					
				when "010110"  => 
				    length_i<=8; 
					temp <= DASH & DASH & ZERO(20-8 downto 0); -- M
					
				when "010111"  => 
				    length_i<=6 ;  
					temp <= DASH & DOT & ZERO(20-6 downto 0); -- N
					
				when "011000"  => 
				    length_i<=12; 
					temp <= DASH & DASH & DASH & ZERO(20-12 downto 0); -- O
					
				when "011001"  => 
				    length_i<=12; 
					temp <= DOT & DASH & DASH & DOT & ZERO(20-12 downto 0); -- P
					
				when "011010"  => 
				    length_i<=14; 
					temp <= DASH & DASH & DOT & DASH & ZERO(20-14 downto 0); -- Q
					
				when "011011"  => 
				    length_i<=8; 
					temp <= DOT & DASH & DOT & ZERO(20-8 downto 0); -- R
				
				when "011100"  => 
				    length_i<=6 ; 
					temp <= DOT & DOT & DOT & ZERO(20-6 downto 0); -- S
					
				when "011101"  => 
				    length_i<=4 ; 
					temp <= DASH & ZERO(20-4 downto 0); -- T
					
				when "011110"  => 
				    length_i<=8; 
					temp <= DOT & DOT & DASH & ZERO(20-8 downto 0); -- U
					
				when "011111"  => 
				    length_i<=10; 
					temp <= DOT & DOT & DOT & DASH & ZERO(20-10 downto 0); -- V
					
				when "100000"  => 
				    length_i<=10; 
					temp <= DOT & DASH & DASH & ZERO(20-10 downto 0); -- W
				
				when "100001"  => 
				    length_i<=12; 
					temp <= DASH & DOT & DOT & DASH & ZERO(20-12 downto 0); -- X
					
				when "100010"  => 
				    length_i<=14; 
					temp <= DASH & DOT & DASH & DASH & ZERO(20-14 downto 0); -- Y
					
				when "100011"  => 
				    length_i<=12; 
					temp <= DASH & DASH & DOT & DOT & ZERO(20-12 downto 0); -- Z

				when "000000"  => 
				    length_i<=20; 
					temp <= DASH & DASH & DASH & DASH & DASH & ZERO(20-20 downto 0); -- 0

				when "000001"  => 
				    length_i<=18; 
					temp <= DOT & DASH & DASH & DASH & DASH & ZERO(20-18 downto 0); -- 1

				when "000010"  => 
				    length_i<=16; 
					temp <= DOT & DOT & DASH & DASH & DASH & ZERO(20-16 downto 0); -- 2

				when "000011"  => 
				    length_i<=14; 
					temp <= DOT & DOT & DOT & DASH & DASH & ZERO(20-14 downto 0); -- 3

				when "000100"  => 
				    length_i<=12; 
					temp <= DOT & DOT & DOT & DOT & DASH & ZERO(20-12 downto 0); -- 4

				when "000101"  => 
				    length_i<=10; 
					temp <= DOT & DOT & DOT & DOT & DOT & ZERO(20-10 downto 0); -- 5

				when "000110"  => 
				    length_i<=12; 
					temp <= DASH & DOT & DOT & DOT & DOT & ZERO(20-12 downto 0); -- 6

				when "000111"  =>
				    length_i<=14; 
					temp <= DASH & DASH & DOT & DOT & DOT & ZERO(20-14 downto 0); -- 7

				when "001000"  =>
				    length_i<=16; 
					temp <= DASH & DASH & DASH & DOT & DOT & ZERO(20-16 downto 0); -- 8

				when "001001"  => 
				    length_i<=18; 
					temp <= DASH & DASH & DASH & DASH & DOT & ZERO(20-18 downto 0); -- 9

				when others =>    -- for input data more then "100100"
				    length_i<=0; 
					temp <= ZERO(20 downto 0);
            end case;
        end if;
    end if;
 end process p_clocking;
 
 
  p_lighter : process(clk)          -- The process, that count all bits of temp
  begin                             -- and display every when clk up
    if rising_edge(clk) then  
            if (reset = '1') then   
                count_local <= 20;
                light <= c_None;
            elsif (s_en = '1') then
                    
                if (count_local > 20-length_i) then
                    light_temp <= temp(count_local);
                    count_local <= count_local - 1;
                    if  (light_temp = '1') then
                        light <= c_Light;
                    else
                        light <= c_None;
                    end if; 
                 else 
                     light <= c_None;   
                 end if;           
            end if;
    end if;
  end process p_lighter;
    --------------------------------------------------------
    -- p_output_fsm:
    -- The combinatorial process is sensitive to state
    -- changes and sets the output signals accordingly.
    -- This is an example of a Moore state machine and
    -- therefore the output is set based on the active state.
    --------------------------------------------------------
    
end architecture Behavioral;
