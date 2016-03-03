# Command Line Pro Tips
## Using the "find" command

### Overview
To find a file via the command line use the "find" command.

#### Example
The syntaxs as follows  
find <directory start> <flags>

### Finding Based on Pattern
If you're trying to match against a pattern you can use the -name flag to designate the pattern you would like to find.

#### Example
find / -name cool_pic.jpg

### Ignoring errors when you search
It's likely that when using the "find" command you're going to encounter weird errors like "Permission Denied". These errors create extraneous information that's makes it hard to determine relevant information. In order to cope with this you can pipe the error output to /dev/null so that you don't have to pay attention to it.

#### Example
find / -name cool_pic.jpg 2>/dev/null
