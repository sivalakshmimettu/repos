package in.virendraoswal;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class SpringBootAzureAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringBootAzureAppApplication.class, args);
	}

}


@RestController
class GreetResource {
	
	@GetMapping(value = "/")
	public String greet() {
		return "Greeting from Azure App Service.";
	}
}
