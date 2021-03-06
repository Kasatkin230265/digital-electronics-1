# Lab 1: Alexey Kasatkin ID: 230265

### De Morgan's laws

1. Equations of all three versions of logic function f(c,b,a):

   ![image](https://user-images.githubusercontent.com/99397789/153390173-58a75464-b424-4a78-81fb-8299575b6f9b.png)

2. Listing of VHDL architecture from design file (`design.vhd`) for all three functions. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
architecture dataflow of demorgan is
begin
    fnand_o <= (not b_i nand a_i) nand (not b_i nand not c_i);
    fnor_o  <= (b_i nor not a_i) or (b_i nor  c_i);
    fcba_o  <= (not b_i and a_i) or (not b_i and not c_i);
end architecture dataflow;
```

3. Complete table with logic functions' values:

| **c** | **b** |**a** | **f(c,b,a)** | **f_NAND(c,b,a)** | **f_NOR(c,b,a)** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 1 | 1 |
| 0 | 0 | 1 | 1 | 1 | 1 |
| 0 | 1 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 | 1 | 1 |
| 1 | 1 | 0 | 0 | 0 | 0 |
| 1 | 1 | 1 | 0 | 0 | 0 |

### Distributive laws

1. Screenshot with simulated time waveforms. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![image](https://user-images.githubusercontent.com/99397789/154336711-6e995270-6622-4e54-9f95-f29d26cacb1e.png)


2. Link to your public EDA Playground example:

   [https://www.edaplayground.com/x/SKcM]

3. Meme with a cat 

   ![image](https://user-images.githubusercontent.com/99397789/154336864-c8390e67-6224-4a65-8b84-fb38e98734f4.png)
