import sys, os
from termcolor import colored, cprint

class Log:
	"""Simple log class."""

	# =========================================================================
	# __init__()- Initialize the log object.
	# =========================================================================
	def __init__(self):
		self.isInitialized = False
		self.Init()

	# ==============================================================================
	# self.Init()- Init must be called from the main shell, and not from
	# a subshell, as would likely occur during command substitution.  The reason is
	# that global variables would only be initizlied in the sub shell and not for
	# the calling shell.  This causes problems since some operations are only
	# supposed to occur once per run (E.g.  deleting the log file.)
	# ==============================================================================
	def Init (self):
		try:
			if self.isInitialized:
				return

			self.isInitialized = False
			self.path_log = "/home/mhodges/gem/local/src/python_test_0/python_test_0_log.html"
			self.fileIsHtml = True
			self.eol = "\n" if self.fileIsHtml == False else "<br/>\n"

			if os.path.isfile(self.path_log):
				os.remove(self.path_log)

			if self.fileIsHtml:
				self.InitLogHtml()

			self.isInitialized = True

		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise

	# ==============================================================================
	# Clean()- 
	# ==============================================================================
	def Clean (self):
		try:
			pass

		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise

	# ==============================================================================
	# Callstack()- Outputs the current callstack.
	#
	# Usage: Callstack
	# ==============================================================================
	def Callstack (self):
		try:
			pass

		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise

	# ==============================================================================
	# InitLogHtml()- 
	# ==============================================================================
	def InitLogHtml (self):
		try:
			with open(self.path_log, "w") as f:
				print("<html><body><style>", file=f)
				print(".bg {background-color: #1e1e1e;", file=f)
				print("     font-family: monospace;", file=f)
				print("     font-size: 15px;}", file=f)
				print(".bold {font-weight: bold;}", file=f)
				print(".grey {color: #666666;}", file=f)
				print(".red {color: #f14c4c;}", file=f)
				print(".green {color: #23d18b;}", file=f)
				print(".yellow {color: #f5f543;}", file=f)
				print(".blue {color: #3b8eea;}", file=f)
				print(".magenta {color: #d670d6;}", file=f)
				print(".cyan {color: #29b8db;}", file=f)
				print(".white {color: #e5e5e5;}", file=f)
				print("</style><body class=\"bg font\">", file=f)


		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise


	# ==============================================================================
	# v_StringToStdout()- Outputs the given arguments to stdout.  The
	# arguments are treated as a single string.
	#
	# Termcolor reference: https://pypi.org/project/termcolor/
	# ==============================================================================
	def StringToStdout (self, str, color="white", attrs=""):
		try:
			self.Init()
			if attrs == "":
				cprint(str, color)
			else:
				cprint(str, color=color, attrs=attrs)

		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise

	# ==============================================================================
	# v_StringToStdout()- Outputs the given arguments to stdout.  The
	# arguments are treated as a single string.
	#
	# Termcolor reference: https://pypi.org/project/termcolor/
	# ==============================================================================
	def StringToStderr (self, str):
		try:
			self.Init()
			cprint(str, "red", attrs=["bold"], file=sys.stderr)

		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise

	# ==============================================================================
	# v_StringToFile()- Outputs the given arguments to the log file.  The
	# arguments are treated as a single string.
	# ==============================================================================
	def StringToFile (self, str, color="white", attrs=""):
		try:
			self.Init()

			self.StringToStdout (str, color, attrs)


			with open(self.path_log, "a") as f:
				bold="bold" if "bold" in attrs else ""
				print(f"<span class=\"{color} {bold}\">{str}</span><br/>", file=f)

		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise

	# ==============================================================================
	# Msg()- Outputs the given arguments to stdout.  The arguments are
	# treated as a single string.
	# ==============================================================================
	def Msg (self, str):
		try:
			self.Init()
			self.StringToStdout(str, "white");
			self.StringToFile(str);

		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise

	# ==============================================================================
	# v_Debug()- 
	# ==============================================================================
	def Debug (self, str):
		try:
			self.Init()
			self.StringToStderr(str);
			self.StringToFile(str);

		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise

	# ==============================================================================
	# v_Alert()- 
	# ==============================================================================
	def Alert (self, str):
		try:
			self.Init()
			self.StringToStdout(str, "green");
			self.StringToFile(str);

		except BaseException as err:
			print(f"Unexpected {err=}, {type(err)=}")
			raise

log = Log()
log.StringToFile("grey",    "grey")
log.StringToFile("red",     "red")
log.StringToFile("green",   "green")
log.StringToFile("yellow",  "yellow")
log.StringToFile("blue",    "blue")
log.StringToFile("magenta", "magenta")
log.StringToFile("cyan",    "cyan")
log.StringToFile("white",   "white")

log.StringToFile("grey",    "grey",    ["bold"])
log.StringToFile("red",     "red",     ["bold"])
log.StringToFile("green",   "green",   ["bold"])
log.StringToFile("yellow",  "yellow",  ["bold"])
log.StringToFile("blue",    "blue",    ["bold"])
log.StringToFile("magenta", "magenta", ["bold"])
log.StringToFile("cyan",    "cyan",    ["bold"])
log.StringToFile("white",   "white",   ["bold"])


