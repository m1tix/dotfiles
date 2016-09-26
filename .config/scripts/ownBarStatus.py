#!/usr/bin/env pypy3
# TODO
# Mail widget, iirc message widget, when mpc at end of playlist, reshuffle.
# Asian character support on bar
# Workspace name background (like date and shit)
import i3ipc
import re
import subprocess
import time
from mpd import MPDClient

disk = '/dev/sda6'
networkAdapter = 'enp5s0'
mpdServer = 'localhost'
mpdServerPort = 6600
alsaChannel = 'Master'
volumeChange = 4

gapWidthLeft = 15   # gaps between left icon and workspaces
paddingWP = "    "  # gaps between workspaces
padding = "  "      # gap between block and text
gapWidthRight = 5   # gaps between sound and date
secondSleep = 1     # Seconds till next refresh (frequency)

colorHighlight = '#bf616a'
colorForeground = '#c0c5ce'
colorText = '#c0c5ce'
colorBackground = '#2b303b'
colorTextlight = '#65737e'
colorBlock = colorHighlight
colorIcon = colorText
colorVolumeMuted = colorHighlight
colorSongText = colorText
colorSongTime = colorHighlight
colorSongBackground = colorBackground

useVolume = False       # Volume Icon present or not
useSongIcon = False     # Song prev and next icon present or not
useDesktopIcon = False  # Desktop icon present or not

iconCircleO = '\uf10c'
iconCircle = '\uf111'
iconDesktop = '\uf108'
iconWorkspace = '\uf24d'
iconPlay = '\uf04b'
iconPause = '\uf04c'
iconPrev = '\uf04a'
iconNext = '\uf04e'
iconVolumeMute = '\uf026'
iconVolumeLow = '\uf027'
iconVolumeHigh = '\uf028'

# --------------------------------------------------------------------------- #


def natural_sort(l):
    def convert():
        lambda text: int(text) if text.isdigit() else text.lower()

    def alphanum_key():
        lambda key: [convert(c) for c in re.split('([0-9]+)', key)]
    return sorted(l, key=alphanum_key())

global i3
i3 = i3ipc.Connection()

global client
client = MPDClient()
client.connect(mpdServer, mpdServerPort)


def shell_result(cmd):
    return (subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        shell=True
    ).communicate()[0].decode('utf-8').strip()
    )


def get_Workspaces():
    focusedWorkspace = ""
    workspaces = i3.get_workspaces()
    workspaceNames = []

    for workspace in workspaces:
        workspaceNames.append(workspace.name)
        if workspace.focused:
            focusedWorkspace = workspace.name

    string = "%{A4:i3-msg workspace prev:}%{A5:i3-msg workspace next:}"
    if useDesktopIcon:
        string += "%{{B{}}}%{{F{}}} {} %{{B-}}%{{F-}}%{{O{}}}".format(
            colorBlock,
            colorBackground,
            iconDesktop,
            gapWidthLeft
        )

    for workspaceName in (natural_sort(workspaceNames)):
        if workspaceName == focusedWorkspace:
            string += "%{{B{}}}{}%{{F{}}}".format(
                colorHighlight, paddingWP, colorBackground) +\
                    workspaceName + "%{{F-}}{}%{{B-}}".format(
                        paddingWP
                    )
        else:
            string += "%{{B{}}}{}%{{A:i3-msg workspace {}:}}%{{F{}}}"\
                      .format(
                            colorBackground,
                            paddingWP,
                            workspaceName,
                            colorText,
                        ) + workspaceName +\
                    "%{{F-}}{}%{{A}}%{{B-}}".format(
                        paddingWP
                        )

    string += "%{A}%{A}"
    return string


def is_song_playing():
    # not using MPDClient for everything because
    # it throws random client connection errors and
    # I'am too lazy to circumfent it.
    return shell_result("mpc status | tail -n 2 | head -n 1 |"
                        "awk '{print $1;}' | tr -cd 'a-zA-Z'") == 'playing'


def is_song_stopped():
    return True if shell_result('mpc current') == '' else False


def get_song_time():
    if not is_song_stopped():
        return shell_result("mpc status | head -n 2 | tail -n 1 |"
                            " awk '{{print $3;}}'")
    else:
        return False


def get_song():
    if not is_song_stopped():
        if useSongIcon:
            return (
                "%{{F{}}}%{{B{}}} %{{A:mpc prev:}}{}%{{A}}"
                "%{{A:{}:}}{}%{{A}}  %{{A:mpc next:}}{}%{{A}}%{{B-}}%{{F-}}"
                .format(
                    colorSongText,
                    colorSongBackground,
                    iconPrev,
                    'mpc pause' if is_song_playing() else 'mpc play',
                    shell_result("mpc current"),
                    iconNext,
                )
            )
        else:
            return (
                "%{{A:{}:}}%{{F{}}}%{{B{}}}{}%{{B-}}%{{F-}}%{{B{}}}"
                " [%{{F{}}}{}%{{F-}}] %{{B-}}%{{A}}".format(
                    'mpc pause' if is_song_playing() else 'mpc play',
                    colorSongText,
                    colorSongBackground,
                    shell_result("mpc current"),
                    colorSongBackground,
                    colorSongTime,
                    get_song_time()
                )
            )
    else:
        return ""


def volume_percentage():
    return shell_result("amixer get {} | awk '/Front Left:/ {{print $5}}' |"
                        " tr -dc  '0-9'".format(
                            alsaChannel
                        ))


def get_volume():
    isMuted = shell_result("amixer get {} | awk '/Front Left:/ {{print $6}}'"
                           .format(
                               alsaChannel)
                           )
    if isMuted == '[off]':
        iconVolume = iconVolumeMute
    elif int(volume_percentage()) <= 50:
        iconVolume = iconVolumeLow
    elif int(volume_percentage()) > 50:
        iconVolume = iconVolumeHigh

    return (
        "%{{A:amixer sset {} toggle:}}%{{A4:amixer sset {} {}%+:}}"
        "%{{A5:amixer sset {} {}%-:}}%{{F{}}} {} %{{F-}}%{{A}}%{{A}}%{{A}}"
        .format(
            alsaChannel,
            alsaChannel,
            volumeChange,
            alsaChannel,
            volumeChange,
            colorVolumeMuted if isMuted == '[off]' else colorIcon,
            iconVolume
        ))


def get_time_and_date():
    timeAndDate = time.strftime('%a, %b %d %H:%M')

    return (
        "%{{B{}}}%{{F{}}}{}{}{}%{{F-}}%{{B-}}".format(
            colorBlock,
            colorBackground,
            padding,
            timeAndDate,
            padding
        )
    )


def get_status():
    return (
        "%{{l}}{} %{{c}}{} %{{r}}{}%{{O{}}}{}".format(
            get_Workspaces(),
            get_song(),
            get_volume() if useVolume else "",
            gapWidthRight,
            get_time_and_date()
        )
    )


def main():
    while True:
        print(get_status())
        time.sleep(secondSleep)

main()
