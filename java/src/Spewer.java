// package net.notonthe.projects.spew.Spewer;

/**
 * Front-end to <code>CategorySet</code> which implements the default
 * category.
 *
 * @version $Revision $
 * @author Mark Feit
 */

public class Spewer {

    CategorySet template;

    /**
     * Creates a new spewer
     *
     * @param template a <code>CategorySet</code> to be used by the
     * spewer
     */
    public Spewer(CategorySet template) {
	this.template = template;
    }

    /**
     * Spew a string using the default category (<code>%MAIN</code>)
     *
     * @exception InternalError
     * @exception UnknownCategoryException
     * @exception UnknownModifierException
     */
    public String spew()
	throws InternalError,
	       UnknownCategoryException,
	       UnknownModifierException {

	return template.resolve("MAIN");
    }

    /**
     * Spew a string using a caller-provided category
     *
     * @param category a string naming the category to be spewed
     *
     * @exception InternalError
     * @exception UnknownCategoryException
     * @exception UnknownModifierException
     */

    public String spew(String category)
	throws InternalError,
	       UnknownCategoryException,
	       UnknownModifierException {

	return template.resolve(category);
    }

}
