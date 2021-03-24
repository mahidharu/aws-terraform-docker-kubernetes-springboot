@RestController
public class WelcomeController {

	@RequestMapping("/")
	public String home(@RequestParam(value = "name", defaultValue = "home") String name) {
		return "Home";

	}
}