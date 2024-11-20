import sys

data = sys.stdin.readlines()

db_start = dict()
db_end = dict()
db_touch = dict()

for s in data:
    s = s.strip()
    ext_ip, s = s.split(' - - ')
    date, s = s.split('] ')
    date = date[1:].split()[0]
    s = s.split(' HTTP')[0]
    s = s[1:]
    print(s)
    if s.startswith('HEAD '):
        s = s.split('HEAD ')[1]
    elif s.startswith('GET '):
        s = s.split('GET ')[1]
     
    s = s.split('/')
    if 'touch' not in s:
        continue

    act = s[2]
    host = s[3]
    if len(s) < 5:
        continue
    state = s[4]
    print(s)
#   ip = s[5]
    if state == 'start':
        db_start[host] = date
        print(1)
    elif state == 'end':
        db_end[host] = date
    #else:
        #print(state, s)

print(db_start)
print(db_end)



