# Parkovací asistent
[Odkaz na GitHub](https://github.com/Dan5049/DE1-project)

### Členové týmu
Fabula Boris      [GitHub](https://github.com/bfbl/Digital-electronics-1)  
Havránek Daniel   [GitHub](https://github.com/Dan5049/Digital-electronics-1)   
Hlaváček Jakub    [GitHub](https://github.com/Jakubhl/Digital-electronics-1)   
Horna Aleš        [GitHub](https://github.com/xhorna16/Digital-electronics-1)

### Cíl projektu
<br>

* Cílem projektu je vytvoření parkovacího asistentu. Základní verze obsahuje jeden ultrazvukový senzor HC-SR04, bargrafem realizovaným pomocí LED integrovaných na desce a zvukuvou signalizací pomocí bzučáku.
* V druhé verzi projektu je plánováno nahradit LED optickou signalizaci externího bargrafu.
* V třetí verzi projektu je plánováno použití třech ultrazvukových senzorů namísto jednoho. Pro optickou signalizaci bude za potřebí využít třech bargrafů - každý pro jeden senzor. Zvuková signalizace pomocí bzučáku bude poté pro nejkritičtejší hodnotu.

![Auto](images/CarScheme.png)

## Popis hardwaru
### Tabulka propojení
| **Signál**| **Výstupní pin** | **FPGA pin** | **FPGA package pin** |
| :-: | :-: | :-: | :-: |
| rst | btn[0] | IO_L6N_T0_VREF_16 | D9 |
| echo_i | jc[0] | IO_L20P_T3_A08_D24_14 | U12 |
| trig_o | ja[0] | IO_0_15 | G13 |
| buzz_o | ja[1] | IO_L4P_T0_15 | B11 |

<br>

### Tabulka propojení bragrafu
| **Signál -> leds_o**| **Výstupní pin** | **FPGA pin** | **FPGA package pin** |
| :-: | :-: | :-: | :-: |
| 0 | ja[2] | IO_L4N_T0_15 | A11 |
| 1 | ja[3] | IO_L6P_T0_15 | D12 |
| 2 | ja[4] | IO_L6N_T0_VREF_15 | D13 |
| 3 | ja[5] | IO_L10P_T1_AD11P_15 | B18 |
| 4 | ja[6] | IO_L10N_T1_AD11N_15 | A18 |
| 5 | ja[7] | IO_25_15 | K16 |
| 6 | jb[0] | IO_L11P_T1_SRCC_15 | E15 |
| 7 | jb[1] | IO_L11N_T1_SRCC_15 | E16 |
| 8 | jb[2] | IO_L12P_T1_MRCC_15 | D15 |
| 9 | jb[3] | IO_L12N_T1_MRCC_15 | C15 |




## VHDL moduly a simulace



## TOP modul a simulace




## Video



## Reference
1. https://github.com/Digilent/digilent-xdc/blob/master/Arty-A7-100-Master.xdc
2. https://www.electroschematics.com/wp-content/uploads/2013/07/HCSR04-datasheet-version-1.pdf
3. https://github.com/tomas-fryza/Digital-electronics-1
4. https://app.diagrams.net/
5. https://vhdlwhiz.com/basic-vhdl-tutorials/
