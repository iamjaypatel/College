class LinearTable{
	public final int size = 7;
	private HashItem() table = new HashItem(size);
	
	public int code(String key){
		return (Math.abs(key.hashcode())%size)
	}

	public boolean add(String key, String value){
		int prob;
		int code = code(key);
		if((table[code] == null) || table[code].isDeleted()){
			table[code] = new HashItem(key, data);
			prob = -1;
		} else {
			if(code == (table.length-1)){
				prob = 0;
			} else {
				prob = 1;
			}
		}

		while(prob != -1 && (prob != code)){
			if((table(prob) == null) || table[prob].isDeleted()){
				table[prob] = new HashItem(key, data);
				prob = -1;
			} else {
				if(prob == (table.length-1)){
					prob = 0;
				} else {
					prob++;
				}
			}
		}
	}

	if(prob != -1){
		return false;
	} else {
		return true;
	}

	public boolean delete(String key){
		int prob;
		int code = code(key);
		if(table[code] == null){
			System.out.println("No elements in at this position.");
		} else if(table[code].getKey().equals(key)){
			table[code].setDeleted();
			prob = -1;
			return true;
		} else {
			if(code == (table.length-1)){
				prob = 0;
			} else {
				prob = code + 1;
			}
		}

		while((prob != -1) && (prob != code)){
			if(table[prob] == null){
				return false;
			} else if(table[prob].getKey().equals(key)){
				table[code].setDeleted();
				return true;
			} else {
				if(prob == (table.length -1)){
					prob = 0;
				} else {
					prob++;
				}
			}

		}
		return false;
	}
}

// are Mit linear probing hash table.