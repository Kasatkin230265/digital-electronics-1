# Morse code transmitte

### Team members: 
 * Bohdan Tsariuchenko(230334),
 * Kasatkin Alexey(230265),
 * Maxim Migulia(233261),
 * Dudar Oleksandra(230847)
 
 
 ### Table of contents

* [Project objectives](#objectives)
* [Hardware description](#hardware)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Video](#video)
* [References](#references)

<a name="objectives"></a>

## Project objectives
 Cílem projektu bylo navrhnout a realizovat pomocí jazyku VHDL transmitter Morseovy abecedy. Následně výsledek projektu zpracovat do README.md souboru a videoprezentace.
 Zvládli jsme to s pomocí Nexys A7 50T, který pomocí světelných signálů vysílá Morseovu abecedu
 
<a name="hardware"></a>

## Hardware description

Pro tento projek byla zvolena deska Arty A7 - 50T.
- Odkaz na stránky výrobce desky: Artix-7 FPGA Development Board: https://digilent.com/shop/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/
- Manuál: https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual?s[]=a7&s[]=50t

### Vstupy a výstupy desky Arty A7-50T:
 #### Deska Arty A7-50T 
![image](https://user-images.githubusercontent.com/99397789/165620476-2f7d7832-cb68-44a2-83ed-58c5e2ccab6a.png)

#### Popis desky
![Screenshot 2022-04-27 at 22 00 09](https://user-images.githubusercontent.com/99397789/165621336-fced49fc-9baa-4328-a7d0-ccf815420509.png)

#### Základní vstupy a výstupy
![Screenshot 2022-04-27 at 22 03 44](https://user-images.githubusercontent.com/99397789/165621801-e5263aee-a8b7-4482-8fc7-98150d2926ef.png)

#### 7-segment dispaly 
![image](https://user-images.githubusercontent.com/99397789/165799238-bac5e9f7-6941-40b5-923f-7ad3f25ca5f7.png)


<a name="modules"></a>

## VHDL modules description and simulations

![image](https://user-images.githubusercontent.com/99397789/165746149-163a47cf-953e-4efe-8f67-5cee65fef54b.png)

První design je _clock_enable_, kde se děje generování časových impulsů, na vstup přicházejí _CLK_ generovaný prknem a _BTNC_ který reaguje na stisknutí středního  tlačítka na desce a slouží pro zrušení pracovní desky a celého kódu.

```vhdl
   architecture Behavioral of clock_enable is

    -- Local counter
    signal s_cnt_local : natural;

begin

   p_clk_ena : process(clk)
   begin
        if rising_edge(clk) then    -- Synchronous process

            if (reset = '1') then   -- High active reset
                s_cnt_local <= 0;   -- Clear local counter
                ce_o        <= '0'; -- Set output to low

            elsif (s_cnt_local >= (g_MAX - 1)) then
                s_cnt_local <= 0;   -- Clear local counter
                ce_o        <= '1'; -- Generate clock enable pulse

            else
                s_cnt_local <= s_cnt_local + 1;
                ce_o        <= '0';
            end if;
        end if;
    end process p_clk_ena;

end architecture Behavioral;
   ```
   
Druhý modul - _tramsmittor_ v němž dochází ke změně výstupních signálů vzhledem k příchozím
V prvním procesu se podle zadaných dat mění variabilní _temp_, které představuje 20bitový vektor.
DOT je kombinace odpovídající bodu a DASH je kombinace odpovídající pomlčka. Z jejích součtu vychází výsledná kombinace.

```vhdl
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
```

druhy proces v temto modulu odpovída za krokovány každým bitem vystup, kde
_light_temp_ je hodnota tekujicího bitu
_light_ je 3-bitový vystup odpovidaící za stav RGB-ledky

```vhdl
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
```
tretí design sourse _vision_7seg_ obsahue kombinace, ktere podle vstupního dvoubitového signalu mění parametry 7-segmentového displeje. 

```vhdl
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
```
<a name="top"></a>

## TOP module description and simulations

![image](https://user-images.githubusercontent.com/99397789/165803029-b1055cb9-766a-43f8-a421-f6f2a4de7820.png)


<a name="video"></a>

## Video

Write your text here

<a name="references"></a>

## References

1. Write your text here.
