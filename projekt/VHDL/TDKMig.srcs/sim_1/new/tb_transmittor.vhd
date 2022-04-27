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

end entity tb_transmittor;

architecture testbench of tb_transmittor is
    constant c_MAX               : natural := 5;
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_ce         : std_logic;

    signal s_char       : std_logic_vector(6 - 1 downto 0);
    signal s_temp       : std_logic_vector(20 downto 0);

begin
    uut_transm : entity work.transmittor
        port map(
            char_i  => s_char,
            temp    => s_temp,
            reset   => s_reset,
            clk     => s_clk_100Mhz
        );
    uut_ce : entity work.clock_enable
        generic map(
            g_MAX => c_MAX
        )   -- Note that there is NO comma or semicolon between
            -- generic map section and port map section
        port map(
            clk   => s_clk_100MHz,
            reset => s_reset,
            ce_o  => s_ce
        );
        
    p_clk_gen : process
    begin
        while now < 750 ns loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                   -- Process is suspended forever
    end process p_clk_gen;

    --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 20 ns;
        
        -- Reset activated
        s_reset <= '1';
        wait for 30 ns;

        -- Reset deactivated
        s_reset <= '0';
        wait for 100ns;
        
        s_reset <= '1';
        wait for 20 ns;
        
        s_reset <= '0';
        wait for 100ns;
        
        s_reset <= '1';
        wait for 20 ns;
        
        s_reset <= '0';
        
        
        wait;
    end process p_reset_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_char <= "000010";  
        wait for 120ns;
        
        s_char <= "001110";
        wait for 120ns;
        
        s_char <= "001011";       
        wait ;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;     
end testbench;
