# Work Stuff
Some helpful guides to refresh my memory!

# Software Testing
- https://stackoverflow.com/questions/887908/software-testing-job

# Funny Reading!
- https://www.reddit.com/r/programming/comments/1updk2/dijkstra_on_haskell_and_java/cekffk0/

# Ruby
- If updating Ruby for first time on Mac
- ruby -v
- curl -L https://get.rvm.io | bash -s stable <- Installs homebrew 
- source /Users/dalyw01/.rvm/scripts/rvm  <- Switchs to package manager
- rvm install ruby-2.4.1 <- Now this will work
- gem install cucumber
- gem install capybara
- gem list
- gem update

- https://rubygems.org/gems/capybara
- https://stackoverflow.com/questions/9279768/how-do-i-loop-over-a-hash-of-hashes-in-ruby
- https://www.twilio.com/blog/2015/10/4-ways-to-parse-a-json-api-with-ruby.html
- https://stackoverflow.com/questions/5410682/parsing-a-json-string-in-ruby
- https://www.dotnetperls.com/split-ruby
- http://ruby-doc.org/core-2.1.5/Enumerator.html
- http://www.korenlc.com/nested-arrays-hashes-loops-in-ruby/
- http://www.rubyist.net/~slagell/ruby/objinitialization.html
- http://www.korenlc.com/nested-arrays-hashes-loops-in-ruby/
- https://www.foragoodstrftime.com/

# Javascript
- http://www.phpied.com/3-ways-to-define-a-javascript-class/
- To run Javsacript in Android (perhaps putting in a cookie) type into your URL bar -> javascript:alert();
- To run Javascript on iOS (perhaps putting in a cookie) 
-- Visit google.com or some other random site
-- Bookmark it (using the share button)
-- Go to your bookmarks and tap edit
-- Select your placeholder bookmark and enter your code in the address field
-- Save the changes

# Tools
- https://www.w3counter.com/globalstats.php?year=2018&month=8
- http://gs.statcounter.com/browser-market-share/all/ireland
- https://www.browserstack.com/
- https://ftp.mozilla.org/pub/firefox/releases/
- https://mrcoles.com/bookmarklet/ < Great for creating bookmarklets and executing javascript on a page (javasript:alert() for mobile)

# Accessibility
- https://webaim.org/projects/screenreadersurvey7/
- https://www.powermapper.com/tests/screen-readers/labelling/area-aria-label/
- http://www.bbc.co.uk/guidelines/futuremedia/accessibility/mobile/summary

# Regex
I use this site - https://regex101.com/

- ()                         How you capture something
- \S                         String
- \d                         Digit/Integer
- [0-9a-fA-F]                Hex
- \s                         Space
- \n                         New line
- {3}                        Combine this with any of the above to specify a size
- \S+\d                      How to concatenate
- .*                         How to say you don’t care what you see after a certain phrase
- [^a-zA-Z0-9]               Not a letter or integer (e.g Symbols or Chinese characters)

So some examples I've had to do -

# Example 1

Just want the string "intel"

仅限搜索简体中文intel结果英特尔intelligence英特\n\t因特尔intel 文 intel

-> (intel)[^a-zA-Z0-9]|(intel)\Z

# Example 2

I want to capture the value "0+" before the port ED- 1b

CACHE  HITS / WR / REQ / IO ------- : 0 / 0 / 0 / 19745745
RECENT//ALL STATIS-TIME / IO/SEC -- : 0:07:13        0+ // 23:39:15      231 
RECENT//ALL  RATIOS HITS/WRITES --- :   0.00 /   0.00 //   0.00 /   0.00 ** ED-  1b ** 

-> SEC\s+--+\s+\S+\s+\S+\s+(\S).*\s+.*ED-\s+1b

# Example 3

I want the first value for pool "001"

POOL STAT E  CNT SRP  SLE TECH PROT   POOL_NAME    FLG DG USED PACK USSL
001 AVAL C    6   1  2ms EFD  R5/3+1 DG1_CKD_F    ...  1   0%  --  100%
          TDATS:  FFFEA-FFFEF
002 AVAL F   1A   1  2ms EFD  R5/3+1 DG1_FBA_F    ...  1   1% 

-> USSL\s+([0-9a-fA-F]{3})

# Example 4

I want the dates and log names e.g "Dec 16 11:09 85983_0000.log"

-rw-r--r-- 1 root root   9136 Dec 16 11:09 85983_0000.log
-rw-r--r-- 1 root root   7999 Dec 16 11:19 91983_0001.log
-rw-r--r-- 1 root root   6866 Dec 16 11:25 91983_0002.log
-rw-r--r-- 1 root root   6866 Dec 16 13:51 91983_0003.log
-rw-r--r-- 1 root root  10762 Dec 16 14:11 91983_0004.log
-rw-r--r-- 1 root root   9685 Dec 16 14:23 85983_0005.log
-rw-r--r-- 1 root root  12106 Dec 16 14:32 91983_0006.log
-rw-r--r-- 1 root root  14792 Dec 16 14:52 85983_0007.log
-rw-r--r-- 1 root root  12224 Dec 16 15:00 85983_0008.log
-rw-r--r-- 1 root root   7527 Dec 16 15:07 85983_0009.log
-rw-r--r-- 1 root root   8095 Dec 16 15:13 85983_0010.log

-> \d{2}\s+(.*.log)$

