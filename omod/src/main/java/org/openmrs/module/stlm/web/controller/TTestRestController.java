package org.openmrs.module.stlm.web.controller;

import org.apache.commons.math3.stat.inference.TTest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;

@Controller
@RequestMapping("/rest/v1/stlm/ttest")
public class TTestRestController {
	
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	public String getTTest(@RequestParam("sample1") String[] sample1, @RequestParam("sample2") String[] sample2) {
		String response;
		double[] arr1 = Arrays.stream(sample1).mapToDouble(Double::parseDouble).toArray();
		double[] arr2 = Arrays.stream(sample2).mapToDouble(Double::parseDouble).toArray();
		TTest ttest = new TTest();
		response = ttest.homoscedasticTTest(arr1, arr2) + "," + ttest.homoscedasticT(arr1, arr2);
		return response;
	}
}
