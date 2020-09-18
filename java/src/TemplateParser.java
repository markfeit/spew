// package net.notonthe.projects.spew.TemplateParser;

import java.io.*;
import java.util.regex.*;

/*

  The template file format is as follows:

  \* through the end of a line is a comment and will be ignored.

  A line reading '%NAME{modifiers}' starts a category.  NAME may be
  letters, digits and the underscore.  The braces and modifiers are
  optional.  Modifiers are single letters.

  All non-blank lines inside a category are treated as items.  Any
  line reading "%%" is treated as end-of-file.  Categories terminate
  at EOF or when a new category is started.


    (n) at the beginning of the item gives it a weight of n.

    \! inserts a newline (\n) character

    \NAME invokes the category NAME in its default form

    \NAME/x invokes the category NAME with the modifier 'x'

    \NAME/& invokes the category NAME with whatever modifier was
    passed to this item.

  A line containing only '%%' denotes EOF at the end of the last
  category.  Yes, real EOF would be nicer to detect, but the original
  version of spew specified the template format, and we must be
  compatible with it.

 */


public class TemplateParser {

    // Patterns used by this class

    private static final Pattern category_pattern
	= Pattern.compile( "\\A%(\\w+)(\\{(\\w+)\\})?.*" );


    public TemplateParser() {
	// This doesn't actually do anything.
    }

    public CategorySet parse( BufferedReader input )
	throws IOException, TemplateErrorException {

	int  lineno = 0;
	String line;

	CategorySet set = new CategorySet();

	// Current category
	Category category = null;

	while ( (line = input.readLine()) != null ) {

	    lineno++;

	    // Lose whitespace, comments and blank lines
	    line = line.trim();
	    String processed = line.replaceAll("\\\\\\*.*$", "" ).trim();
	    if ( processed.length() == 0 ) {
		continue;
	    }
	    
	    // A forced EOF dumps us out of the loop, where the last
	    // category will be cleaned up.

	    if ( processed.equals("%%") ) {
		break;
	    }

	    // Attempt to match a new category

	    Matcher category_match = category_pattern.matcher(line);
	    if ( category_match.matches() ) {

		// Parse out the bits of the string we need

		String name = category_match.group(1);
		String mod_match = category_match.group(3);
		String modifiers = (mod_match != null ? mod_match : "");

		// If there was a category being built, add it to the
		// CategorySet.

		if ( category != null ) {
		    set.add(category);
		}

		// Try to make a new category

		if ( set.hasCategory(name) ) {
		    throw new TemplateErrorException("Duplicate category '"
						     + name + "'", lineno);
		}

		try {
		    category = new Category( name, modifiers );
		}
		catch (Exception ex) {
		    throw new TemplateErrorException(
						     ex.getMessage() +
						     " at line " + lineno,
						     lineno );
		}

		// We're done with this line, go hit the next one.

		continue;
	    }

	    // If we got here, we're looking at what should be a
	    // category entry.  If there's no category being built,
	    // complain loudly.

	    if ( category == null ) {
		throw new TemplateErrorException( "Item appears while not"
						  + " in category", lineno );
	    }

	    // Parse the processed line into an item
	    Item ci = new Item(processed);
	    category.add(ci);

	}

	// If there was a category pending, add it to the set.

	if ( category != null ) {
	    set.add(category);
	}

	return set;
    }

}
