// package net.notonthe.projects.spew.CategoryModifier;

/**
 * Represents a set of modifiers to be used against an <class>Item</class>
 *
 * @version $Revision: $
 * @author Mark Feit
 */
public class CategoryModifier {

     private String modifiers;

    /**
     * Constructs a new modifier
     *
     * @param modifiers A string containing the characters that make
     * up the modifier in the order they should be interpreted by a
     * <code>Segment</code> object.
     *
     * @exception BadModifierException
     * @see Segment
     */
    public CategoryModifier( String modifiers )
	throws BadModifierException {

	// Modifiers cannot contain any of the invalid characters
	if ( (modifiers.indexOf('\0') != -1)
	     || (modifiers.indexOf('&') != -1)
	     || (modifiers.indexOf('/') != -1) ) {
	    throw new BadModifierException("Invalid character in modifier");
	}

	// xyzzy - All characters in a modifier must be unique

	// Add a NULL to the front of the string so modifiers can be
	// indexed directly into the values into a SegmentArgSelector.
	this.modifiers = '\0' + modifiers;
    }

    /**
     * Returns the modifier as it would appear in a template file
     */
    public String toString() {
	return ( this.modifiers.length() > 1
		 ? "{" + this.modifiers.substring(1) + "}"
		 : "" );
    }

    /**
     * Returns the original list of modifiers specified when the
     * object was created.
     */
    public String modifiers() {
	return this.modifiers.substring(1); // Chop off the \0 at the beginning
    }

    /**
     * Returns the index of the specified character in the modifier
     * list or 0 if the no-modifier character (<code>'\0'</code>) is
     * specified.
     *
     * @exception UnknownModifierException
     */
    public int index( char modifier )
	throws UnknownModifierException {

	// No modifier is always index 0
	if ( (modifier == '\0') || (modifier == ' ') ) {
	    return 0;
	}

	int index = this.modifiers.indexOf(modifier);

	// Hurl if the modifier wasn't there
	if ( index == -1 ) {
	    throw new UnknownModifierException(modifier);
	}

	return index;
    }
}
