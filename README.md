# FPGA-TrafficLight

# FPGA-TrafficLight

>  2022 Spring NCKU FPGA Course
>
>  Homework 1 
>
>  E24076239 E24076297 E24076750

## Problem1: RGB LED

### Introduction

This project uses **PYNQ-Z2** to implement an RGB control circuit.

#### Mode

| Switch | Color  |
| ------ | ------ |
| 00     | White  |
| 01     | Red    |
| 10     | Green  |
| 11     | Yellow |

### Modules

`Decoder.v` is the only module used in this project which maps the input switch to output RGB color. 

### Schematic

<div align=left>
    <img src='images/decoder.png' width=75% height=75%>
  </div>


## Problem2: Traffic Light

## Introduction

This project uses **PYNQ-Z2** to implement a traffic light finite state machine. Users can adjust the duration of each state(from 1 to 15 seconds) via the switch and buttons on PYNQ-Z2 board.

### State Diagram

<div align=left>
    <img src='images/state.png'>
  </div>


The first letter of each state name indicates the color of `led4` , the second is the color of `led5`.

The transitions between states occur automatically when the remaining time( `c_time` ) of the current state becomes zero. When the asynchronous reset signal(`rst`) is received, the system returns to `GR` regardless of the current state.

### Specification

<table>
    <tr>
        <td><b>Switch</b></td>
        <td><b>RGB LEDs</b></td>
        <td><b>BTNs</b></td>
        <td><b>LEDs</b></td>
        <td><b>State</b></td>
    </tr>
    <tr>
        <td>00</td>
        <td>Operate properly</td>
        <td></td>
        <td>Display remaining time in seconds</td>
        <td>Operate properly</td>
    </tr>
     <tr>
        <td>01</td>
        <td>Red+Green</td>
        <td rowspan="3"><tt>BTN[0]</tt>: reset<br><tt>BTN[1]</tt>: add one second<br><tt>BTN[2]</tt>: minus one second</td>
        <td>Display the duration of <b>red</b> light and <b>green</b> light</td>
        <td>Adjust the duration of <b>red</b> light and <b>green</b> light</td>
    </tr>
    <tr>
        <td>10</td>
        <td>Yellow</td>
        <td>Display the duration of <b>yellow</b> light</td>
        <td>Adjust the duration of <b>yellow</b> light</td>
    </tr>
    <tr>
        <td>11</td>
        <td>White</td>
        <td>Display the duration of <b>red</b> lights</td>
        <td>Adjust the duration of <b>red</b> lights</td>
    </tr>
</table>


A debounce circuit is used here for `BTN` .

### Modules

1. **Controller** module

   Major part in this project, controlling the state transition and handling user input(switch and button).

2. **Clk_divider** module

   Divide the primary clock to approach actual time in seconds.

### Schematic

<div align="left">
    <img src="images/traffic_light.png" width=75% height=75%>
</div>


## Discussions

1. Why add `blinky.xdc`?
   The `create_clock` command is used to define the primary clock of our design, and the `create_generated_clock` command defines the generated clock that follows the master clock, which is the primary clock in our design.

2. In the development process of Vivado, what is the difference between the results of **Synthesis** and **Implementation**?

   The **placement** and **routing** is finished after **Implementation**.

