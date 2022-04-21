------------------------------------------------------------
--
-- Traffic light controller using FSM.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
-- This code is inspired by:
-- [1] LBEbooks, Lesson 92 - Example 62: Traffic Light Controller
--     https://www.youtube.com/watch?v=6_Rotnw1hFM
-- [2] David Williams, Implementing a Finite State Machine in VHDL
--     https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
-- [3] VHDLwhiz, One-process vs two-process vs three-process state machine
--     https://vhdlwhiz.com/n-process-state-machine/
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

    -- Define the states
    type t_stat is ( zero,
                     one,
                     two,
                     three,
                     four,
                     five,
                     six,
                     seven,
                     eight,
                     nine,
                     A,
                     B,
                     C,
                     D,
                     E,
                     F,
                     G,
                     H,
                     I,
                     K,
                     L,
                     M,
                     N,
                     O,
                     P,
                     Q,
                     R,
                     S,
                     T,
                     U,
                     GALOCHKA,
                     W,
                     X,
                     Y,
                     SVASTIKA
                     );
    -- Define the signal that uses different state
    signal s_stat : t_stat;

    -- Internal clock enable
    signal s_en : std_logic;
    signal length_i: integer range 0 to 17:= 0;
    signal temp: std_logic_vector(17 downto 0); 

    -- Local delay counter
    signal s_cnt : unsigned(4 downto 0);
    signal s_next : unsigned(5 downto 0);

    -- Specific values for local counter
    
       constant DOT	: std_logic_vector(1 downto 0):="10";		
	constant DASH	: std_logic_vector(3 downto 0):="1110";		
	constant ZERO	: std_logic_vector (17 DOWNTO 0):=(others => '0');

    -- Output values
    constant c_Light       : std_logic_vector(2 downto 0) := b"111";
    
begin

    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 250 ms (4 Hz). Remember that 
    -- the frequency of the clock signal is 100 MHz.
    
    -- USE THIS PART FOR FASTER/SHORTER SIMULATION
--    s_en <= '1';
    -- USE THE FOLLOWING PART FOR THE IMPLEMENTATION
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 25000000 -- 250 ms / (1/100 MHz)
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
           
        );

    --------------------------------------------------------
    -- p_traffic_fsm:
    -- The sequential process with synchronous reset and 
    -- clock_enable entirely controls the s_state signal by 
    -- CASE statement.
    --------------------------------------------------------
    p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then   -- Synchronous reset
                s_stat <= space;   -- Set initial state
                s_cnt   <= c_DELAY_zero;  -- Clear delay counter
                    
            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_stat is
                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when "001010"  => length_i<=9 ; 
					temp <= DOT & DASH & ZERO(17-9 downto 0); -- A
					
				when X"32"  => length_i<=13;
					temp <= DASH & DOT & DOT & DOT & ZERO(17-13 downto 0); -- B
					
				when X"21"  => length_i<=15; 
					temp <= DASH & DOT & DASH & DOT & ZERO(17-15 downto 0); -- C
					
				when X"23"  => length_i<=11; 
					temp <= DASH & DOT & DOT & ZERO(17-11 downto 0); -- D
					
				when X"24"  => length_i<=5 ; 
					temp <= DOT & ZERO(17-5 downto 0); -- E
					
				when X"2B"  => length_i<=13; 
					temp <= DOT & DOT & DASH & DOT & ZERO(17-13 downto 0); -- F
					
				when X"34"  => length_i<=13; 
					temp <= DASH & DASH & DOT & ZERO(17-13 downto 0); -- G
					
				when X"33"  => length_i<=11; 
					temp <= DOT & DOT & DOT & DOT & ZERO(17-11 downto 0); -- H
					
				when X"43"  => length_i<=7 ; 
					temp <= DOT & DOT & ZERO(17-7 downto 0); -- I
					
				when X"3B"  => length_i<=17; 
					temp <= DOT & DASH & DASH & DASH & ZERO(17-17 downto 0); -- J
					
				when X"42"  => length_i<=13; 
					temp <= DASH & DOT & DASH & ZERO(17-13 downto 0); -- K
					
				when X"4B"  => length_i<=13; 
					temp <= DOT & DASH & DOT & DOT & ZERO(17-13 downto 0); -- L						
					
				when X"3A"  => length_i<=11; 
					temp <= DASH & DASH & ZERO(17-11 downto 0); -- M
					
				when X"31"  => length_i<=9 ; 
					temp <= DASH & DOT & ZERO(17-9 downto 0); -- N
					
				when X"44"  => length_i<=15; 
					temp <= DASH & DASH & DASH & ZERO(17-15 downto 0); -- O
					
				when X"4D"  => length_i<=15; 
					temp <= DOT & DASH & DASH & DOT & ZERO(17-15 downto 0); -- P
					
				when X"15"  => length_i<=17; 
					temp <= DASH & DASH & DOT & DASH & ZERO(17-17 downto 0); -- Q
					
				when X"2D"  => length_i<=11; 
					temp <= DOT & DASH & DOT & ZERO(17-11 downto 0); -- R
					
				when X"1B"  => length_i<=9 ; 
					temp <= DOT & DOT & DOT & ZERO(17-9 downto 0); -- S
					
				when X"2C"  => length_i<=7 ; 
					temp <= DASH & ZERO(17-7 downto 0); -- T
					
				when X"3C"  => length_i<=11; 
					temp <= DOT & DOT & DASH & ZERO(17-11 downto 0); -- U
					
				when X"2A"  => length_i<=13; 
					temp <= DOT & DOT & DOT & DASH & ZERO(17-13 downto 0); -- V
					
				when X"1D"  => length_i<=13; 
					temp <= DOT & DASH & DASH & ZERO(17-13 downto 0); -- W
					
				when X"22"  => length_i<=15; 
					temp <= DASH & DOT & DOT & DASH & ZERO(17-15 downto 0); -- X
					
				when X"35"  => length_i<=17; 
					temp <= DASH & DOT & DASH & DASH & ZERO(17-17 downto 0); -- Y
					
				when X"1A"  => length_i<=15; 
					temp <= DASH & DASH & DOT & DOT & ZERO(17-15 downto 0); -- Z	
					
				when others => length_i<=0; 
					temp <= ZERO(17 downto 0);
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
    p_output_fsm : process(s_stat)
    begin
        case s_stat is
                     when zero =>
                     
                     when one =>
                     
                     when two =>
                     
                     when three =>
                     when four =>
                     when five =>
                     when six =>
                     when seven =>
                     when eight =>
                     when nine =>
                     when A =>
                     when B =>
                     when C =>
                     when D =>
                     when E =>
                     when F =>
                     when G =>
                     when H =>
                     when I =>
                     when K =>
                     when L =>
                     when M =>
                     when N =>
                     when O =>
                     when P =>
                     when Q =>
                     when R =>
                     when S =>
                     when T =>
                     when U =>
                     when GALOCHKA =>
                     when W =>
                     when X =>
                     when Y =>
                     when SVASTIKA =>
        end case;
    end process p_output_fsm;

end architecture Behavioral;
