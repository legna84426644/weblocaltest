import imaplib
import email
import re
import random

from robot.api import logger

gmailIMAP = "imap.gmail.com"
yahooIMAP = "imap.mail.yahoo.com"

gmail_mailboxes = ["INBOX", "[Gmail]/Spam"]
yahoo_mailboxes = ["Inbox", "Bulk Mail"]

test_user = "thanhtestmail01@gmail.com"
test_user_pw = "Test1234@"

def random_psuedo_email_address(email_address):
    name, email = email_address.split('@')
    num = random.randint(0, 999999999)
    psuedo_email = name + '+' +str(num) + '@' + email
    logger.info("Random email " + psuedo_email)
    return psuedo_email

def delete_all_email(email_address, password):
    if '@yahoo.com' in email_address:
        IMAP = yahooIMAP
        mailboxes = yahoo_mailboxes
    else:
        IMAP = gmailIMAP
        mailboxes = gmail_mailboxes
    mail = imaplib.IMAP4_SSL(IMAP)
    mail.login(email_address, password)
    for mailbox in mailboxes:
        mail.select(mailbox)
        typ, data = mail.search(None, 'ALL')
        for num in data[0].split():
            mail.store(num, '+FLAGS', '\\Deleted')
        mail.expunge()
    mail.close()
    mail.logout()

def get_signup_activation_url_from_email(email_address, password):
    if '@yahoo.com' in email_address:
        IMAP = yahooIMAP
        mailboxes = yahoo_mailboxes
    else:
        IMAP = gmailIMAP
        mailboxes = gmail_mailboxes
    ss = ["", ""]
    mail = imaplib.IMAP4_SSL(IMAP)
    mail.login(email_address, password)
    for mailbox in mailboxes:
        mail.select(mailbox)
        numUnread = len(mail.search(None, 'UnSeen')[1][0].split())
        if numUnread > 0:
            result, data = mail.uid('search', None, "ALL")
            latest_email_uid = data[0].split()[-1]
            result, data = mail.uid('fetch', latest_email_uid, '(RFC822)')
            raw_email = data[0][1]

            email_message = email.message_from_string(raw_email)
            if "Complete your VSee signup" in email_message['subject']:
                ss = str(email_message)
                # ss = re.findall("https://my.vsee.com/account/signup/activate/.*\n\w+", ss)
                ss = re.findall("https://my.vsee.com/account/signup/activate/\w+", ss)
                for i in range(len(ss)):
                    ss[i] = ss[i].replace("=\r\n", "")
                    ss[i] = ss[i].replace("=\n", "")
                    print "*********************************************"
                    print "Referral link #{0}: {1}".format(str(i), ss[i])

            mail.expunge()
            mail.close()
            mail.logout()
            return ss[0]
        else:
            raise Exception('No email found')

#get_signup_activation_url_from_email(test_user, test_user_pw)