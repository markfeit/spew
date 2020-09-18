// package net.notonthe.projects.spew.SegmentText;

/**
 * Implements a segment which holds plain text
 *
 * @version $Revision $
 * @author Mark Feit
 */

public class SegmentText implements Segment {

    private final String text;

    /**
     * Creates a new text segment
     *
     * @param text the text that makes up the segment
     */
    public SegmentText( String text ) {
	this.text = text;
    }

    /**
     * Returns the segment as it would appear in a template
     */
    public String toString() {
	String result = new String(this.text);
	result.replaceAll("\\n", "\\!");
	return this.text;
    }

    /**
     * Returns the segment's text
     *
     * @see Segment
     */
    public String resolve(int element, char modifier, Integer cat_hash) {
	return this.text;
    }

}
