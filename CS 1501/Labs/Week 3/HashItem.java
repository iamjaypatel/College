class HashItem{
	private String key;
	provate String data;
	private boolean deleted;

	HashItem(String key, String data){
		this.key = key;
		this.data = data;
	}

	public void setDelete(){
		deleted = true;
	}
	public boolean isDeleted(){
		return deleted;
	}
	public String getKey(){
		return key;
	}
	public String getData(){
		return data;
	}
}