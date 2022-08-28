#!/usr/bin/python3
import os
import shutil

items = {
    "~/.config": [
        "bspwm",
        "nvim",
        "alacritty",
        "zathura",
        "sxhkd",
        "dunst",
        "picom",
        "polybar",
        "rofi",
        "autocolor",
    ],
    "": [".zshrc"],
}
dotfileDir = os.path.expanduser("~/.dotfiles")


def itemScrapper():
    for item in items:
        os.chdir(dotfileDir)
        if item != "":
            os.makedirs(os.path.basename(item), exist_ok=True)
            os.chdir(os.path.basename(item))
            dirAbsPath = os.path.expanduser(item)
        else:
            dirAbsPath = os.path.expanduser("~/")
        for files in items[item]:
            filePath = os.path.join(dirAbsPath, files)
            if os.path.isdir(filePath):
                try:
                    shutil.copytree(filePath, os.path.basename(files))
                except FileExistsError:
                    shutil.rmtree(os.path.basename(files))
                    shutil.copytree(filePath, os.path.basename(files))
            elif os.path.isfile(filePath):
                shutil.copy(filePath, os.path.basename(files))


itemScrapper()
