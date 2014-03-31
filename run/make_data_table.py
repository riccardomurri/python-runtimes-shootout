#! /usr/bin/env python

import logging
import os
import sys

def read_used_line(filename):
    text = open(filename).read()
    return (line for line in text.split('\n') if 'USED:' in line).next()

header = None
for entry in os.listdir('data'):
    data = {}
    if entry.startswith('run'):
        logging.warn("Ignoring file 'data/%s' which has old format!", entry)
        continue
    else:
        data['Mgn'], data['python'], data['run_no'] = entry.split('.')[:3]
        data['Mgn'] = data['Mgn'].replace(',', '')
    try:
        used = read_used_line('data/' + entry)
    except StopIteration:
        logging.error("File 'data/%s' does not contain a 'USED:' line.", entry)
        continue
    for part in used.split():
        if '=' not in part:
            continue
        key, value = part.split('=')
        key = key.replace('.', '_')
        if value.endswith('kB'):
            key += '(kB)'
            value = value[:-2]
        data[key] = value
    if not header:
        header = str.join(',', (key.upper() for key in sorted(data.keys())))
        print header
    print str.join(',', (data[key] for key in sorted(data.keys())))
