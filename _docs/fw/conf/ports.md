---
conf: Ports
title: Ports and controls
---

>Configuration: `Ports`
> | Nodes: [`mhx`](../../hw/nodes/mhx.md) [`ers`](../../hw/nodes/ers.md) [`servo`](../../hw/nodes/servo.md) [`ghanta`](../../hw/nodes/ghanta.md) [`nav`](../../hw/nodes/nav.md) [`jsw`](../../hw/nodes/jsw.md) [`ifc`](../../hw/nodes/ifc.md) [`xhawk`](../../hw/nodes/xhawk.md)

This feature connects logical variables with physical signals on the vehicle.

## Controls mixer
> `Ports/controls`

The control channels (outputs to servo drives) can be mixed and configured in this setting. Output channels are labelled as **CHx** and one or many different Mandala variables can be mixed together to one channel.

If several variables (controls) are binded to the same channel, the output of channel is the sum of all outputs.

The following fields are available for controls mixing:

- **bind** -    variable binding
- **mult** -    multiplier applied to `bind` variable. *out*=`bind`x`mult`
- **diff** -    "differential multiplier", i.e. if sign of *out* is the same as sign of `diff` then *out* is multiplied by absolute value of `diff`. This setting is useful for ailerons.
- **speed** -   the allowed maximum speed of change [units of 1] for *out* signal, i.e. if `speed`=0.1, the value will change from 0 to 1 in 10 sec.
- **ch** -      output channel assignment. First, the binded variable is multiplied by `mult`, then `diff` applied, then `speed` is limited, and then the result is added to channel value.

Each channel can output value from -100% to +100%. Thus, the ouput from mixer (see above) is multiplied by 100, to convert units to percents. The channel output can be limited and adjusted, independent of mixers. This is useful to setup servo mechanical limits or mechanical zero position.

- **min** - minimum value [%] (-100%)
- **max** - maximum value [%] (+100%)
- **zero** - middle position [%]

For example:

- to adjust the neutral position for steering servo, you play with `zero` setting.
- to bind `*ctr_throttle*` to a channel, you may use `mult`=2, `min`=`zero`=-90, `max`=80. The variable `*ctr_throttle*` have values from 0 (idle) to 1 (full). Since you have some mechanical limits (-90, 80), the `mult` should be adjusted to maintain the span of the binded variable, i.e. `mult`=2x(80-(-90))/200=1.7:
    - when `*ctr_throttle*`=0, the servo position *out*=0x`mult`x100+`zero`=-90%=`min`
    - when `*ctr_throttle*`=1, the servo position *out*=1x`mult`x100+`zero`=-90+170=80%=`max`
- for flaperons you may setup two `bind`s to the same channel.
    * `bind`=`*ctr_ailerons*`, `mult`=0.6, `ch`=1
    * `bind`=`*ctr_flaps*`, `mult`=0.5, `speed`=0.5, `ch`=1

The output channels can be controlled through [VirtualMachine](vm.md).

## GPIO connections
> `Ports/gpio`

Digital inputs-outputs can be configured in this setting. Each physical line can be binded to Mandala variable and act as digital input or output.

The following fields are available:

- **bind** - variable binding
- **mode** - physical line mode
    - Output modes:
        - *OUTPUT* - the output logical level is equal high when `bind`x`mult`+`bias` > 0 or low otherwise
        - *PULSE* - the output will make pulse of `bias` [sec]
        - *STROBE* - the output will make a short pulses of ~1ms with `bias` [sec] interval
        - *DELAYED* - the output will trigger when `bind`x`mult`>0 after delay of `bias` [sec]
    - Input modes:
        - *INPUT* - regular logical input, `bind`=(1/0)x`mult`+`bias`
        - *INP_SET* - `bind` value can only be set to `mult`x`bias` on logical 1 (shutdown signal)
        - *INP_TRIG* - `bind` value will change either zero or `mult` (a button)
        - *RPM* - measures revolutions per minute `bind`=RPM x`mult`+`bias`
        - *FREQ* - measures frequency [Hz] `bind`=FREQ x`mult`+`bias`
        - *WIDTH* - measures pulse width [sec] `bind`=WIDTH x`mult`+`bias`
        - *DUTY* - measures duty cycle [0..1] `bind`=DUTY x`mult`+`bias`
        - *RC* - measures RC PWM signal [-1..+1] `bind`=POSITION x`mult`+`bias`
        - *AGLWRA* - (~~deprecated~~) measures altitude of [MaxSonar](http://www.maxbotix.com/Ultrasonic_Sensors/Outdoor_Sensors.htm) sensor
- **inv** - the physical input or output line inversion
- **pull** - pullups/pulldowns configuration *opendrain* is used for *OUTPUT* only
- **mult** - multiplier applied to `bind` variable
- **bias** - value added to `bind` variable. On some modes this value sets the timing [sec]


## Other parameters

 - `Ports/mixer` - This is a hardcoded mixer option, f.ex. for quad-copters.
    - *off* - will use `controls` mixers for all output channels
    - *quadX* - configure channels 1-4 as motor outputs for x quadcopter. Although, the quadcopter mixers could be tuned in `controls` setting, it is still prefferable to use the hardcoded mixer for safety reasons
    - *quadXC* - configure channels 1-4 as motor outputs for x quadcopter, but reverse rudder.
 - `Ports/freq` - This setting tunes the output frequency for PWM modulator, used to generate signals for servos, i.e. outputs from `controls`.