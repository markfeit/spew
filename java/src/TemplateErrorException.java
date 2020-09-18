// package net.notonthe.projects.spew.TemplateErrorException;

/**
 * Thrown when a syntax error occurs in a template
 *
 */
public class TemplateErrorException extends Exception {

    public int line;

    TemplateErrorException(String s, int line) {
	super(s);
	this.line = line;
    }

    TemplateErrorException(int line) {
	super("Syntax error in template");
	this.line = line;
    }
}
