# Lab 6: Alexey Kasatkin ID:230265

### Bidirectional counter

1. Listing of VHDL code of the completed process `p_cnt_up_down`. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
  --------------------------------------------------------
    -- p_cnt_up_down:
    -- Clocked process with synchronous reset which implements
    -- n-bit up/down counter.
    --------------------------------------------------------
    p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then
        
            if (reset = '1') then   -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear all bits

            elsif (en_i = '1') then -- Test if counter is enabled
              
			if (cnt_up_i = '1') then -- TEST COUNTER DIRECTION HERE
			  		s_cnt_local <= s_cnt_local + 1;
      			elsif (cnt_up_i = '0') then 
      				s_cnt_local <= s_cnt_local - 1;
    			end if;
            end if;
        end if;
    end process p_cnt_up_down;
```

2. Screenshot with simulated time waveforms. Test reset as well. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![image](https://user-images.githubusercontent.com/99397789/159757857-cb586e53-628a-47eb-852b-5a5ea23bcea3.png)

### Two counters

1. Image of the top layer structure including both counters, ie a 4-bit bidirectional counter from *Part 4* and a 16-bit counter with a 10 ms time base from *Experiments on your own*. The image can be drawn on a computer or by hand. Always name all inputs, outputs, components and internal signals!

  ![image](https://user-images.githubusercontent.com/99397789/159787353-c47ba5b9-5bc2-409d-be4b-2db365bbb71b.png)
