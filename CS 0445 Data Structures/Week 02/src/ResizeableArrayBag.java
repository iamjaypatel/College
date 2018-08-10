public class ResizeableArrayBag<T> implements BagInterface<T> {
	private ArrayBag<T> aBag=null;

	/**
	 * 
	 */
	public ResizeableArrayBag() {
		this(BagInterface.DEFAULT_CAPACITY);
	}

	/**
	 * @param capacity
	 */
	public ResizeableArrayBag(int capacity) {
		aBag = new ArrayBag<>(capacity);
	}

	/** Adds a new entry to this bag.
	 * @param newEntry  The object to be added as a new entry.
	 * @return True if the addition is successful, or false if not.
	 */
	public boolean add(T newEntry) {
		boolean result = aBag.add(newEntry);
		if(!result) {
			doubleCapacity();
			result = aBag.add(newEntry);
		} 
		return result;
	}

	private void doubleCapacity() {
		if(2*aBag.getCurrentSize() > MAX_CAPACITY) {
			throw new IllegalStateException("An attempt to exceed the maximum capacity of a ResizeableArrayBag "
					+ "object.");
		} else {
			@SuppressWarnings("unchecked")
			T[] entries = (T[])aBag.toArray();
			aBag = new ArrayBag<>(2*aBag.getCurrentSize());
			for(T entry : entries) {
				aBag.add(entry);
			}
		}
	}

	@Override
	public int getCurrentSize() {
		return aBag.getCurrentSize();
	}

	@Override
	public boolean isEmpty() {
		return aBag.isEmpty();
	}

	@Override
	public T remove() {
		return aBag.remove();
	}

	@Override
	public boolean remove(T anEntry) {
		return aBag.remove(anEntry);
	}

	@Override
	public void clear() {
		aBag.clear();
	}

	@Override
	public int getFrequencyOf(T anEntry) {
		return aBag.getFrequencyOf(anEntry);
	}

	@Override
	public boolean contains(T anEntry) {
		return aBag.contains(anEntry);
	}

	@Override
	public Object[] toArray() {
		return aBag.toArray();
	}
}
