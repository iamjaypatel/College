import java.util.Random;

public class Quiz2 {
	
	/** The method counts the number of inversions in 
	 * a list of Comparable items. Consider every pair 
	 * of values in the list. There are n(n-1)/2 pairs. 
	 * Each pair that is out of order contributes one 
	 * to the number of inversions. For example, 
	 * consider the list [5, 6, 1, 5]. It has 6 pairs:
	 * (5,6), (5,1), (5,5), (6,1), (6,5), and (1,5). 
	 * The pairs (5,1), (6,1), and (6,5) are out of 
	 * order and should be counted as inversions. So, 
	 * the number of inversions = 3. A sorted list has 
	 * zero inversions. A reverse sorted list has 
	 * n(n-1)/2 inversions. Don't forget that list 
	 * indexes start from 1.
	 * @param list
	 * @return the number of inversions
	 */
	public static <T extends Comparable<? super T>> 
	int countInversions(ListInterface<T> list) {
		//TODO Implement the method
		return 0;
	}
	
	/** This method takes a list of Comparable items 
	 * (list) and a list of pairs of positions (pairs). 
	 * A pair is two consecutive entries in the pairs 
	 * list. pairs entries number 1 and 2 form the 
	 * first pair, entries 2 and 3 the second, entries
	 *  3 and 4 the third pair, and so on. For example,
	 *  consider the pairs list [3, 7, 1, 5]. It has 3
	 *  pairs: (3,7), (7,1), and (1,5). For each pair 
	 *  of positions, the method checks the list 
	 *  entries located at these positions. It swaps 
	 *  the items if they are out of order. The method
	 *  returns the number of inversions after all the
	 *  pairs have been processed. Note that the pair 
	 *  elements are not necessarily in order.
	 * @param list the list of entries to be shuffled per the description above
	 * @param pairs the list of pairs of positions
	 * @return the number of inversions after all the swaps
	 */
	public static <T extends Comparable<? super T>> 
	int shuffle(ListInterface<T> list,
			ListInterface<Integer> pairs) {
		//TODO Implement the method
		return 0;
	}	
}
