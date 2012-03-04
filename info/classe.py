# vim: set fileencoding=utf-8
import sys
OFFSET = 0
with open("chronologie") as f:
    l = [i.split(';')[0].strip() for i in f.readlines()]
for i,v in enumerate(l):
    v += OFFSET
    dest = "{:03d}_{}".format(i+1,v)
    print("git mv {f}.nv {d}.nv\ngit mv info/{f}.mk \
info/{d}.mk".format(f=v,d=dest))
