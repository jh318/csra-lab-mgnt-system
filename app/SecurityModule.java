import com.google.inject.AbstractModule;
import org.pac4j.cas.client.CasClient;
import org.pac4j.core.client.Clients;
import org.pac4j.core.config.Config;
import org.pac4j.oauth.client.CasOAuthWrapperClient;
import org.pac4j.play.ApplicationLogoutController;
import org.pac4j.play.CallbackController;
import org.pac4j.play.cas.logout.PlayCacheLogoutHandler;
import org.pac4j.play.store.PlayCacheStore;
import play.Configuration;
import play.Environment;

import java.io.File;

public class SecurityModule extends AbstractModule {

    public final static String JWT_SALT = "12345678901234567890123456789012";

    private final Environment environment;
    private final Configuration configuration;

    public SecurityModule(
            Environment environment,
            Configuration configuration) {
        this.environment = environment;
        this.configuration = configuration;
    }

    @Override
    protected void configure() {
        final String baseUrl = configuration.getString("baseUrl");

        // CAS
        final CasOAuthWrapperClient casClient = new CasOAuthWrapperClient("this_is_the_key2", "this_is_the_secret2", "http://localhost:8080/cas2/oauth2.0");
        casClient.setName("CasClient");
        /*final CasClient casClient = new CasClient("https://casserverpac4j.herokuapp.com/login");
        casClient.setLogoutHandler(new PlayCacheLogoutHandler());*/
        // casClient.setGateway(true);
        /*final CasProxyReceptor casProxyReceptor = new CasProxyReceptor();
        casProxyReceptor.setCallbackUrl("http://localhost:9000/casProxyCallback");
        casClient.setCasProxyReceptor(casProxyReceptor);*/

        final Clients clients = new Clients(baseUrl + "/callback", casClient); // , casProxyReceptor);

        final Config config = new Config(clients);
        bind(Config.class).toInstance(config);

        // set profile timeout to 2h instead of the 1h default
        PlayCacheStore store = new PlayCacheStore();
        store.setProfileTimeout(7200);
        config.setSessionStore(store);

        // callback
        final CallbackController callbackController = new CallbackController();
        callbackController.setDefaultUrl("/");
        bind(CallbackController.class).toInstance(callbackController);
        // logout
        final ApplicationLogoutController logoutController = new ApplicationLogoutController();
        logoutController.setDefaultUrl("/");
        bind(ApplicationLogoutController.class).toInstance(logoutController);
    }
}