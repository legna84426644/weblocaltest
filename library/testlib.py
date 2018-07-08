import imaplib
import email
import re

gmailIMAP = "imap.gmail.com"
yahooIMAP = "imap.mail.yahoo.com"

def get_signup_activation_url_from_email(email_address, password):
    if '@yahoo.com' in email_address:
        IMAP = yahooIMAP
    else:
        IMAP = gmailIMAP
    ss = ["", ""]
    mail = imaplib.IMAP4_SSL(IMAP)
    mail.login(email_address, password)
    mail.select("inbox")
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

get_signup_activation_url_from_email('robin+test301@vsee.com', 'wh@td0umean')