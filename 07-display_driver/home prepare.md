## Preparation tasks (done before the lab at home)

A common way to control multiple displays is to gradually switch between them. We control (connect to supply voltage) only one of the displays at a time, as can be seen [here](https://engineeringtutorial.com/seven-segment-display-working-principle/).

Due to the physiological properties of human vision, it is necessary that the time required to display the whole value is a maximum of 16&nbsp;ms. If we display four digits, then the duration of one of them is 4&nbsp;ms. If we display eight digits, the time is reduced to 2&nbsp;ms, etc.

1. See [schematic](https://github.com/tomas-fryza/Digital-electronics-1/blob/master/docs/nexys-a7-sch.pdf) or [reference manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual) of the Nexys A7 board, find out the connection of 7-segment displays, and complete the signal timing to display four-digit value `3.142`.

![image](https://user-images.githubusercontent.com/99397789/159784981-14d958c3-7679-44a3-9f43-1747e777f78d.png)


  ![image](https://user-images.githubusercontent.com/99397789/159784516-3595e10b-179d-4c46-8a40-1281ededb55e.png)

  ![image](https://user-images.githubusercontent.com/99397789/159784560-7830030a-725c-42f7-94db-8340d13843c9.png)
  
  ```javascript
{
  signal:
  [
    ['Digit position',
      {name: 'Common anode: AN(3)', wave: 'xx01..01..01..'},
      {name: 'AN(2)', wave: 'xx101..01..01.'},
      {name: 'AN(1)', wave: 'xx1.01..01..01'},
      {name: 'AN(0)', wave: 'xx1..01..01..0'},
    ],
    ['Seven-segment data',
      {name: '4-digit value to display', wave: 'xx333355559999', data: ['3','1','4','2','3','1','4','2','3','1','4','2']},
      {name: 'Cathod A: CA', wave: 'xx01.0.1.0.1.0'},
      {name: 'Cathod B: CB', wave: 'xx0...........'},
      {name: 'Cathod C: CC', wave: 'xx0..10..10..1'},
      {name: 'Cathod D: CD', wave: 'xx01.0.1.0.1.0'},
      {name: 'Cathod E: CE', wave: 'xx1..01..01..0'},
      {name: 'Cathod F: CF', wave: 'xx1.01..01..01'},
      {name: 'Cathod G: CG', wave: 'xx010..10..10.'},
    ],
    {name: 'Decimal point: DP', wave: 'xx01..01..01..'},
  ],
  head:
  {
    text: '                    4ms   4ms   4ms   4ms   4ms   4ms   4ms   4ms   4ms   4ms   4ms   4ms',
  },
}
  ```

<a name="part1"></a>
