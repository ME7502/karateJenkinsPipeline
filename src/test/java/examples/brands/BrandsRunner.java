package examples.brands;
import com.intuit.karate.junit5.Karate;

class BrandsRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("brands").relativeTo(getClass());
    }

}
