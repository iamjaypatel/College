/*
 * Jay Patel (jjp107)
 * CS 1501 Lab
 */
public class BoyerMooreSearch{
    public int search(String txt, String pattern) {
        int txtLength = txt.length();
        int patternLength = pattern.length();
        int skip;
        for (int i = 0; i <= txtLength - patternLength; i += skip) {
            skip = 0;
            for (int j = patternLength-1; j >= 0; j--) {
                if (pattern.charAt(j) != txt.charAt(i+j)) {
                    skip = 0; // please calculate the amount of skip
                    break;
                }
            }
            
            if (skip == 0)
                return i;
        }
        return n;
    }
    public static void main(args[]){
        // please write your own test cases
    }
}
