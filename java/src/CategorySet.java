// package net.notonthe.projects.spew.CategorySet;

import java.util.Enumeration;
import java.util.Hashtable;

/** 
 * Container object for any number of <code>Category</code> objects.
 *
 * @version $Revision: $
 * @author  Mark Feit
 */

public class CategorySet {

    static Hashtable stored_sets = new Hashtable();

    private Hashtable stored;
    private Integer hash_code;

    /**
     * Creates a new <code>CategorySet</code>
     */
    public CategorySet() {
	this.stored = new Hashtable();
	this.hash_code = new Integer(this.hashCode());
	// Keys must be objects, so an int can't be stored directly.  D'oh.
	stored_sets.put(this.hash_code, this);
    }

    /**
     * For internal use only.
     */
    public void finalize() {
	stored_sets.remove( new Integer(this.hashCode()) );
    }

    /**
     * Adds a new category to the set
     *
     * @param category The category to be added.  The name of the
     * category will be extracted from the object passed in.
     */
    public void add( Category category )
    {
	this.stored.put(category.name, category);
    }

    /**
     * Returns a string containing all of the categories formatted as
     * they would be in a template file.
     */
    public String toString() {
	StringBuffer result = new StringBuffer();

	// xyzzy - Find a way to sort this
	int count = 0;
	Enumeration e = this.stored.elements();
	while ( e.hasMoreElements() ) {
	    result.append( ( count++ > 0 ? "\n\n" : "" ) + e.nextElement() );
	}

	return result.toString();
    }

    /**
     * Checks to see whether or not a specified category exists in the set
     *
     * @param category Names the category to be looked at
     */
    public boolean hasCategory(String category) {
	return this.stored.containsKey(category);
    }


    /**
     * Returns a random value from a category modified as specified.
     *
     * @param name Names the category to be resolved
     * @param modifier Indicates which form modifier should be used
     *
     * @exception InternalError
     * @exception UnknownCategoryException
     * @exception UnknownModifierException
     */
    public String resolve(String name, char modifier)
	throws InternalError,
	       UnknownCategoryException,
	       UnknownModifierException {

	// Find the category
	Category category = (Category)stored.get(name);
	if ( category == null ) {
	    throw new UnknownCategoryException(name);
	}

	try {
	    return category.resolve(modifier, this.hash_code);
	}
	catch (UnknownCategorySetException ex) {
	    throw new InternalError("CategorySet: Invalid hash_code");
	}
    }

    /**
     * Returns a random value from a category
     *
     * @param name Names the category to be resolved
     *
     * @exception InternalError
     * @exception UnknownCategoryException
     * @exception UnknownModifierException
     */
    public String resolve(String name)
	throws InternalError,
	       UnknownCategoryException,
	       UnknownModifierException {

	return this.resolve(name, '\0');
    }

    /**
     * Resolves a category from a CategorySet specified by its hash
     * code.  This method should not be used by anything except the
     * <code>SegmentCategoryInvocation</code> class.
     *
     * @see SegmentCategoryInvocation
     */
    static public String resolve(Integer set_code, String name, char modifier)
	throws UnknownCategoryException,
	       UnknownCategorySetException,
	       UnknownModifierException {

	CategorySet set = (CategorySet)stored_sets.get(set_code);
	if ( set == null ) {
	    throw new UnknownCategorySetException(set_code);
	}
	return set.resolve( name, modifier );
    }

}
