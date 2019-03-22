package com.heb.pm.repository;

import com.heb.pm.entity.ProductScanImageURI;
import com.heb.pm.entity.ProductScanImageURIKey;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
/**
 * Repository for the Product Scan Image URI table
 * @author s753601
 * @version 2.13.0
 */
public interface ImageInfoRepository extends JpaRepository<ProductScanImageURI, ProductScanImageURIKey>, ImageInfoRepositoryCommon{

	/**
	 * Finads all ProductScanImageURIs whose key has the id value
	 * @param id the id value being searched for
	 * @return
	 */
	List<ProductScanImageURI> findByKeyId(long id);

	/**
	 * This repo call finds all of the images based on an images URI
	 * @param uriText
	 * @return
	 */
	List<ProductScanImageURI> findByImageURI(String uriText);

	/**
	 * Returns a list of image info based on the upcs
	 * @param upcs the upcs of a product
	 * @param activeSwitch if the image info is currently active
	 * @param imageFormat the not allowed image format
	 * @return
	 */
	List<ProductScanImageURI> findByKeyIdInAndActiveSwitchAndImageTypeImageFormatNot(List<Long> upcs, boolean activeSwitch, String imageFormat);

	/**
	 * Used to fetch product primary image by product id and sales channel code.
	 * @param productId product id.
	 * @param salesChannelCode sales channel code like 01, 02 etc.
	 * @return
	 */
	@Query(value = "SELECT i FROM ProductScanImageURI i inner join i.productScanImageBannerList ban " +
			" join i.sellingUnit su" +
			" WHERE su.prodId = :productId AND " +
			" i.imageStatusCode = 'A' and"+
			" ban.key.salesChannelCode = :salesChannelCode AND " +
			" i.activeOnline = 'Y' AND " +
			" i.imagePriorityCode = 'P'")
	ProductScanImageURI findPrimaryImageByProductId(@Param("productId") long productId,
													@Param("salesChannelCode") String salesChannelCode);

	/**
	 * Get submitted image with not rejected image by upcs.
	 *
	 * @param upcs the list of upc.
	 * @param page the Pageable.
	 * @return the List<ProductScanImageURI>
	 */
	@Query(value = QUERY_FIND_SUBMITTED_IMAGE_NOT_REJECTED_BY_UPCS)
	List<ProductScanImageURI> findSubmittedImageAndNotRejectedByUpcs(@Param("upcs") List<Long> upcs, Pageable page);

	/**
	 * Get submitted image with not rejected image or rejected images of 3 months from today's date by upcs.
	 *
	 * @param upcs the list of upc.
	 * @param page the Pageable.
	 * @return the List<ProductScanImageURI>
	 */
	@Query(value = QUERY_FIND_SUBMITTED_IMAGE_BY_UPCS)
	List<ProductScanImageURI> findSubmittedImageByUpcs(@Param("upcs") List<Long> upcs, Pageable page);
	/**
	 * Find all active online image.
	 *
	 * @param upcs the list of upc.
	 * @return the List<ProductScanImageURI>
	 */
	@Query(value = QUERY_FIND_ACTIVE_ONLINE_IMAGE_BY_UPCS)
	List<ProductScanImageURI> findActiveOnlineImageByUpcs(@Param("upcs") List<Long> upcs);

	/**
	 * Find all image primary by upcs.
	 *
	 * @param upcs the list of upc.
	 * @return the ProductScanImageURI
	 */
	@Query(value = QUERY_FIND_PRIMARY_IMAGE_BY_UPCS)
	List<ProductScanImageURI> findPrimaryImageByUpcs(@Param("upcs") List<Long> upcs);
}
