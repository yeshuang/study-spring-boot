package study.spring.boot.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloSpringBootController {

	@GetMapping("/helloSpringBoot")
	public String helloSpringBoot() {
		return "-----------hello bodys-----------";
	}
}
