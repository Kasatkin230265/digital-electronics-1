---------------------------
--
-- Traffic light controller using FSM.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2022 PROJECT TEAM 
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
-- This code is inspired by:

--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for traffic light controller
------------------------------------------------------------
entity tlc is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        -- Traffic lights (RGB LEDs) for two directions
        light  : out std_logic_vector(3 - 1 downto 0)
    );
end entity tlc;

------------------------------------------------------------
-- Architecture declaration for traffic light controller
------------------------------------------------------------
architecture Behavioral of tlc is

    -- Internal clock enable
    signal s_en                : std_logic;
    signal length_i : integer range 0 to 20:= 0;
    signal counter  : integer range 0 to 20:= 0;
    signal temp     : std_logic_vector(20 downto 0); 
    signal char_i : std_logic_vector(6 downto 0);

    -- Local delay counter
    signal s_cnt    : unsigned(4 downto 0);

    -- Specific values for local counter
    
    constant DOT	               : std_logic_vector(1 downto 0):="10";		
	constant DASH                  : std_logic_vector(3 downto 0):="1110";		
	constant ZERO                  : std_logic_vector(20 DOWNTO 0):=(others => '0');

    -- Output values
    constant c_Light       : std_logic_vector(2 downto 0) := b"111";
    
begin

    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 250 ms (4 Hz). Remember that 
    -- the frequency of the clock signal is 100 MHz.
    
    -- USE THIS PART FOR FASTER/SHORTER SIMULATION
    s_en <= '1';
    -- USE THE FOLLOWING PART FOR THE IMPLEMENTATION
--    clk_en0 : entity work.clock_enable
--        generic map(
--            g_MAX => 25000000 -- 250 ms / (1/100 MHz)
--        )
--        port map(
--            clk   => clk,
--            reset => reset,
--            ce_o  => s_en
           
--        );

    --------------------------------------------------------
    -- p_traffic_fsm:
    -- The sequential process with synchronous reset and 
    -- clock_enable entirely controls the s_state signal by 
    -- CASE statement.
    --------------------------------------------------------
    p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if length_i > counter then
            
                case char_i is
                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                when "001010"  => length_i<=9 ; 
					temp <= DOT & DASH & ZERO(20-9 downto 0); -- A
					
				when "001011"  => length_i<=13;
					temp <= DASH & DOT & DOT & DOT & ZERO(20-13 downto 0); -- B
					
				when "001100"  => length_i<=15; 
					temp <= DASH & DOT & DASH & DOT & ZERO(20-15 downto 0); -- C
					
				when "001101"  => length_i<=11; 
					temp <= DASH & DOT & DOT & ZERO(20-11 downto 0); -- D
					
				when "001110"  => length_i<=5 ; 
					temp <= DOT & ZERO(20-5 downto 0); -- E
					
				when "001111"  => length_i<=13; 
					temp <= DOT & DOT & DASH & DOT & ZERO(20-13 downto 0); -- F
					
				when "010000"  => length_i<=13; 
					temp <= DASH & DASH & DOT & ZERO(20-13 downto 0); -- G
					
				when "010001"  => length_i<=11; 
					temp <= DOT & DOT & DOT & DOT & ZERO(20-11 downto 0); -- H
					
				when "010010"  => length_i<=7 ; 
					temp <= DOT & DOT & ZERO(20-7 downto 0); -- I
					
				when "010011"  => length_i<=17; 
					temp <= DOT & DASH & DASH & DASH & ZERO(20-17 downto 0); -- J
					
				when "010100"  => length_i<=13; 
					temp <= DASH & DOT & DASH & ZERO(20-13 downto 0); -- K
					
				when "010101"  => length_i<=13; 
					temp <= DOT & DASH & DOT & DOT & ZERO(20-13 downto 0); -- L						
					
				when "010110"  => length_i<=11; 
					temp <= DASH & DASH & ZERO(20-11 downto 0); -- M
					
				when "010111"  => length_i<=9 ; 
					temp <= DASH & DOT & ZERO(20-9 downto 0); -- N
					
				when "011000"  => length_i<=15; 
					temp <= DASH & DASH & DASH & ZERO(20-15 downto 0); -- O
					
				when "011001"  => length_i<=15; 
					temp <= DOT & DASH & DASH & DOT & ZERO(20-15 downto 0); -- P
					
				when "011010"  => length_i<=17; 
					temp <= DASH & DASH & DOT & DASH & ZERO(20-17 downto 0); -- Q
					
				when "011011"  => length_i<=11; 
					temp <= DOT & DASH & DOT & ZERO(20-11 downto 0); -- R
					
				when "011100"  => length_i<=9 ; 
					temp <= DOT & DOT & DOT & ZERO(20-9 downto 0); -- S
					
				when "011101"  => length_i<=7 ; 
					temp <= DASH & ZERO(20-7 downto 0); -- T
					
				when "011110"  => length_i<=11; 
					temp <= DOT & DOT & DASH & ZERO(20-11 downto 0); -- U
					
				when "011111"  => length_i<=13; 
					temp <= DOT & DOT & DOT & DASH & ZERO(20-13 downto 0); -- V
					
				when "100000"  => length_i<=13; 
					temp <= DOT & DASH & DASH & ZERO(20-13 downto 0); -- W
					
				when "100001"  => length_i<=15; 
					temp <= DASH & DOT & DOT & DASH & ZERO(20-15 downto 0); -- X
					
				when "100010"  => length_i<=17; 
					temp <= DASH & DOT & DASH & DASH & ZERO(20-17 downto 0); -- Y
					
				when "100011"  => length_i<=15; 
					temp <= DASH & DASH & DOT & DOT & ZERO(20-15 downto 0); -- Z

				when "000000"  => length_i<=20; 
					temp <= DASH & DASH & DASH & DASH & DASH & ZERO(20-20 downto 0); -- 0

				when "000001"  => length_i<=18; 
					temp <= DOT & DASH & DASH & DASH & DASH & ZERO(20-18 downto 0); -- 1

				when "000010"  => length_i<=16; 
					temp <= DOT & DOT & DASH & DASH & DASH & ZERO(20-16 downto 0); -- 2

				when "000011"  => length_i<=14; 
					temp <= DOT & DOT & DOT & DASH & DASH & ZERO(20-14 downto 0); -- 3

				when "000100"  => length_i<=12; 
					temp <= DOT & DOT & DOT & DOT & DASH & ZERO(20-12 downto 0); -- 4

				when "000101"  => length_i<=10; 
					temp <= DOT & DOT & DOT & DOT & DOT & ZERO(20-10 downto 0); -- 5

				when "000110"  => length_i<=12; 
					temp <= DASH & DOT & DOT & DOT & DOT & ZERO(20-12 downto 0); -- 6

				when "000111"  => length_i<=14; 
					temp <= DASH & DASH & DOT & DOT & DOT & ZERO(20-14 downto 0); -- 7

				when "001000"  => length_i<=16; 
					temp <= DASH & DASH & DASH & DOT & DOT & ZERO(20-16 downto 0); -- 8

				when "001001"  => length_i<=18; 
					temp <= DASH & DASH & DASH & DASH & DOT & ZERO(20-18 downto 0); -- 9

				when others => length_i<=0; 
					temp <= ZERO(20 downto 0);
                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;

    --------------------------------------------------------
    -- p_output_fsm:
    -- The combinatorial process is sensitive to state
    -- changes and sets the output signals accordingly.
    -- This is an example of a Moore state machine and
    -- therefore the output is set based on the active state.
    --------------------------------------------------------
    
end architecture Behavioral;
