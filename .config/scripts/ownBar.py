#!/usr/bin/env pypy3

import subprocess


monitor = 'DVI-0'   # change this to your monitor
barWidth = 1920
barHeight = 30
barName = 'bigPapa'

colorBackground = '#2b303b'
colorForeground = '#c0c5ce'
# font1 = "DejaVu Sans Mono-10:Bold"
font1 = "Source Sans Pro Semibold-10"
font2 = 'FontAwesome-10'
actions = 20


def monitorWidthCalc():
    partString = '$4'
    monitorInput = "xrandr | grep {} | awk '{{print {};}}'".format(
        monitor,
        partString
    )
    monitorOutput = subprocess.check_output(monitorInput, shell=True)
    if monitorOutput[0:4].decode('utf-8').isdigit():
        return int(monitorOutput[0:4].decode('utf-8'))
    else:
        partString = '$3'
        monitorInput = "xrandr | grep {} | awk '{{print {};}}'".format(
            monitor,
            partString
        )
        monitorOutput = subprocess.check_output(monitorInput, shell=True)
        return int(monitorOutput[0:4].decode('utf-8'))


def main():
    monitorWidth = monitorWidthCalc()
    geometry = '{}x{}x{}'.format(barWidth, barHeight, monitorWidth)
    cmd = "python -u ~/.config/scripts/ownBarStatus.py | lemonbar -p -n \"{}\"\
    -g \"{}\" -B \"{}\" -F \"{}\" -a {} -o 0 -f \"{}\" -o 2 -f \"{}\" -u 2\
    | sh".format(
        barName,
        geometry,
        colorBackground,
        colorForeground,
        actions,
        font1,
        font2
    )

    subprocess.Popen(cmd, shell=True)

main()
