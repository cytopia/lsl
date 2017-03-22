#!/usr/bin/env python

import sys
import os
import subprocess
import re



if __name__ == "__main__":

    my_name = "lsl"
    my_store = "/home/cytopia/.config/lsl/store.lbl"

    # Retrieve ls path
    path = os.getcwd()
    for arg in sys.argv[1:]:
        if arg[0] != '-':
            path = arg
            break
    path = os.path.abspath(path)

    long_output = False
    pattern = re.compile("^\-[1a-zA-Z]*l[1a-zA-Z]*")
    for arg in sys.argv[1:]:
        if pattern.match(arg):
            long_output = True
            break

    if long_output and os.path.isfile(my_store):
        p = subprocess.Popen('ls '+' '.join(sys.argv[1:]), shell=True,
                stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

        rm_cli_col = re.compile(r"\x1B\[[0-9;]*[JKmsu]")

        for line in iter(p.stdout.readline, ''):

            # Get last bit of line (filename part)
            fields = line.split()
            f = ""
            for i in range(len(fields)):
                if i == 8:
                    f = fields[i]
                elif i > 8:
                    f = f+' '+fields[i]

            # path regex and remove possible ls color-codes
            p = path + "/" + rm_cli_col.sub("", f)
            fd = open(my_store, 'r')
            matches = re.findall(r""+re.escape(p)+":::::.*", fd.read())
            label = ""
            for match in matches:
                ttmp = re.split(':::::', match)
                label = ttmp[1]
                color = ttmp[2].replace('\\e', '\x1b')
                line = line.replace(f, f+ " "+color+"[ "+label+" ]\x1b[0m")

            sys.stdout.write(line)
    else:
        os.system("ls "+" ".join(sys.argv[1:]))
