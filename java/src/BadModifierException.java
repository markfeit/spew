// package net.notonthe.projects.spew.BadModifierException;

/**
 * <P>Thrown when a modifier specified for a <code>Category</code> or
 * <code>CategoryModifier</code> either does not exist or contains
 * illegal characters.
 *
 * @see Category
 * @see CategoryModifier
 */
public class BadModifierException extends Exception {
	BadModifierException() { super(); }
	BadModifierException(String s) { super(s); }
}
