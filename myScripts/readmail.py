#!/usr/bin/python3

# Example: Extract main fields from an mbox file
import mailbox
import sys

if len(sys.argv) < 2:
    print(f"Usage: {sys.argv[0]} <mbox_file>")
    sys.exit(1)

mbox_file = sys.argv[1]
mbox = mailbox.mbox(mbox_file)

for message in mbox:
    print("From:", message.get('From'))
    print("To:", message.get('To'))
    print("Date:", message.get('Date'))
    print("Subject:", message.get('Subject'))
    print("Body:\n", message.get_payload(decode=True).decode(errors='ignore'))
    print("="*40)

