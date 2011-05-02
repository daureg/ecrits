# vim: set fileencoding=utf-8
import sys
with open("chronologie") as f:
    l = [i.split(';')[0].strip() for i in f.readlines()]
for i,v in enumerate(l):
    dest = "{:03d}_{}".format(i+1,v)
    print("git mv {f}.nv {d}.nv\ngit mv info/{f}.mk \
info/{d}.mk".format(f=v,d=dest))
