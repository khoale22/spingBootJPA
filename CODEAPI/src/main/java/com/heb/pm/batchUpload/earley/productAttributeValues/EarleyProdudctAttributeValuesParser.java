package com.heb.pm.batchUpload.earley.productAttributeValues;

import com.heb.pm.batchUpload.earley.FileProcessingException;
import com.heb.util.file.CsvParser;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

/**
 * @author d116773
 * @since 2.16.0
 */
public class EarleyProdudctAttributeValuesParser {

	private static final int PRODUCT_ID_COLUMN = 0;
	private static final int ATTRIBUTE_ID_COLUMN = 2;
	private static final int ATTRIBUTE_VALUE_ID_COLUMN = 5;

	private static final String EARLEY_PRODUCT_ID_HEADER = "Product ID";
	private static final String EARLEY_ATTRIBUTE_ID_HEADER = "Attribute ID";
	private static final String ATTRIBUTE_VALUE_ID_HEADER = "Value ID";

	private CsvParser csvParser = new CsvParser();

	/**
	 * Validates the header of the file.
	 *
	 * @param file The file to validate.
	 * @throws FileProcessingException
	 */
	public void validateHeaderRecord(MultipartFile file) throws FileProcessingException {

		List<String> csvHeader;

		try {
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(file.getInputStream()));
			csvHeader = this.csvParser.parseLine(bufferedReader.readLine());
		} catch (IOException e) {
			throw new FileProcessingException(e.getMessage());
		}
		if (!csvHeader.get(EarleyProdudctAttributeValuesParser.PRODUCT_ID_COLUMN).equals(EarleyProdudctAttributeValuesParser.EARLEY_PRODUCT_ID_HEADER)) {
			throw new FileProcessingException(String.format("File does not contain product IDs in column %d", EarleyProdudctAttributeValuesParser.PRODUCT_ID_COLUMN));
		}
		if (!csvHeader.get(EarleyProdudctAttributeValuesParser.ATTRIBUTE_ID_COLUMN).equals(EarleyProdudctAttributeValuesParser.EARLEY_ATTRIBUTE_ID_HEADER)) {
			throw new FileProcessingException(String.format("File does not contain Earley Attribute IDs in column %d", EarleyProdudctAttributeValuesParser.ATTRIBUTE_ID_COLUMN));
		}
		if (!csvHeader.get(EarleyProdudctAttributeValuesParser.ATTRIBUTE_VALUE_ID_COLUMN).equals(EarleyProdudctAttributeValuesParser.ATTRIBUTE_VALUE_ID_HEADER)) {
			throw new FileProcessingException(String.format("File does not contain Earley Attribute IDs in column %d", EarleyProdudctAttributeValuesParser.ATTRIBUTE_VALUE_ID_COLUMN));
		}
	}

	public String parseProductId(List<String> csvRecord) throws FileProcessingException {
		if (EarleyProdudctAttributeValuesParser.PRODUCT_ID_COLUMN > csvRecord.size() - 1) {
			throw new FileProcessingException("The product ID field is missing");
		}
		return csvRecord.get(EarleyProdudctAttributeValuesParser.PRODUCT_ID_COLUMN);
	}

	/**
	 * Returns the attribute ID from an Earley attribute record.
	 *
	 * @param csvRecord The record to pull the attribute ID from.
	 * @return The attribute ID.
	 * @throws FileProcessingException
	 */
	public String parseAttributeId(List<String> csvRecord) throws FileProcessingException {
		if (EarleyProdudctAttributeValuesParser.ATTRIBUTE_ID_COLUMN > csvRecord.size() - 1) {
			throw new FileProcessingException("The attribute ID field is missing");
		}
		return csvRecord.get(EarleyProdudctAttributeValuesParser.ATTRIBUTE_ID_COLUMN);
	}



	/**
	 * Returns the attribute value ID from an Earley attribute record.
	 *
	 * @param csvRecord The record to pull the attribute value ID from.
	 * @return The attribute value ID.
	 * @throws FileProcessingException
	 */
	public String parseAttributeValueId(List<String> csvRecord) throws FileProcessingException {
		if (EarleyProdudctAttributeValuesParser.ATTRIBUTE_VALUE_ID_COLUMN > csvRecord.size() - 1) {
			throw new FileProcessingException("The attribute value ID field is missing");
		}
		return csvRecord.get(EarleyProdudctAttributeValuesParser.ATTRIBUTE_VALUE_ID_COLUMN);
	}
}
