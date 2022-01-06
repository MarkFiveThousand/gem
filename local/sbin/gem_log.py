""" gem_log """

# pylint: indent-string
# pylint: disable=C0326
# pylint: disable=C0103

import sys
import os

try:
	from termcolor import cprint

except ModuleNotFoundError as err:
	print(f"Error: {err}, {type(err)}")
	print()
	print("Please install the termcolor module using the following command:")
	print()
	print("pip install termcolor")
	print()
	raise

gem_fullpath_gem = "c:/msys64/home/mhodges/gem" if os.name == "nt" else "~/gem"

class Log:
	"""Simple log class."""

	def __init__(self):
		""" Initialize the log object."""
		self.is_initialized = False
		self.init()
		return None

	def init(self):
		"""
		init()- init must be called from the main shell, and not from a
		subshell, as would likely occur during command substitution.  The reason
		is that global variables would only be initizlied in the sub shell and
		not for the calling shell.  This causes problems since some operations
		are only supposed to occur once per run (E.g.  deleting the log file.)
		"""
		try:
			if self.is_initialized:
				return

			self.is_initialized = False
			self.path_log = os.path.abspath(f"{gem_fullpath_gem}\
				/local/src/python_test_0/python_test_0_log.html")
			self.fileIsHtml = True
			self.eol = "\n" if not self.fileIsHtml else "<br/>\n"

			if os.path.isfile(self.path_log):
				os.remove(self.path_log)

			if self.fileIsHtml:
				self.init_log_html()

			self.is_initialized = True

		except BaseException as err:
			print(f"Unexpected {err}, {type(err)}")
			raise
		return None

	def clean (self):
		""" Shutdown and clean up the log system. """
		try:
			pass

		except BaseException as err:
			print(f"Unexpected {err}, {type(err)}")
			raise
		return None

	def init_log_html (self):
		""" Write the beginning of the html log file. """
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
				print("</style><body class='bg font'>", file=f)

		except BaseException as err:
			print(f"Unexpected {err}, {type(err)}")
			raise
		return None


	def string_to_stdout (self, strng, color="white", attrs=""):
		"""
		Outputs the given arguments to stdout.  The arguments are treated as a
		single string.

		Termcolor reference: https://pypi.org/project/termcolor/
		"""
		try:
			self.init()
			if attrs == "":
				cprint(strng, color)
			else:
				cprint(strng, color=color, attrs=attrs)

		except BaseException as err:
			print(f"Unexpected {err}, {type(err)}")
			raise
		return None

	def string_to_stderr (self, strng):
		"""
		Outputs the given arguments to stdout.  The arguments are treated as a
		single string.

		Termcolor reference: https://pypi.org/project/termcolor/
		"""
		try:
			self.init()
			cprint(strng, "red", attrs=["bold"], file=sys.stderr)

		except BaseException as err:
			print(f"Unexpected {err}, {type(err)}")
			raise
		return None

	def string_to_file (self, strng, color="white", attrs=""):
		"""
		Outputs the given arguments to the log file.  The arguments are treated
		as a single string.
		"""
		try:
			self.init()

			self.string_to_stdout (strng, color, attrs)


			with open(self.path_log, "a") as f:
				bold="bold" if "bold" in attrs else ""
				print(f"<span class='{color} {bold}'>{strng}</span><br/>", file=f)

		except BaseException as err:
			print(f"Unexpected {err}, {type(err)}")
			raise
		return None

	def msg (self, strng):
		""" Outputs the given string to stdout. """
		try:
			self.init()
			self.string_to_stdout(strng, "white")
			self.string_to_file(strng)

		except BaseException as err:
			print(f"Unexpected {err}, {type(err)}")
			raise
		return None

	def debug (self, strng):
		""" Outputs the given string to stderr. """
		try:
			self.init()
			self.string_to_stderr(strng)
			self.string_to_file(strng)

		except BaseException as err:
			print(f"Unexpected {err}, {type(err)}")
			raise
		return None

	def alert(self, strng):
		""" Outputs the given string highlighted to stdout. """
		try:
			self.init()
			self.string_to_stdout(strng, "green")
			self.string_to_file(strng)

		except BaseException as err:
			print(f"Unexpected {err}, {type(err)}")
			raise
		return None

log = Log()
log.string_to_file("grey",    "grey")
log.string_to_file("red",     "red")
log.string_to_file("green",   "green")
log.string_to_file("yellow",  "yellow")
log.string_to_file("blue",    "blue")
log.string_to_file("magenta", "magenta")
log.string_to_file("cyan",    "cyan")
log.string_to_file("white",   "white")

log.string_to_file("grey",    "grey",    ["bold"])
log.string_to_file("red",     "red",     ["bold"])
log.string_to_file("green",   "green",   ["bold"])
log.string_to_file("yellow",  "yellow",  ["bold"])
log.string_to_file("blue",    "blue",    ["bold"])
log.string_to_file("magenta", "magenta", ["bold"])
log.string_to_file("cyan",    "cyan",    ["bold"])
log.string_to_file("white",   "white",   ["bold"])
