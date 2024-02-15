package restApi;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

// How to Run it - mvn clean test "-Dkarate.options=--tags @debug"
class RunnerRestApiTest {

    @Test
    void testRestApi() {
        Results oResult = Runner.path("scenario/WebServiceExtern")
                .outputCucumberJson(true)
                .relativeTo(getClass())
                .parallel(5);
        assertEquals(0, oResult.getFailCount(), oResult.getErrorMessages());
    }

}