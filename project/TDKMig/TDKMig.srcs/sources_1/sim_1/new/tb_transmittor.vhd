----------------------------------------------------------------------------------


---------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_transmittor is
        port(
        clk     : in  std_logic       
    );
end entity tb_transmittor;

architecture testbench of tb_transmittor is

    signal s_char    : std_logic_vector(6 - 1 downto 0);
    signal reset     : std_logic;
    signal temp      : std_logic_vector(20 downto 0);
        
begin
    clk_en0 : entity work.transmittor
        port map(
            clk => clk,
            char_i => s_char,
            reset => reset,
            temp => temp
        );
p_sosat : process
begin
        s_char <= "000010";
        
        reset <= '1';
            wait for 23 ns;
        reset <= '0';
               
        wait;
end process p_sosat;     
end testbench;
