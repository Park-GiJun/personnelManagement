package utils;

import java.util.Random;

public class GenerateCode {

	public GenerateCode() {

	}

	public String makeCode() {

		String upperAlphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String lowerAlphabets = "abcdefghijklmnopqrstuvwxyz";
		String numbers = "0123456789";

		String alphaNumeric = upperAlphabets + lowerAlphabets + numbers;
		StringBuilder sb = new StringBuilder();
		Random random = new Random();

		int length = 10;

		for (int i = 0; i < length; i++) {
			int index = random.nextInt(alphaNumeric.length());
			char randomChar = alphaNumeric.charAt(index);
			sb.append(randomChar);
		}

		String randomString = sb.toString();
		System.out.println("Random String is: " + randomString);
		
		return randomString;
	}
}
