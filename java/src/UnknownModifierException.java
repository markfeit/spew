// package net.notonthe.projects.spew.UnknownModifierException;

/**
 * Thrown when an attempt is made to resolve a category using a form
 * modifier that was not defined.
 */
public class UnknownModifierException extends Exception {
	UnknownModifierException() { super("Unknown modifier"); }
	UnknownModifierException(char modifier) {
	    super("Unknown modifier '" + modifier + "'");
	}
}
