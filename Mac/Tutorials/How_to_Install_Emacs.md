1. Go to: http://emacsformacosx.com/
    1. Download and install the dmg.
    2. This makes it so there is an Emacs reference in the Applications folder.
        1. This is so Spotlight and Alfred can find it
2. Next go to: http://spacemacs.org/
   3. Install it
3. ????
4. Profit!
 
# Spacemacs Troubleshooting
You may have some issues upon installation. For instance, you may have some issues when modifying your .spacemacs file where it tells you there's issues with something called "anaconda". This issue can be read about here:  
https://github.com/proofit404/anaconda-mode/issues/114

To resolve this issue you need to:
1. Locate your distutils.cfg file
2. Delete the prefix line. 
3. Once deleted open up Spacemacs again and open a Python file. Then test the auto-completion logic.
4. Go ahead and add the prefix line back into your distutils.cfg file.
