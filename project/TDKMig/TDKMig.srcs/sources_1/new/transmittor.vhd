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
    

    -- Local delay counter
    signal s_cnt : unsigned(4 downto 0);
    signal s_next : unsigned(5 downto 0);

    -- Specific values for local counter
    constant c_DELAY_dash  : unsigned(4 downto 0) := b"0_0100";
    constant c_DELAY_dot   : unsigned(4 downto 0) := b"0_0010";
    constant c_DELAY_space : unsigned(4 downto 0) := b"0_0010";
    constant c_DELAY_zero  : unsigned(4 downto 0) := b"0_0000";

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
                    when zero =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_dash) then    
                            s_cnt <= s_cnt + 1;
                            s_next <= s_next + 1;
                        else 
                            s_cnt<=c_DELAY_zero;
                        end if;
                        if (s_cnt+s_next < c_DELAY_space) then    
                            s_cnt <= s_cnt + 1;
                            s_next <= s_next + 1;
                        else 
                            s_cnt<=c_DELAY_zero;
                        end if;
                        if
                            (s_cnt+s_next < c_DELAY_dash) then    
                            s_cnt <= s_cnt + 1;
                            s_next <= s_next + 1;
                        else 
                            s_cnt<=c_DELAY_zero;
                        end if;
                        if
                            (s_cnt+s_next < c_DELAY_space) then    
                            s_cnt <= s_cnt + 1;
                            s_next <= s_next + 1;
                        else 
                            s_cnt<=c_DELAY_zero;
                        end if;
                        if
                            (s_cnt+s_next < c_DELAY_dash) then    
                            s_cnt <= s_cnt + 1;
                            s_next <= s_next + 1;
                        else 
                            s_cnt<=c_DELAY_zero;
                        end if;
                        if 
                            (s_cnt+s_next < c_DELAY_space) then    
                            s_cnt <= s_cnt + 1;
                            s_next <= s_next + 1;
                        else 
                            s_cnt<=c_DELAY_zero;
                        end if;
                        if
                            (s_cnt+s_next < c_DELAY_dash) then    
                            s_cnt <= s_cnt + 1;  
                            s_next <= s_next + 1;  
                        else 
                            s_cnt<=c_DELAY_zero;
                        end if;
                        if 
                            (s_cnt+s_next < c_DELAY_space) then    
                            s_cnt <= s_cnt + 1;   
                            s_next <= s_next + 1;
                        else 
                            s_cnt<=c_DELAY_zero;
                        end if; 
                        if
                            (s_cnt+s_next < c_DELAY_dash) then    
                            s_cnt <= s_cnt + 1;
                            s_next <= c_DELAY_zero;
                        else 
                            s_cnt<=c_DELAY_zero;
                        end if;
                       
--                    when WEST_GO =>
--                        if (s_cnt < c_DELAY_4SEC) then
--                            s_cnt <= s_cnt + 1;
--                        else
--                            -- Move to the next state
--                            s_state <= WEST_WAIT;
--                            -- Reset local counter value
--                            s_cnt <= c_ZERO;
--                        end if;
                        
--                     when WEST_WAIT =>
--                        if (s_cnt < c_DELAY_2SEC) then
--                            s_cnt <= s_cnt + 1;
--                        else
--                            -- Move to the next state
--                            s_state <= STOP2;
--                            -- Reset local counter value
--                            s_cnt <= c_ZERO;
--                        end if;
                        
--                     when STOP2 =>
--                        if (s_cnt < c_DELAY_1SEC) then
--                            s_cnt <= s_cnt + 1;
--                        else
--                            -- Move to the next state
--                            s_state <= SOUTH_GO;
--                            -- Reset local counter value
--                            s_cnt <= c_ZERO;
--                        end if;
                        
--                     when SOUTH_GO =>
--                        if (s_cnt < c_DELAY_4SEC) then
--                            s_cnt <= s_cnt + 1;
--                        else
--                            -- Move to the next state
--                            s_state <= SOUTH_WAIT;
--                            -- Reset local counter value
--                            s_cnt <= c_ZERO;
                        
                             
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made.
                    when others =>
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= STOP1;
                            s_cnt   <= c_ZERO;
                        end if;
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
