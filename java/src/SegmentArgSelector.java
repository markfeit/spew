// package net.notonthe.projects.spew.SegmentArgSelector;

// This could use java.text.ChoiceFormat, but doing so probably
// doesn't buy us much.

/**
 * Implements a segment which does the rough equivalent of the
 * <code>java.text.ChoiceFormat</code> class in a slightly different format.
 *
 * @see java.text.ChoiceFormat
 *
 * @version $Revision $
 * @author Mark Feit
 */
public class SegmentArgSelector implements Segment {

    private final String[] value;

    /**
     * Constructs a new selector
     *
     * @param value an array of <code>String</code>s containing the
     * values for the selector
     */
    public SegmentArgSelector ( String[] value ) {
	this.value = value;
    }

    /**
     * Returns the selector as it would appear in a template file
     */
    public String toString() {

	StringBuffer result = new StringBuffer("{");

	for (int element = 0; element < this.value.length; element++ ) {
	    result.append( element > 0 ? "|" : "" );
	    result.append( this.value[element].equals("") ? "_" : this.value[element] );
	}

	result.append("}");
	return result.toString();
    }

    /**
     * Calculates and returns finished text for the selector
     *
     * @see Segment
     */
    public String resolve(int element, char modifier, Integer cat_hash) {
	try {
	    return this.value[element];
	}
	catch (ArrayIndexOutOfBoundsException e) {
	    // Anything not in the array returns the empty string.
	    // xyzzy - Although we should probably throw something.
	    return "";
	}
    }

}
