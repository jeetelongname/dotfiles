#!/usr/bin/env python

from subprocess import check_output
from re import sub

# def get_pass(account, value):
#     """
#     the function first uses pass to check the output of the account specified
#     it needs to be placed in pass using

#     *password*
#     address:*your-account@email.com*

#     where password is on its own line and your email is put infront of address: with no whitespace on any lines

#     as it is all receved it bytes we decode when needed
#     """
#     data = check_output("/usr/bin/pass email/" + account, shell=True).splitlines() # data is recived in an array
#     password = data[0].decode('utf-8')
#     tmp = [x for x in data if x.startswith(bytes('address:'  , 'utf-8'))] # tmp makes its own array 
#     usertmp = tmp[0].decode('utf-8') # so we put it into its own varable and decode it
#     user = "" 
#     if len(usertmp) > 0:
#         user = usertmp.split(':',1)[1] # we split it at the colon and take the value
#     return password if value == "password" else user


def get_pass(account):
    data = check_output("/usr/bin/pass email/" + account, shell=True).splitlines()
    password = data[0]
    tmp = [x for x in data if x.startswith('address:')]
    user = ""
    if len(tmp) > 0:
        user = tmp[0].split(":", 1)[1]

    return {"password": password, "user": user}

def folder_filter(name):
    return not (name in ['INBOX',
                         '[Gmail]/Spam',
                         '[Gmail]/Important',
                         '[Gmail]/Starred'] or
                name.startswith('[Airmail]'))

def nametrans(name):
    return sub('^(Starred|Sent Mail|Drafts|Trash|All Mail|Spam)$', '[Gmail]/\\1', name)

def nametrans_reverse(name):
    return sub('^(\[Gmail\]/)', '', name)
