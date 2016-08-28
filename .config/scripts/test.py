#!/usr/bin/python3
import subprocess
import sys


def shell_result(cmd):
    return (subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        shell=True
    ).communicate()[0].decode('utf-8').strip()
    )

percentage = shell_result("mpc status | grep -E '(playing|paused)'"
                          " | rev | cut -c 3- | rev | cut -d '(' -f 2 ")

roundedShit = round(int(percentage) / 2)
while roundedShit <= 50:
    sys.stdout.write("█" * roundedShit + ("▓" * (50-roundedShit)))
    sys.stdout.write('\r')
    sys.stdout.flush()
    percentage = shell_result("mpc status | grep -E '(playing|paused)'"
                              " | rev | cut -c 3- | rev | cut -d '(' -f 2 ")
    roundedShit = round(int(percentage) / 2)
sys.stdout.write('\n')
