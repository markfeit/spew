import java.io.*;

/**
 * A command-line front end for the <Code>Spewer</Code> class
 */
public class Spew {


    private static void die( String s ) {
	System.out.println(s);
	System.exit(1);
    }

    /**
     * Emulate the command-line behavior of <code>spew(1)</code>
     *
     * xyzzy - None of the command-line behavior is actually
     * implemented.
     */

    public static void main(String[] args) throws Exception {

	// xyzzy - Parse options

	String template_file = "headline";
	int num_headlines = 1;

	// Read the template file
	TemplateParser parser = new TemplateParser();
	CategorySet set;

	try {
	    set = parser.parse(new
			       BufferedReader(new FileReader(template_file)));

	    // Resolve and print the 'MAIN' category num_headlines times
	    while ( num_headlines-- > 0 ) {
		System.out.println( set.resolve("MAIN") );
	    }
	}
	catch ( TemplateErrorException ex ) {
	    die( ex.getMessage() );
	}
	catch ( IOException ex ) {
	    die( "Error reading file " + ex.getMessage() );
	}


    }
}
