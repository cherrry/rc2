#!/usr/bin/env python3

from datetime import datetime


def format_date(dt):
    day = dt.day
    ordinal = 'th'
    if day == 1 or day == 21 or day == 31:
        ordinal = 'st'
    elif day == 2 or day == 22:
        ordinal = 'nd'
    elif day == 3 or day == 23:
        ordinal = 'rd'
    return '🗓️ {1}{2} {0:%b}, {0:%Y} ({0:%a})'.format(dt, dt.day, ordinal)


def main():
    now = datetime.now()
    print(format_date(now))


if __name__ == '__main__':
    main()
