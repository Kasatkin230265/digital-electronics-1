# Lab 2: YOUR_FIRSTNAME LASTNAME

### 2-bit comparator

1. Karnaugh maps for other two functions:

   Greater than:

   ![image](https://user-images.githubusercontent.com/99397789/154457659-2a682dc5-68ac-4a7d-a6d5-d6f43754d34b.png)

   Less than:

   ![image](https://user-images.githubusercontent.com/99397789/154458498-b14fb12d-1fae-400c-a902-39ab372a8ba3.png)

2. Equations of simplified SoP (Sum of the Products) form of the "greater than" function and simplified PoS (Product of the Sums) form of the "less than" function.

   ![image](https://user-images.githubusercontent.com/99397789/155310020-d376316b-de95-47e6-a4a9-9d7014a748f0.png)

### 4-bit comparator

1. Listing of VHDL stimulus process from testbench file (`testbench.vhd`) with at least one assert (use BCD codes of your student ID digits as input combinations). Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

   Last two digits of my student ID: **xxxx??**

```vhdl
    p_stimulus : process
    begin
        -- Report a note at the beginning of stimulus process
        report "Stimulus process started" severity note;

        -- First test case
        
        --INPUT PARAMETRS BY MY ID: 230265
                s_b <= "0110"; --6
                s_a <= "0101"; --5
                wait for 100 ns;
        assert ((s_B_greater_A = '1') and
                (s_B_equals_A  = '0') and
                (s_B_less_A    = '0'))
        report "Input combination 0110, 0101 FAILED" severity error;

        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

2. Text console screenshot during your simulation, including reports.

   ![image](https://user-images.githubusercontent.com/99397789/154531026-45b052fe-6c45-4ec8-98b0-1f5e8861e07c.png)

3. Link to your public EDA Playground example:

   [https://www.edaplayground.com/x/cVBS]
