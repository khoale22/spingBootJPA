package com.heb.pm.entity;

import org.junit.Assert;
import org.junit.Test;

public class ImagePriorityTest {
	private static final String DEFAULT_ID="D";
	private static final String OTHER_ID="O";
	private static final String DEFAULT_ABBREVIATION="DEF";
	private static final String OTHER_ABBREVIATION="OTH";
	private static final String DEFAULT_DESCRIPTION="DEFAULT";
	private static final String OTHER_DESCRIPTION="OTHER";

	/**
	 * Tests the getId method
	 */
	@Test
	public void getIdTest() {
		Assert.assertEquals(DEFAULT_ID, getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION).getId());
	}

	/**
	 * Tests the setId method
	 */
	@Test
	public void setIdTest() {
		ImagePriority obj = getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION);
		obj.setId(OTHER_ID);
		Assert.assertEquals(OTHER_ID, obj.getId());
	}

	/**
	 * Tests the getAbbreviation method
	 */
	@Test
	public void getAbbreviationTest() {
		Assert.assertEquals(DEFAULT_ABBREVIATION, getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION).getAbbreviation());
	}

	/**
	 * Tests the setAbbreviation method
	 */
	@Test
	public void setAbbreviationTest() {
		ImagePriority obj = getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION);
		obj.setAbbreviation(OTHER_ABBREVIATION);
		Assert.assertEquals(OTHER_ABBREVIATION, obj.getAbbreviation());
	}

	/**
	 * Tests the getDescription method
	 */
	@Test
	public void getDescriptionTest() {
		Assert.assertEquals(DEFAULT_DESCRIPTION, getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION).getDescription());
	}

	/**
	 * Tests the setDescription method
	 */
	@Test
	public void setDescriptionTest() {
		ImagePriority obj = getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION);
		obj.setDescription(OTHER_DESCRIPTION);
		Assert.assertEquals(OTHER_DESCRIPTION, obj.getDescription());
	}

	/**
	 * Tests the toString method
	 */
	@Test
	public void toStringTest() {
		Assert.assertEquals("ImagePriority{id='D', abbreviation='DEF', description='DEFAULT'}",
				getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION).toString());
	}

	/**
	 * Tests the equals method of the same object
	 */
	@Test
	public void equalsTest(){
		ImagePriority obj = getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION);
		Assert.assertTrue(obj.equals(getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION)));
	}

	/**
	 * Tests the equal method of two different objects
	 */
	@Test
	public void notEqualsTest(){
		ImagePriority obj = getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION);
		Assert.assertFalse(obj.equals(getDefaultRecord(OTHER_ID, OTHER_ABBREVIATION, OTHER_DESCRIPTION)));
	}

	/**
	 * Tests the hash code of the same object
	 */
	@Test
	public void hashSameCodeTest(){
		ImagePriority obj = getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION);
		Assert.assertEquals(obj.hashCode(), obj.hashCode());
	}

	/**
	 * Tests the hash code of two different objects
	 */
	@Test
	public void hashDifferentCodeTest(){
		ImagePriority obj = getDefaultRecord(DEFAULT_ID, DEFAULT_ABBREVIATION, DEFAULT_DESCRIPTION);
		ImagePriority objb = getDefaultRecord(OTHER_ID, OTHER_ABBREVIATION, OTHER_DESCRIPTION);
		Assert.assertNotEquals(obj.hashCode(), objb.hashCode());
	}

	private ImagePriority getDefaultRecord(String id, String abbreviation, String description){
		ImagePriority record = new ImagePriority();
		record.setId(id);
		record.setAbbreviation(abbreviation);
		record.setDescription(description);
		return record;
	}

}