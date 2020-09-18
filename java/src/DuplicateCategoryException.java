// package net.notonthe.projects.spew.DuplicateCategoryException;

/**
 * <P>Thrown when an attempt is made to add a category to a
 * <code>CategorySet</code> which has a name matching one already in
 * it.
 *
 * @see CategorySet
 */

public class DuplicateCategoryException extends Exception {
	DuplicateCategoryException() { super("Category is not unique"); }
	DuplicateCategoryException(String s) { super("Category '" + s + "' is not unique"); }
}
