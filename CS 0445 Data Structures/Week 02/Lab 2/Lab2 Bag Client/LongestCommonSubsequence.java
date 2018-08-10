
import java.io.*;
import java.util.*;

/**
 * LongestCommonSubsequence is a program that will determine the longest string that is 
 * a subsequence of two input strings. This program applies a brute force solution technique.
 * 
 * @author Charles Hoot
 * @version 4.0
 */
public class LongestCommonSubsequence {

    public static void main(String args[]) {
        BagInterface<String> toCheckContainer = null;

        Scanner input;
        input = new Scanner(System.in);

        System.out.println("This program determines the longest string that is a subsequence of two input string.");
        System.out.println("Please enter the first string:");
        String first = input.next();

        System.out.println("Please enter the second string:");
        String second = input.next();



        // ADD CODE HERE TO CREATE THE BAG WITH THE INITIAL STRING

        System.out.println("The strings to check are: " + toCheckContainer);
        String bestSubsequence = new String("");


        // ADD CODE HERE TO CHECK THE STRINGS IN THE BAG
        System.out.println("Found " + bestSubsequence + " for the longest common subsequence");

    }

    /**
     * Determine if one string is a subsequence of the other.
     *
     * @param check See if this is a subsequence of the other argument.
     * @param other The string to check against. 
     * @return     A boolean if check is a subsequence of other. 
     */
    public static boolean isSubsequence(String check, String against) {
        boolean result = false;

        // ADD CODE HERE TO CHECK IF WE HAVE A SUBSEQUENCE
        return result;
    }
}
