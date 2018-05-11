---
title: How to process timezone in Python
date: 2018-05-11 15:15:37
tags:
- "Program Language:Python"
---

When Amy makes a comment in Taiwan at 20:00(GMT+8), his friend Tom in Japan should sees the comment is at at 21:00(GMT+9).

Best Practice:

1. Please remember using `datetime.datetime.utcnow()` to express object's created time
2. Recommend that `pytz` is awesome libary to handle timezone

<!-- more -->

In general, `timezone` is made from system time according to region of the globe.

## dateime object difference between built-in library and Django

Note that `time.time()` and `datetime.datetime.now()` these functions are had adding time offset of timezone but without timezone information.

```python
import time
import datetime
t = time.time()
dt = datetime.datetime.fromtimestamp(t)
dt
# datetime.datetime(2018, 5, 11, 15, 11, 49, 535299)

dt = datetime.datetime.now()
dt
# datetime.datetime(2018, 5, 11, 15, 11, 49, 535299)
```

If you are developing in Django, the `timezone` can definitely show `tzinfo`. That can be convenience to get datetime object with tzinfo and compare the difference.

```python
from django.utils import timezone

now = timezone.now()
now
# datetime.datetime(2018, 5, 11, 7, 44, 9, 147444, tzinfo=<UTC>)
```

In the above examples, I am located in GMT+8 of timezone, the UTC dateimte object adding timezone offset equals to the datetime generated by Python built-in library without timezone.

## `pytz` is your friend

### Expressing correct datetime object with tzinfo

In order to properly expressing `tzinfo` of datetime generated by Python built-in library, you can mark the datetime object using `pytz`.

```python
import datetime
import pytz
tp = pytz.timezone('Asia/Taipei')
dt = datetime.datetime.now().replace(tzinfo=tp)
dt
# datetime.datetime(2018, 5, 11, 16, 27, 23, 46918, tzinfo=<DstTzInfo 'Asia/Taipei' LMT+8:06:00 STD>)
```

### Using astimezone to adjust datetime

There is a function that is `astimezone` in datetime object, it can adjust datetime according to the new `tzinfo`.

```
dt.astimezone(pytz.utc)
datetime.datetime(2018, 5, 11, 8, 21, 23, 46918, tzinfo=<UTC>)
```

## Storing in Database

If you are developing an web application with database, please keep to the rule: `storing datetime must be from UTC timezone.` When you have many web application server and deploy in different region, it should consider that creating a object with a timestamp must avoid to affecting by timezone, otherwise the object shows in other region and adjusts by timezone of the region, the datetime expression will absolutely make a mistake.