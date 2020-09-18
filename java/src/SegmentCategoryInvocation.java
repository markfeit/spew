// package net.notonthe.projects.spew.SegmentCategoryInvocation;

/**
 * Implements a segment which resolves a <code>Category</code> and
 * returns the text it produced.
 *
 * @version $Revision $
 * @author Mark Feit
 */

public class SegmentCategoryInvocation implements Segment {

    public final String category;
    public final char modifier;

    /**
     * Creates a new category invocation
     *
     * @param category a string naming the category to be invoked
     * @param modifier a character indicating which form modifier
     * should be used
     */
    public SegmentCategoryInvocation ( String category, char modifier ) {

	// xyzzy - Check to see if the category exists
	this.category = category;

	// xyzzy - Check to see if the modifier is valid
	this.modifier = modifier;
    }

    /**
     * Creates a new category invocation without a modifier
     *
     * @param category a string naming the category to be invoked
     */

    public SegmentCategoryInvocation ( String category ) {
	this( category, (char)0 );
    }

    /**
     * Returns the segment as it would appear in a template
     */
    public String toString() {
	String mod = this.modifier != '\0' ? "/" + this.modifier : "";
	return "\\" + this.category + mod;		    
    }

    /**
     * Calculates and returns finished text for the selector
     *
     * @see Segment
     */
    public String resolve(int element, char modifier, Integer cat_hash)
    throws UnknownCategoryException,
	   UnknownCategorySetException,
	   UnknownModifierException {

	// If this invocation specified a pass-through, pass on
	// whatever the caller specified.

	return CategorySet.resolve(cat_hash, this.category,
				(this.modifier == '&'
				 ? modifier : this.modifier) );
    }
}
