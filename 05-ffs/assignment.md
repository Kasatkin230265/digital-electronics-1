# Lab 5: Alexey Kasatkin ID: 230265

### Flip-flops

1. Listing of VHDL architecture for T-type flip-flop. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
architecture Behavioral of t_ff_rst is
    signal s_q : std_logic;
begin
    --------------------------------------------------------
    -- p_t_ff_rst:
    -- T type flip-flop with a high-active sync reset,
    -- rising-edge clk.
    -- q(n+1) = t./q(n) + /t.q(n)
    --------------------------------------------------------
    p_t_ff_rst : process(clk)
    begin

       if (rst = '1') then 
               s_q <= '0';
            elsif (t = '0') then
               s_q <= s_q;
            else 
               s_q <= not s_q;
            end if;
        end if;

    end process p_t_ff_rst;

    q     <= s_q;
    q_bar <= not s_q;
end architecture Behavioral;
```

2. Screenshot with simulated time waveforms. Try to simulate both flip-flops in a single testbench with a maximum duration of 200 ns, including reset. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![image](https://user-images.githubusercontent.com/99397789/157655402-94c8f9ba-6cb5-45fd-b9d5-72b627c7571c.png)

### Shift register

1. Image of the shift register `top` level schematic. The image can be drawn on a computer or by hand. Always name all inputs, outputs, components and internal signals!

  ![image](https://user-images.githubusercontent.com/99397789/158674455-7b5f1e7a-5080-4b0c-8e5a-bd886df1f8f1.png)

