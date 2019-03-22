/*
 * ProductBrandRepository
 *
 *  Copyright (c) 2017 HEB
 *  All rights reserved.
 *
 *  This software is the confidential and proprietary information
 *  of HEB.
 */
package com.heb.pm.repository;

import com.heb.pm.entity.ProductBrand;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Repository of the ProductBrand entity.
 *
 * @author vn00602
 * @since 2.12.0
 */
public interface ProductBrandRepository extends JpaRepository<ProductBrand, Integer>, ProductBrandCommon {

    /**
     * Find by product brand tier code is not Unassigned [0]
     *
     * @param productBrandTierCode the product brand tier code is Unassigned [0].
     * @param pageRequest          the page request for pagination.
     * @return the page of product brands.
     */
    List<ProductBrand> findByProductBrandTierProductBrandTierCodeNot(Integer productBrandTierCode, Pageable pageRequest);

    /**
     * Find by product brand description by like query.
     *
     * @param productBrand the product brand description to find.
     * @param pageRequest  the page request for pagination.
     * @return the page of product brands.
     */
    @Query(value = FIND_BY_PRODUCT_BRAND_SQL)
    List<ProductBrand> findByProductBrand(@Param("productBrand") String productBrand, Pageable pageRequest);

    /**
     * Find by product brand description by like query.
     *
     * @param productBrand         the product brand description to find.
     * @param productBrandTierCode the product brand tier code is Unassigned [0].
     * @param pageRequest          the page request for pagination.
     * @return the page of product brands.
     */
    @Query(value = FIND_BY_PRODUCT_BRAND_AND_OWN_BRAND_SQL)
    List<ProductBrand> findByProductBrandAndOwnBrand(@Param("productBrand") String productBrand,
                                                     @Param("productBrandTierCode") Integer productBrandTierCode,
                                                     Pageable pageRequest);

    /**
     * Find by product brand tier name by like query.
     *
     * @param productBrandName the product brand tier name to find.
     * @param pageRequest      the page request for pagination.
     * @return the page of product brands.
     */
    List<ProductBrand> findByProductBrandTierProductBrandNameIgnoreCaseContaining(String productBrandName, Pageable pageRequest);

    /**
     * Find by product brand description by like query and brand tier code is not Unassigned [0].
     *
     * @param productBrandName     the product brand tier name to find.
     * @param productBrandTierCode the product brand tier code is Unassigned [0].
     * @param pageRequest          the page request for pagination.
     * @return the page of product brands.
     */
    List<ProductBrand> findByProductBrandTierProductBrandNameIgnoreCaseContainingAndProductBrandTierProductBrandTierCodeNot(
            String productBrandName, Integer productBrandTierCode, Pageable pageRequest);

    /**
     * Find by product brand description and product brand tier name by like query.
     *
     * @param productBrand the product brand description to find.
     * @param brandTier    the product brand tier name to find.
     * @param pageRequest  the page request for pagination.
     * @return the page of product brands.
     */
    @Query(value = FIND_BY_PRODUCT_BRAND_AND_BRAND_TIER_SQL)
    List<ProductBrand> findByProductBrandAndBrandTier(@Param("productBrand") String productBrand,
                                                      @Param("brandTier") String brandTier,
                                                      Pageable pageRequest);

    /**
     * Find by product brand description and product brand tier name by like query and brand tier code is not Unassigned [0].
     *
     * @param productBrand         the product brand description to find.
     * @param brandTier            the product brand tier name to find.
     * @param productBrandTierCode the product brand tier code is Unassigned [0].
     * @param pageRequest          the page request for pagination.
     * @return the page of product brands.
     */
    @Query(value = FIND_BY_PRODUCT_BRAND_AND_BRAND_TIER_AND_OWN_BRAND_SQL)
    List<ProductBrand> findByProductBrandAndBrandTierAndOwnBrand(@Param("productBrand") String productBrand,
                                                                 @Param("brandTier") String brandTier,
                                                                 @Param("productBrandTierCode") Integer productBrandTierCode,
                                                                 Pageable pageRequest);

	/**
	 * find product brand by id or name contain
	 * @param id
	 * @param desciption
	 * @param pageRequest
	 * @return
	 */
	@Query(value = FIND_BY_PRODUCT_BRAND_AND_DESCRIPTION_SQL)
	List<ProductBrand> findByProductBrandIdOrDescription(@Param("id") String id,
														  @Param("desciption") String desciption,
														  Pageable pageRequest);
}
