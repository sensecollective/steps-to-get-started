#!/usr/bin/python

import os, tweepy, time, pickle

CONSUMER_SECRET = os.environ.get('TWITTER_SECRET')
CONSUMER_KEY = os.environ.get('TWITTER_KEY')
ACCESS_TOKEN = os.environ.get('TWITTER_ACCESS_TOKEN')
ACCESS_TOKEN_SECRET = os.environ.get('TWITTER_ACCESS_SECRET')

FNAME_1 = 'twitter_followers.pickle'
FNAME_2 = 'twitter_profile.pickle'
    
def connect_oauth():
    """ 
    Connect to OAuth 
    """
    AUTH = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
    AUTH.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
    return tweepy.API(AUTH)


def get_followers(api):
    """ 
    Get followers. Use sleep to prevent 
    twitter API rate limit from exceeding 
    """
    temp = []
    for page in tweepy.Cursor(api.followers,
                              screen_name="arcolife").pages():
        temp.extend(page)
        time.sleep(60)
    return temp


def dump_data(fname1, fname2, followers, profile):
    """ 
    dump followers and profile 
    """
    # dump followers
    FILE = open(fname1,'wb')
    pickle.dump(followers, FILE)
    FILE.close()
    # dump profile
    FILE = open(fname2,'wb')
    pickle.dump(profile, FILE)
    FILE.close()    

    
def load_data(filename1, filename2):
    """ 
    Load data from pickle dumps 
    """
    f = open(filename1, 'rb')
    tmp1 = pickle.loads(f.read())
    f.close()
    f = open(filename2, 'rb')
    tmp2 = pickle.loads(f.read())
    f.close()
    return tmp1, tmp2


def print_details(me):
    """
    print results
    """
    print "\nName: %s\n" % (me.name), "-"*25
    print "Handle: %s\n" % (me.screen_name), "-"*25
    print "Description: %s\n" % (me.description), "-"*25
    print "Website: %s\n" % (me.url), "-"*25
    print "Followers Count: %s\n" % (me.followers_count), "-"*25
    print "Location: %s\n" % (me.location), "-"*25
    print "Time Zone: %s\n" % (me.time_zone), "-"*25
    print
    

def main(fname1, fname2):
    """ 
    Main method. 
    """
    TWITTER_API = connect_oauth()
    my_profile = TWITTER_API.me()
    print "Connected...\n----------\n"
    print_details(my_profile)
    data = get_followers(TWITTER_API)
    dump_data(fname1, fname2, data, me)

    
if __name__=='__main__':
    try:
        followers, me = load_data(FNAME_1, FNAME_2)
        print_details(me)
    except:
        followers = main(FNAME_1, FNAME_2)
        
    # for follower in followers:
    #     print follower.name        
