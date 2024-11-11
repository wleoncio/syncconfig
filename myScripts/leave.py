# Calculate time to leave from work
import datetime
import sys

# Gather arrival time at MF, default to 16:15
if len(sys.argv) > 1:
    arrival = sys.argv[1]
else:
    print('No input given, defaulting to arrival at 16:15')
    arrival = '16:15'

# Loop through activities to do before arrival, asking for name of activity and
# duration
activities = []
while True:
    activity = input('Activity (leave empty to stop): ')
    if activity == '':
        break
    duration = input('Duration (minutes): ')
    activities.append((activity, int(duration)))
    print('')

# Calculate time to leave by adding up durations of activities and working back
# from arrival time
leave = datetime.datetime.strptime(arrival, '%H:%M')
for activity in activities:
    leave -= datetime.timedelta(minutes=activity[1])

# Print details of activities, including start time, duration and end time
print('')
start = leave
for activity in activities:
    finish = start + datetime.timedelta(minutes=activity[1])
    print(activity[0], '\t\tfrom', start.strftime('%H:%M'), 'to', finish.strftime('%H:%M'))
    start = finish

# Print time to leave
print('\nLeave at', leave.strftime('%H:%M'))
