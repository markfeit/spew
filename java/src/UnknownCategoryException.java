// package net.notonthe.projects.spew.UnknownCategoryException;

/**
 * Thrown when an attempt is made to resolve a category that does not
 * exist.
 */
public class UnknownCategoryException extends Exception {
	UnknownCategoryException() { super("Unknown category"); }
	UnknownCategoryException(String s) {
	    super("Unknown category '" + s + "'");
	}
}
