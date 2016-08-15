#!/usr/bin/python3
import os
import re
import shutil
# Too cool for variables ;)
items = {'~/.config': ['i3', 'scripts', 'nvim/init.vim', 'termite'],
         '': ['.bashrc', '.Xresources', '.mpd/mpd.conf', 'Code/Web/homepage',
              '.vimperator/colors/gruvbox.vimp'],
         '~/.ncmpcpp': ['config']}
dotfileDir = os.path.expanduser('~/Documents/Git/dotfiles')
fileName = 'collectDot.py'


def itemScrapper():
    for item in items:
        os.chdir(dotfileDir)
        print(item)
        if item != '':
            os.makedirs(os.path.basename(item), exist_ok=True)
            os.chdir(os.path.basename(item))
            dirAbsPath = os.path.expanduser(item)
        else:
            dirAbsPath = os.path.expanduser('~/')
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


def wallReader():
    i3Config = open('.config/i3/config')
    fehEx = re.compile(r'\bfeh\b(.*)?')
    mo = fehEx.search(i3Config.read())
    wallPath = os.path.expanduser(mo.group().split()[2])
    shutil.copy(wallPath, dotfileDir)

itemScrapper()
# wallReader()
