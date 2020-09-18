# Spew

This is my repository of versions of Spew, a program that generates
random National Enquirer-style headlines from a template like these:

```
"I Am The Reincarnation of George Washington," Screams Vanna!
     -- Exclusive Photos Taken By Pussy Galore!

Fifty-Two Living Clones of Mary Queen of Scots Seen In John Doe's Office.

Jane Doe Gives Birth to Chartreuse Baby.

"Jane Doe Is Not My Aunt," Shrieks Diana Ross.

Eighty-Three-Year-Old John Doe Marries Seventy-Three-Year-Old Jane Doe.

Bambi's Amazing Diet beats Uninitialized Variables with Banana Pies and Cups of Coffee.

Princess Caroline Moves in with Lee Iacocca... Says His Treatment for Core Dumps Works.

"John Doe Is Really My Son," Screams John Doe.

Princess Diana Gobbled by Penguin in Jane Doe's Office.

"John Doe Is Really My Dad," Reveals Jane Doe.
```

It was originally posted to the `mod.sources.games` Usenet group in
1987, and it's been a source of amusement and utility for me ever
since.

The C and Perl versions are fully-functional; the others are in an
unknown state.

Templates are in the `headlines` directory.

You can run the Perl version and generate ten headlines from one of
the templates like this:

```
$ perl/spew.pl -f headlines/buzzword 10

Total Management Environment
Company-wide Memory Management Outlook
Corporate-Approved Management Scheme
Company-wide Workstation Plan
Complete Disk Allocation Scheme
Company-wide Disk Allocation Plan
Corporate-Approved Disk Allocation Environment
Company-wide Workstation Outlook
Company-wide Disk Allocation Outlook
Total Networking Environment
```
