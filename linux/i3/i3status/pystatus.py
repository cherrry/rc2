#!/usr/bin/env python3

from i3pystatus import Status


def main():
    # Register from right to left.
    status = Status()
    status.register('clock', format=('🌍 %H:%M', 'Europe/Dublin'))
    status.register('clock',
                    format=(' / %H:%M', 'America/New_York'),
                    hints={'separator': False})
    status.register('clock',
                    format=('🌎 %H:%M', 'America/Los_Angeles'),
                    hints={
                        'separator': False,
                        'separator_block_width': 0
                    })
    status.register('clock',
                    format=('🌏 %H:%M', 'Asia/Hong_Kong'),
                    hints={'separator': False})
    status.register('shell',
                    command='~/.config/i3/i3status/today.py')

    status.register('battery',
                    format='{status} {percentage:.1f}%',
                    charging_color='#F8F8F8',
                    full_color='#F8F8F8',
                    status={
                        'CHR': '🔌',
                        'DIS': '🔋',
                        'DPL': 'DPL',
                        'FULL': '⚡',
                    })
    status.register('pulseaudio',
                    format='🔉 {volume}%',
                    format_muted='🔇 Muted',
                    color_muted='#AB4642',
                    hints={'separator': False},
                    on_leftclick='switch_mute')
    status.run()


if __name__ == '__main__':
    main()
