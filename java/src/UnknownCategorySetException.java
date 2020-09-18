// package net.notonthe.projects.spew.UnknownCategorySetException;

/**
 * Thrown when an attempt is made to resolve a category from a
 * <code>CategorySet</code> that does not exist.
 */
public class UnknownCategorySetException extends Exception {
	UnknownCategorySetException() { super("Unknown category set"); }
	UnknownCategorySetException(Integer hash_code) {
	    super("Unknown category set " + hash_code);
	}
}
