def Foo (str):
    print(str)
    return 0


# ==============================================================================
# String_IsWholeNumber()- Echos true if $1 is a whole number.
# ==============================================================================
def String_IsWholeNumber (str):
    return 0

# ==============================================================================
# String_IsIdentifier()- Echos true if $1 is a C-style identifier containing
# underscore, numerical digits, and both case letters, otherwise false.
# ==============================================================================
def String_IsIdentifier (str):
    return 0


# ==============================================================================
# String_Trim()- Trims the whitespace from the head and tail of a string.
#
# Source:
# https://unix.stackexchange.com/questions/476455/how-to-remove-leading-and-trailing-spaces-from-a-shell-variable
# ==============================================================================
def String_Trim (str):
    return 0

# ==============================================================================
# String_StripComments()- Removes any characters following, and including, #.
# ==============================================================================
def String_StripComments (str):
    return 0


# ==============================================================================
# Returns 1 if a space-separated list, $1, contains the indicated string $2.
#
# *TODO: Correct the logic to work like typical return values.  I.e. 0 means
# success, and 1 non-zero means failure.
# ==============================================================================
def ListContains (haystack, needle):
    return 0


# ==============================================================================
# ValidatePaths()- Receives as parameters a copy of the parameters that were
# passed to our file system wrappers cd and related family of functions, ...
# etc.  We would like to restrict these functions from working outside the gem
# file heirarchy for safety purposes.
#
# Every argument that realpath successfully converts is expected to be a file
# path and, therefore, must contain "/gem/".
# ==============================================================================
def ValidatePaths (*args):
    return 0


# ==============================================================================
#
# Safe Shell commands
#
# The following functions are safe alternatives to common bash shell commands.
# The file domain is limited to the gem/ file tree.
#
# *TODO: Manage the return values of all these.
# ==============================================================================
def cd (path):
    return 0


def cp (*args):
    return 0


def ln (*args):
    return 0


def mv (*args):
    return 0


def rm (file):
    return 0


def mkdir (path):
    return 0


def rmdir (path):
    return 0


def DirExists (path):
    return 0


def DirIsEmpty (path):
    return 0


def rmdir_IfEmpty (path):
    return 0


def PrintHelp ():
    return 0

# ==============================================================================
# Init()- 
#
# ==============================================================================
def Init ():
    return 0

# ==============================================================================
# Clean()- 
#
# ==============================================================================
def Clean ():
    return 0

# ==============================================================================
# OnArg()- Processes recognized arguments, and returns the number of arguments
# processed.
#
# We not currently handling any arguments here, but derrived scripts should
# always call OnArg() in case we handle arguments in the future.
# ==============================================================================
def OnArg (arg):
    return 0

# ==============================================================================
# Main()
# ==============================================================================
def Main (str):
    return 0

