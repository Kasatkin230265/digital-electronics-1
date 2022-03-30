## Preparation tasks (done before the lab at home)

1. See [schematic](https://github.com/tomas-fryza/digital-electronics-1/blob/master/docs/nexys-a7-sch.pdf) or [reference manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual) of the Nexys A7 board and find out the connection of two RGB LEDs, ie to which FPGA pins are connected and how. How you can control them to get red, yellow, or green colors? Draw the schematic with RGB LEDs.

![image](https://user-images.githubusercontent.com/99397789/160426546-a02c3c24-168a-4474-8146-a248a762c3aa.png)
![image](https://user-images.githubusercontent.com/99397789/160427239-4cc4df45-66a1-4539-b65b-ee128fbdaa3b.png)

| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |

2. See [schematic](https://github.com/tomas-fryza/digital-electronics-1/blob/master/docs/nexys-a7-sch.pdf) or [reference manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual) of the Nexys A7 board and find out to which FPGA pins Pmod ports JA, JB, JC, and JD are connected.

![image](https://user-images.githubusercontent.com/99397789/160427552-d8e8f595-0b7c-4393-8316-e80b187be02d.png)
![image](https://user-images.githubusercontent.com/99397789/160427500-2aaa4b90-fc06-4bf3-8060-3e621301b2a5.png)
