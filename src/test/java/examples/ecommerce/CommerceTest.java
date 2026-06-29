package examples.ecommerce;

import com.intuit.karate.junit5.Karate;

public class CommerceTest {
    @Karate.Test
    Karate testCommerce() {
        return Karate.run("commerce").relativeTo(getClass());
    }
}
