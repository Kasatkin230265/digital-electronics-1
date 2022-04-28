---------------------------
--
-- vision_7segment using FSM.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2022 PROJECT TEAM 
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vision_7seg is                               
    Port ( 
        clk    : in std_logic;
        reset  : in std_logic;
        char_i : in std_logic_vector(5 downto 0);
        
        seg_o  : out std_logic_vector(6 downto 0)   -- output data where every bit is calling his segment
    );                                              -- A-6; B-5; C-4; D-3; E-2; F-1; G-0;
end vision_7seg;

architecture Behavioral of vision_7seg is

begin

uut_transmittor : entity work.transmittor     
    port map(
        clk    => clk,
        reset  => reset,
        char_i => char_i
    );
    
    

p_7seg_decoder : process(char_i)             --process for decode binary data into 7-segment 
    begin
        case char_i is                       --library input -> output
            when "000000" =>
                seg_o <= "0000001"; -- 0
            when "000001" =>
                seg_o <= "1001111"; -- 1
            when "000010" =>
                seg_o <= "0010010"; -- 2
            when "000011" =>      
                seg_o <= "0000110"; -- 3
            when "000100" =>
                seg_o <= "1001100"; -- 4
            when "000101" =>            
                seg_o <= "0100100"; -- 5
            when "000110" =>
                seg_o <= "0100000"; -- 6
            when "000111" =>
                seg_o <= "0001111"; -- 7
            when "001000" =>
                seg_o <= "0000000"; -- 8
            when "001001" =>
                seg_o <= "0000100"; -- 9
            when "001010" =>
                seg_o <= "0001000"; -- A0001000
            when "001011" =>
                seg_o <= "1100000"; -- b1100000
            when "001100" =>
                seg_o <= "0110001"; -- C0110001
            when "001101" =>
                seg_o <= "1000010"; -- d1000010
            when "001110" =>
                seg_o <= "0110000"; -- E0110000
            when "001111" =>
                seg_o <= "0111000"; -- F0111000
            when "010000" =>
                seg_o <= "0100001"; -- G0100001
            when "010001" =>
                seg_o <= "1101000"; -- H1101000
            when "010010" =>
                seg_o <= "1101111"; -- I1101111
            when "010011" =>
                seg_o <= "1000011"; -- J1000011
            when "010100" =>
                seg_o <= "0101000"; -- K0101000
            when "010101" =>
                seg_o <= "1110001"; -- L1110001
            when "010110" =>
                seg_o <= "0101010"; -- M0101010
            when "010111" =>
                seg_o <= "1101010"; -- N1101010
            when "011000" =>
                seg_o <= "1100010"; -- O1100010
            when "011001" =>
                seg_o <= "0011000"; -- P0011000
            when "011010" =>
                seg_o <= "0001100"; -- Q0001100
            when "011011" =>
                seg_o <= "1111010"; -- R1111010
            when "011100" =>
                seg_o <= "0100100"; -- S0100100
            when "011101" =>
                seg_o <= "1110000"; -- T1110000
            when "011110" =>
                seg_o <= "1000001"; -- U1000001
            when "011111" =>
                seg_o <= "1100011"; -- V1100011
            when "100000" =>
                seg_o <= "1010100"; -- W1010100
            when "100001" =>
                seg_o <= "1001000"; -- X1001000
            when "100010" =>
                seg_o <= "1000100"; -- Y1000100
            when others =>
                seg_o <= "0010010"; -- Z0010010
        end case;
    end process p_7seg_decoder;
end architecture Behavioral;

