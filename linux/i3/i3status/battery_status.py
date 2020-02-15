#!/usr/bin/env python3

import subprocess


def battery_name():
    names = subprocess.check_output(['upower',
                                     '-e']).decode('utf-8').split('\n')
    for name in names:
        if 'BAT' in name:
            return name
    return None


def battery_status():
    name = battery_name()
    if name == None:
        return None
    key_values = [
        s.split(':') for s in subprocess.check_output(
            ['upower', '-i', name]).decode('utf-8').split('\n')
    ]
    status = {
        kv[0].strip(): kv[1].strip()
        for kv in key_values if len(kv) == 2
    }
    return status


def main():
    status = battery_status()
    if status == None:
        print('🚫 BAT')
    else:
        state = {
            'charging': '🔌',
            'discharging': '🔋',
            'fully-charged': '⚡',
        }.get(status.get('state'), '⚡')
        print('%s %s' % (state, status.get('percentage')))


if __name__ == '__main__':
    main()
