PingFix
Script written by Antoine Rahier <antoine.rahier@gmail.com> 
v1.1 - 03 July 2011


1) What the heck is this !?

PingFix is a small batch script for windows. Its aim is to improve latency in
applications with high reactivity needs, such as online video games. To do that,
it disables the use of Nagle's algorithm by windows.

For more information about Nagle's algorithm, see :
http://en.wikipedia.org/wiki/Nagle's_algorithm


2) Known issues

When used on poor bandwidth connections, it is possible that this script just
does nothing, or worse, increase latency. If you have an uncommon high ping, try
to revert modifications done by this script by using the "uninstall" version.

For more information about this case, see :
http://developers.slashdot.org/comments.pl?sid=174457&cid=14515105