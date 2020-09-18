// package net.notonthe.projects.spew.Category;

import java.util.Enumeration;
import java.util.Vector;

/**
 * Represents a single category.
 *
 * @see Item
 *
 * @version $Revision $
 * @author Mark Feit
 */
public class Category {

    public String name;
    private CategoryModifier modifier;
    private Vector items;
    private WeightedArray weighted;

    /**
     * Constructs a new <code>Category</code>
     *
     * @param name The category's name
     * @param modifiers Specifies the characters which can be used to
     * select form variants in each of the category's items.
     */
    public Category( String name, String modifiers )
	throws BadModifierException {

	this.name = name;	
	this.modifier = new CategoryModifier(modifiers);
	this.items = new Vector();
	this.weighted = new WeightedArray();
    }

    /**
     * Constructs a new <code>Category</code> with no modifiers
     *
     * @param name The category's name
     */
    public Category( String name )
	throws BadModifierException {
	this( name, "" );
    }
    
    /**
     * Adds an <code>Item</code> to the category using a
     * caller-specified weight.
     *
     * @param item The item to be added
     */
    public void add( Item item, int weight ) {
	// xyzzy - Throw something if the weight isn't positive.
	this.items.add(item);
	this.weighted.put(weight, item);
    }

    /**
     * Adds an <code>Item</code> to the category using the weight in
     * the <code>Item</code>.
     *
     * @param item The item to be added
     */
    public void add( Item item ) {
	add( item, item.weight() );
    }

    /**
     * Returns a string representing the entire category as it would
     * appear in a template file.
     */
    public String toString() {
	StringBuffer result = new StringBuffer( "%" + this.name
						+ this.modifier );

	for ( Enumeration e = this.items.elements(); e.hasMoreElements() ; ) {
	    result.append( "\n" + e.nextElement() );
	}

	return result.toString();
    }

    /**
     * Selects a random item in the category, applies the
     * <code>modifier</code> to the items and returns the formatted
     * string.
     *
     * @param modifier The form modifier to be used, or
     * <code>'\0'</code> if none is to be applied.
     *
     * @param set_hash The hash code for a <code>CategorySet<code>
     * object to be used in resolving any categories called out in
     * items.  Normally, this would be the same
     * <code>CategorySet</code> which contains this
     * <code>Category</code>.
     *
     * @see CategorySet
     */
    public String resolve(char modifier, Integer set_hash)
	throws UnknownModifierException,
	       UnknownCategoryException,
	       UnknownCategorySetException {

	try {
	    Item item;
	    int mod_index = this.modifier.index(modifier);
	    item = (Item)(this.weighted.random());
	    return item.resolve(mod_index, modifier, set_hash);
	}
	catch (IndexOutOfBoundsException ex) {
	    // Empty categories return an empty string.
	    return "";
	}
    }

    /**
     * Selects a random item in the category and returns the formatted
     * string with no modifier applied.
     *
     * @param set_hash The hash code for a <code>CategorySet<code>
     * object to be used in resolving any categories called out in
     * items.  Normally, this would be the same
     * <code>CategorySet</code> which contains this
     * <code>Category</code>.
     *
     * @see CategorySet
     */

    public String resolve(Integer set_hash) throws Exception {
	return resolve('\0', set_hash );
    }

}
