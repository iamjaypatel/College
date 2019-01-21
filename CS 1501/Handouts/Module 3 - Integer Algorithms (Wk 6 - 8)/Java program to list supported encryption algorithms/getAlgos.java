import java.security.*;
import java.util.*;
public class getAlgos
{
	public static String[] getServiceTypes() {
    Set result = new HashSet();

	// The two methods below were obtained from Example Depot:
	// http://www.exampledepot.com/egs/java.security/ListServices.html
	
    // All all providers
    Provider[] providers = Security.getProviders();
    for (int i=0; i<providers.length; i++) {
        // Get services provided by each provider
        Set keys = providers[i].keySet();
        for (Iterator it=keys.iterator(); it.hasNext(); ) {
            String key = (String)it.next();
            key = key.split(" ")[0];

            if (key.startsWith("Alg.Alias.")) {
                // Strip the alias
                key = key.substring(10);
            }
            int ix = key.indexOf('.');
            result.add(key.substring(0, ix));
        }
    }
    return (String[])result.toArray(new String[result.size()]);
	}
	
	// This method returns the available implementations for a service type
	public static String[] getCryptoImpls(String serviceType) {
    Set result = new HashSet();

    // All all providers
    Provider[] providers = Security.getProviders();
    for (int i=0; i<providers.length; i++) {
        // Get services provided by each provider
        Set keys = providers[i].keySet();
        for (Iterator it=keys.iterator(); it.hasNext(); ) {
            String key = (String)it.next();
            key = key.split(" ")[0];

            if (key.startsWith(serviceType+".")) {
                result.add(key.substring(serviceType.length()+1));
            } else if (key.startsWith("Alg.Alias."+serviceType+".")) {
                // This is an alias
                result.add(key.substring(serviceType.length()+11));
            }
        }
    }
    return (String[])result.toArray(new String[result.size()]);
	}
	
	public static void main(String [] args)
	{
		 String [] Stypes = getServiceTypes();
		 for (String S: Stypes)
		 {
		 	System.out.println("Service: " + S);
		 	String [] algos = getCryptoImpls(S);
		 	for (String A: algos)
		 	{
		 		System.out.println("Algo: " + A);
		 	}
		 	System.out.println();
		 }
	}
}



