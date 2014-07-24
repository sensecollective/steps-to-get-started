from pandas import read_csv
import sys

try:
    f = open('emacs_shortcuts.csv','r')
    data = read_csv(f)
    f.close()
except:
    raise
    #print sys.exc_info()[0]
    #exit()

#cms = data.values[1][1].split('->')[1].split(';')
print "Total shortcuts: ",len(data)
for i in xrange(len(data)):
    print "\n",i+1," Shortcut: ",data['shortcut'][i]
    print "Decription: ",data['description'][i].lstrip()

print
