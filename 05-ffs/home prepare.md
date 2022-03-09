# Lab 5: Latches and Flip-flops

<!--
![Logo](../../logolink_eng.jpg)
<p align="center">
  The Study of Modern and Developing Engineering BUT<br>
  CZ.02.2.69/0.0/0.0/18_056/0013325
</p>
-->


## Preparation tasks (done before the lab at home)

1. Write characteristic equations and complete truth tables for D, JK, T flip-flops where `q(n)` represents main output value before the clock edge and `q(n+1)` represents output value after the clock edge.

   ![image](https://user-images.githubusercontent.com/99397789/157527145-491bb788-dcc7-40ea-aec3-669878608275.png)


   **D-type FF**
   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ↑ | 0 | 0 | 0 | q(n+1) has the same level as d |
   | ↑ | 0 | 1 | 0 | Output did not change |
   | ↑ | 1 | 0 | 1 | q(n+1) has the same level as d |
   | ↑ | 1 | 1 | 1 | Output did not change |

   **JK-type FF**
   | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ↑ | 0 | 0 | 0 | 0 | Output did not change |
   | ↑ | 0 | 0 | 1 | 1 | Output did not change |
   | ↑ | 0 | 1 | 0 | 0 | set output value |
   | ↑ | 0 | 1 | 1 | 0 | set output value |
   | ↑ | 1 | 0 | 0 | 1 | reset output value |
   | ↑ | 1 | 0 | 1 | 1 | reset output value |
   | ↑ | 1 | 1 | 0 | 1 | changes value of output signal |
   | ↑ | 1 | 1 | 1 | 0 | changes value of output signal |

   **T-type FF**
   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ↑ | 0 | 0 | 0 | Output did not change |
   | ↑ | 0 | 1 | 1 | set output value |
   | ↑ | 1 | 0 | 1 | reset output value |
   | ↑ | 1 | 1 | 0 | changes value of output signal |

<a name="part1"></a>
