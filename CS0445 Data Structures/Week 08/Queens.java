class Queens {
	
	static boolean[][] board = new boolean[8][8];
	private static void placeQueen(int col)
	{
		if(col >= 8){
			for(int i=0; i<8; i++){
				for(int j=0; j<8; j++)
					System.out.print(board[i][j] + "\t");
				System.out.println();
			}
			System.exit(0);
		}
		for(int i=0; i<8; i++){
			if(safe(i, col)){
				board[i][col] = true;
				placeQueen(col+1);
				board[i][col] = false;
			}			
		}		
	}
	
	private static boolean safe(int r, int c)
	{		
		//check the row
		for(int i=0; i<c; i++){			
			if(board[r][i])
				return false;
		}
		
		//check the left diagonal
		int i = r-1;
		int j = c-1;
		while((i >= 0)&& (j >= 0)){			
			if(board[i][j])
				return false;
			i--;
			j--;			
		}
		
		//check the right diagonal
		i = r+1;
		j = c-1;
		while((i < 8)&& (j >= 0)){			
			if(board[i][j])
				return false;
			i++;
			j--;			
		}
		return true;		
	}
	
	public static void main(String[] args){
		for(int i=0; i<8; i++)
			for(int j=0; j<8; j++)
				board[i][j] = false;
		placeQueen(0);
	
	}
	
	
}