// package net.notonthe.projects.spew.WeightedArray;

import java.util.Enumeration;
import java.util.Random;
import java.util.Vector;

/** 

 * <P>This is an array which stored objects and retrieves them
 * according to an assigned <I>weight</I>.  Larger weights increase
 * the probability that a random number within the total weight of the
 * elements will select a particular element.
 *
 * <P> For example: Assume object A is stored with a weight of 4 and
 * object B is stored with a weight of 1.  The total weight of this
 * array would be 5 (1+4).  Selecting an element at random from the
 * range of the total weight (1..5), element A would have an 0.8
 * probability of being selected compared to 0.2
 *
 *
 * @version $Revision: $
 * @author  Mark Feit
 */

public class WeightedArray {

    /**
     * Used internally to hold elements.
     */
    class WeightedArrayElement {

	private int upper;
	private Object value;

	public WeightedArrayElement(int upper, Object value) {
	    this.upper = upper;
	    this.value = value;
	}

    }

    private int max;
    private Vector ranges;
    private Random random;

    /**
     * Constructs a new <code>WeightedArray</code>
     */
    public WeightedArray() {
	this.max = 0;
	this.ranges = new Vector();
	this.random = new Random();
    }

    /**
     * Adds an element to the array
     * @param weight Indicates the object's weight
     * @param object The value to be stored
     */
    public void put(int weight, Object object)
    {
	this.max += weight;
	WeightedArrayElement e = new WeightedArrayElement( this.max-1, object);
	ranges.add(e);
    }

    /**
     * Retrieves an object stored in the array
     *
     * @param number The number used to determine what position in the
     * weight range will be used to find the object returned
     *
     * @exception IndexOutOfBoundsException When <code>number</code>
     * is greater than the total weight of the array.
     */
    public Object get(int number)
	throws IndexOutOfBoundsException {

	// If the number is greater than the maximum weight, hurl now.
	if ( number > this.max ) {
	    throw new IndexOutOfBoundsException();
	}

	Enumeration e = this.ranges.elements();
	while (  e.hasMoreElements() ) {

	    WeightedArrayElement element
		= (WeightedArrayElement)e.nextElement();

	    if ( element.upper >= number ) {
		return element.value;
	    }
	}

	// If not found, hurl.  In theory, this should never happen.
	throw new IndexOutOfBoundsException("Array is empty.");
    }

    /**
     * Selects a random object from the array based on weights.
     *
     * @exception IndexOutOfBoundsException when the array is empty.
     */
    public Object random() throws IndexOutOfBoundsException {
	return get( this.random.nextInt(this.max) );
    }

    /**
     * Returns the total weight of the array
     */
    public int totalWeight() {
	return this.max;
    }
}
