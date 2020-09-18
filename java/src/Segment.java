// package net.notonthe.projects.spew.Segment;

/**
 * This interface provides a standard hook for requesting that the
 * various types of segments that make up an item produce finished
 * text.
 */
public interface Segment {

    /**
     * Calculates and returns finished text for a segment
     *
     * @param element The index of whatever modifier selected for the
     * category containing the item containing the segment.
     * @param modifier The character of the modifier selected for the
     * category containing the item containing the segment.
     * @param cat_set_hash The hash code of a <code>CategorySet</code>
     * which can be used to resolve categories called out in segments.
     *
     * @exception UnknownCategoryException
     * @exception UnknownCategorySetException
     * @exception UnknownModifierException
     */
    public String resolve(int element, char modifier, Integer cat_set_hash)
	throws UnknownCategoryException,
	       UnknownCategorySetException,
	       UnknownModifierException;
}
