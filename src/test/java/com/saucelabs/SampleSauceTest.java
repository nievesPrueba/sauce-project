package com.saucelabs;

import com.saucelabs.common.SauceOnDemandAuthentication;
import com.saucelabs.common.SauceOnDemandSessionIdProvider;
import com.saucelabs.testng.SauceOnDemandAuthenticationProvider;
import com.saucelabs.testng.SauceOnDemandTestListener;

import org.openqa.selenium.By;
import org.openqa.selenium.Platform;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Listeners;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertTrue;


/**
 * Simple TestNG test which demonstrates being instantiated via a DataProvider in order to supply multiple browser combinations.
 */
@Listeners({SauceOnDemandTestListener.class})
public class SampleSauceTest implements SauceOnDemandSessionIdProvider, SauceOnDemandAuthenticationProvider {
    
     public static final int DEFAULT_WAIT = 60;

    /**
     * Constructs a {@link com.saucelabs.common.SauceOnDemandAuthentication} instance using the supplied user name/access key.  To use the authentication
     * supplied by environment variables or from an external file, use the no-arg {@link com.saucelabs.common.SauceOnDemandAuthentication} constructor.
     */
    public SauceOnDemandAuthentication authentication = new SauceOnDemandAuthentication("travis-arq-testing1", "0c5a2380-863d-45c7-b6d0-2c55d6d93ba1");
    //public SauceOnDemandAuthentication authentication = new SauceOnDemandAuthentication("travis-arq-testing", "dfcd0c77-25c6-42ba-92f3-d85e08bb036c");

    /**
     * ThreadLocal variable which contains the  {@link WebDriver} instance which is used to perform browser interactions with.
     */
    private ThreadLocal<WebDriver> webDriver = new ThreadLocal<WebDriver>();

    /**
     * ThreadLocal variable which contains the Sauce Job Id.
     */
    private ThreadLocal<String> sessionId = new ThreadLocal<String>();

    /**
     * DataProvider that explicitly sets the browser combinations to be used.
     *
     * @param testMethod
     * @return
     */
    @DataProvider(name = "hardCodedBrowsers", parallel = true)
    public static Object[][] sauceBrowserDataProvider(Method testMethod) {
        return new Object[][]{
		new Object[]{"firefox", "49", "Windows 10"},
               //new Object[]{"internet explorer", "11", "Windows 8.1"},
               //new Object[]{"safari", "6", "OSX 10.8"},
        };
    }

    /**
     * /**
     * Constructs a new {@link RemoteWebDriver} instance which is configured to use the capabilities defined by the browser,
     * version and os parameters, and which is configured to run against ondemand.saucelabs.com, using
     * the username and access key populated by the {@link #authentication} instance.
     *
     * @param browser Represents the browser to be used as part of the test run.
     * @param version Represents the version of the browser to be used as part of the test run.
     * @param os Represents the operating system to be used as part of the test run.
     * @return
     * @throws MalformedURLException if an error occurs parsing the url
     */
    private WebDriver createDriver(String browser, String version, String os) throws MalformedURLException {

        DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability(CapabilityType.BROWSER_NAME, browser);
        if (version != null) {
            capabilities.setCapability(CapabilityType.VERSION, version);
        }
        capabilities.setCapability(CapabilityType.PLATFORM, os);
        capabilities.setCapability("name", "Sauce Sample Test");
//	capabilities.setCapability("tunnel-identifier", System.getenv("TRAVIS_JOB_NUMBER"));
	capabilities.setCapability("tunnel-identifier", System.getProperty("travisjob"));
	//capabilities.setCapability("tunnel-identifier", System.getProperty("TRAVIS_JOB_NUMBER"));
	capabilities.setCapability("username", authentication.getUsername());
	capabilities.setCapability("accessKey", authentication.getAccessKey());
	System.out.println("username: "+capabilities.getCapability("username"));
	System.out.println("accessKey: "+capabilities.getCapability("accessKey"));
        webDriver.set(new RemoteWebDriver(
                new URL("http://" + authentication.getUsername() + ":" + authentication.getAccessKey() + "@ondemand.saucelabs.com:80/wd/hub"),
                capabilities));
        sessionId.set(((RemoteWebDriver) getWebDriver()).getSessionId().toString());
        return webDriver.get();
    }

    /**
     * Runs a simple test verifying the title of the amazon.com homepage.
     *
     * @param browser Represents the browser to be used as part of the test run.
     * @param version Represents the version of the browser to be used as part of the test run.
     * @param os Represents the operating system to be used as part of the test run.
     * @throws Exception if an error occurs during the running of the test
     */
//    @Parameters({"iptravis", "travisjob"})
    @Parameters("travisjob")
    @Test(dataProvider = "hardCodedBrowsers")
    public void webDriver(String browser, String version, String os) throws Exception {
        WebDriver driver = createDriver(browser, version, os);
       // driver.get("http://www.amazon.com/");
        //assertEquals(driver.getTitle(), "Amazon.com: Online Shopping for Electronics, Apparel, Computers, Books, DVDs & more");
//	driver.get(getIPTravis() + ":8088/extranet-ssff/login.html#/login");
        driver.get("http://localhost:8088/extranet-ssff/login.html#/login");
	driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        assertEquals(driver.getTitle(), "Portal Clientes Grupo ASV Servicios Funerarios");
        
	WebDriverWait wait = new WebDriverWait(driver, DEFAULT_WAIT);
        wait.until(ExpectedConditions.elementToBeClickable(By.className("btn btn-warning btn-lg btn-block"))); 
        assertTrue(isPresentAndVisible(By.className("btn btn-warning btn-lg btn-block"), driver), "[ERROR] - No visible el botón Inicio Sesión");    
	
        driver.quit();
    }

    /**
     * @return the {@link WebDriver} for the current thread
     */
    public WebDriver getWebDriver() {
        System.out.println("WebDriver" + webDriver.get());
        return webDriver.get();
    }

    /**
     *
     * @return the Sauce Job id for the current thread
     */
    public String getSessionId() {
        return sessionId.get();
    }

    /**
     * <method>getIPTravis</method> returns the IP where the application runs.
     */	
     public String getIPTravis() {
	return System.getProperty("iptravis");
     }
	
    /**
     * <method>getTravisJobNumber</method> returns the current Travis Job number.
     */	
     public String getTravisJobNumber() {
	return System.getProperty("travisjob");
     }    
    /**
     *
     * @return the {@link SauceOnDemandAuthentication} instance containing the Sauce username/access key
     */
    @Override
    public SauceOnDemandAuthentication getAuthentication() {
        return authentication;
    }
	

    /**
     * <method>isPresentAndVisible</method> Method that finds all elements within the current page and returns a List of the elements found.
     * returns true if all the elements of the list are displayed or false if they are not.
     * 
     * @param By locator
     * @return boolean
     */
	public boolean isPresentAndVisible(By locator, WebDriver driver) {
		// find all elements within the current page and returns a List of the elements found.
		List<WebElement> elements = driver.findElements(locator);
		if(elements.size() > 0) {
			//loop throught the list of elements
			for(WebElement elem : elements) {
				//if the first element of the list is not displayed it returns false
				if(!elem.isDisplayed()) {
					return false; 
				}
			}
			return true;
		}
		// returns false if the list of elements is empty.
		return false;
	}	
}

