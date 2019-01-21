/**
 * A class for a bag whose entries are stored as
 * a chain of linked nodes.
 * @author Sherif Khattab
 *
 * @param <T> Data type of each bag entry.
 */
public final class LinkedBag<T> 
implements BagInterface<T> {

	private Node firstNode; //reference to the first node
	private int numberOfEntries;

	public LinkedBag() {
		firstNode = null;
		numberOfEntries = 0;
	}
	@Override
	public int getCurrentSize() {
		return numberOfEntries;
	}

	@Override
	public boolean isEmpty() {
		return numberOfEntries == 0;
	}

	@Override
	public boolean add(T newEntry) {
		//Add to the beginning of the chain
		boolean result = true;

		Node newNode = new Node(newEntry);
		newNode.next = firstNode; //reference the 
		// nodes of the chain
		firstNode = newNode;
		// The last two lines can well be replaced by:
		// Node newNode = new Node(newEntry, firstNode);

		numberOfEntries++;
		return result;
	}

	@Override
	public T remove() {
		T result = null;
		if(firstNode != null) {
			result = firstNode.data;
			firstNode = firstNode.next;
			numberOfEntries--;
		}
		return result;
	}

	@Override
	public boolean remove(T anEntry) {
		boolean result = false;

		Node toRemove = getReferenceTo(anEntry);
		if(toRemove != null) {		
			toRemove.data = firstNode.data;
			firstNode = firstNode.next;
			numberOfEntries--;
			result = true;
		}

		return result;
	}

	@Override
	public void clear() {
		firstNode = null;
		numberOfEntries = 0;
	}

	@Override
	public int getFrequencyOf(T anEntry) {
		int result = 0;

		Node current = firstNode;
		while(current != null) {
			if(anEntry.equals(current.data)) {
				result++;
			}
			current = current.next;
		}

		return result;
	}

	@Override
	public boolean contains(T anEntry) {
		return getReferenceTo(anEntry) != null;
	}

	@Override
	public Object[] toArray() {
		Object[] result = new Object[numberOfEntries];
		Node current = firstNode;
		int i=0;
		while((current!=null) && (i<numberOfEntries)) {
			result[i] = current.data;
			current = current.next;
			i++;
		}

		return result;
	}
	/**
	 * Get the reference to the first node in the chain
	 * that has anEntry as its data portion.
	 * @param anEntry The entry to search for
	 * @return the first node that contains anEntry,
	 * or null otherwise.
	 */
	private Node getReferenceTo(T anEntry) {
		Node result = null;
		boolean found = false;
		Node current = firstNode;
		while((!found) && (current != null)) {
			if(anEntry.equals(current.data)) {
				result = current;
				found = true;
			} else {
				current = current.next;
			}
		}		
		return result;
	}
	class Node {
		private T data;    //bag entry
		private Node next; //reference to next node

		Node(T data) {
			this(data, null);
		}

		Node(T data, Node next) {
			this.data = data;
			this.next = next;
		}
	}
}
