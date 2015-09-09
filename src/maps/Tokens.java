package maps;
//import java.util.StringTokenizer;

public class Tokens {
	public static void main(String[] args) {
		/*String[] result = "37.9468114;23.7150237".split(";");
		
	     for (int x=0; x<result.length; x++)
	         System.out.println(result[x]);

	      try {
	         double d = Double.valueOf(result[0].trim()).doubleValue();
	         System.out.println("double d = " + d);
	      } catch (NumberFormatException nfe) {
	         System.out.println("NumberFormatException: " + nfe.getMessage());
	      }
	      */
		
	      String myStr = "xiaomi mi3 500gb";
	      String myNewStr = myStr.replace(" ", "%");
	      System.out.println("old text: " + myStr);
	      System.out.println("new text: " + myNewStr);
    }
}
