// package net.notonthe.projects.spew.Item;

import java.util.Vector;
import java.util.regex.*;

/**
 * <P>Represents an item within a category.
 *
 * @see Item
 * @version $Revision $
 * @author Mark Feit
 */

public class Item {

    private String text;
    private int weight;
    private Vector seglist;

    // Patterns used by this class

    private static final Pattern newline_pattern
	= Pattern.compile( "\\\\!" );

    private static final Pattern weight_pattern
	= Pattern.compile( "(?s)\\A(\\((\\d+)\\)).*" );

    private static final Pattern plain_text_pattern
	= Pattern.compile( "(?s)\\A([^\\\\\\{]+).*" );

    private static final Pattern cat_inv_pattern
	= Pattern.compile( "(?s)\\A(\\\\(\\w+)(/([&\\w ]))?).*" );

    private static final Pattern arg_sel_pattern
	= Pattern.compile( "(?s)\\A(\\{([^\\}]+)\\}).*" );

    /**
     * Creates a new item from a string.  The string consists of an
     * optional weight at the beginning followed by free-form text.
     * The weight is specified by placing a positive integer in
     * parentheses, for example <code>(20)</code> or <code>(5)</code>.
     *
     * <P>The remainder of the text consists of any number of the
     * folowing, occurring in any combination:
     *
     * <UL>
     * <LI>Plain text, such as <code>Good Afternoon</code>
     * <LI>Newline embedders, which are always represented as <code>\!</code>
     * <LI>Category invocations, such as <code>\VEHICLE/s</code>
     * <LI>Modifier selectors, such as <code>{|some|many}</code>
     * </UL>
     *
     * <P>See the template format documentation in the Spew source
     * distribution for full details on
     *
     * @param string The string to be converted
     *
     * @see TemplateParser
     */
    public Item( String string ) {

	this.text = string;
	this.seglist = new Vector();

	// Replace \! with newlines and make a copy of the string so
	// we don't cream the original.

	Matcher newline_match = newline_pattern.matcher( string );
	StringBuffer line = new StringBuffer( newline_match.replaceAll("\n") );

	// Look for a weight at the head of the string.  If one is
	// present, extract it and remove the text from the string.

	this.weight = 1;
	Matcher weight_match = weight_pattern.matcher(line);
	if ( weight_match.matches() ) {
	    this.weight = Integer.parseInt(weight_match.group(2));
	    line.delete( weight_match.start(1), weight_match.end(1) );
	}

	// Split whatever's left in the string into the segments that
	// make it up.

	while ( line.length() > 0 ) {

	    // Match and delete plain text

	    Matcher plain_match = plain_text_pattern.matcher(line);
	    if ( plain_match.matches() ) {
		this.seglist.add((Object)
				 new SegmentText(plain_match.group(1)));
 		line.delete( plain_match.start(1), plain_match.end(1) );
		continue;
	    }

	    // Match and delete category invocations

	    Matcher cat_inv_match = cat_inv_pattern.matcher(line);
	    if ( cat_inv_match.matches() ) {
		String category = cat_inv_match.group(2);
		String mod_string = cat_inv_match.group(4);
		char mod = ( mod_string != null ?
			     mod_string.charAt(0) : '\0' );
		this.seglist.add( (Object)new SegmentCategoryInvocation
		    (category, mod) );
		line.delete( cat_inv_match.start(1), cat_inv_match.end(1) );
		continue;
	    }

	    // Match and delete argument selectors

	    Matcher arg_sel_match = arg_sel_pattern.matcher(line);
	    if ( arg_sel_match.matches() ) {
		String text = arg_sel_match.group(2);
		this.seglist.add( new SegmentArgSelector(text.split("\\|")) );
		line.delete( arg_sel_match.start(1), arg_sel_match.end(1) );
		continue;
	    }

	}
    }

    /**
     * Returns the item as it would appear in a template file
     */
    public String toString() {
	return this.text;
    }

    /**
     * Returns the weight of the item
     */
    public int weight() {
	return this.weight;
    }

    /**
     * Resolves all of the segments in the item and returns the resulting string
     *
     * @param mod_element The index of the modifier in this item's category
     * @param modifier The character of the modifier in effect
     * @param set_hash The hash code of a <code>CategorySet</code> to
     * be used in resolving references to other categories.
     *
     * @exception UnknownCategoryException
     * @exception UnknownCategorySetException
     * @exception UnknownModifierException
     */
    public String resolve(int mod_element, char modifier, Integer set_hash)
	throws UnknownCategoryException,
	       UnknownCategorySetException,
	       UnknownModifierException {
	StringBuffer result = new StringBuffer();
	for ( int element = 0; element < this.seglist.size(); element++ ) {
	    result.append(
			  ((Segment)(this.seglist.get(element)))
			  .resolve(mod_element, modifier, set_hash)
			  );

	}
	return result.toString();
    }
}
