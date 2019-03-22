/*
 *  CostOwner
 *
 *  Copyright (c) 2017 HEB
 *  All rights reserved.
 *
 *  This software is the confidential and proprietary information
 *  of HEB.
 */
package com.heb.pm.entity;

import javax.persistence.*;

import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.hibernate.annotations.TypeDefs;

import java.io.Serializable;
import java.util.List;

/**
 * Represents the cst_own.
 *
 * @author l730832
 * @since 2.5.0
 */
@Entity
@Table(name = "cst_own")
//dB2Oracle changes vn00907 starts
@TypeDefs({
@TypeDef(name = "fixedLengthChar", typeClass = com.heb.pm.util.oracle.OracleFixedLengthCharType.class),
@TypeDef(name = "fixedLengthCharPK", typeClass = com.heb.pm.util.oracle.OracleFixedLengthCharTypePK.class)
})
// dB2Oracle changes vn00907
public class CostOwner implements Serializable {

	private static final long serialVersionUID = 1L;

	public static final String DISPLAY_NAME_FORMAT = "%s [%d]";

	@Id
	@Column(name = "cst_own_id")
	private Integer costOwnerId;

	@Column(name = "cst_own_nm")
	//db2o changes  vn00907
	@Type(type="fixedLengthChar") 
	private String costOwnerName;

	@Column(name = "t2t_id")
	private Integer topToTopId;

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name="t2t_id", referencedColumnName = "t2t_id", insertable = false, updatable = false, nullable = false),
	})
	private TopToTop topToTop;

	@OneToMany(mappedBy = "costOwner",fetch = FetchType.LAZY)
	private List<ProductBrandCostOwner> productBrandCostOwners;

	/**
	 * Returns the CostOwnerId
	 *
	 * @return CostOwnerId
	 **/
	public Integer getCostOwnerId() {
		return costOwnerId;
	}

	/**
	 * Sets the CostOwnerId
	 *
	 * @param costOwnerId The CostOwnerId
	 **/

	public void setCostOwnerId(Integer costOwnerId) {
		this.costOwnerId = costOwnerId;
	}

	/**
	 * Returns the CostOwnerName
	 *
	 * @return CostOwnerName
	 **/
	public String getCostOwnerName() {
		return costOwnerName;
	}

	/**
	 * Sets the CostOwnerName
	 *
	 * @param costOwnerName The CostOwnerName
	 **/

	public void setCostOwnerName(String costOwnerName) {
		this.costOwnerName = costOwnerName;
	}

	/**
	 * Returns the Top2TopId
	 *
	 * @return Top2TopId
	 **/
	public Integer getTopToTopId() {
		return topToTopId;
	}

	/**
	 * Sets the Top2TopId
	 *
	 * @param topToTopId The Top2TopId
	 **/

	public void setTopToTopId(Integer topToTopId) {
		this.topToTopId = topToTopId;
	}

	/**
	 * Returns the TopToTop
	 *
	 * @return TopToTop
	 **/
	public TopToTop getTopToTop() {
		return topToTop;
	}

	/**
	 * Sets the TopToTop
	 *
	 * @param topToTop The TopToTop
	 **/

	public void setTopToTop(TopToTop topToTop) {
		this.topToTop = topToTop;
	}

	/**
	 * Gets the list of ProductBrandCostOwners.
	 *
	 * @return the list of ProductBrandCostOwners.
	 */
	public List<ProductBrandCostOwner> getProductBrandCostOwners() {
		return productBrandCostOwners;
	}

	/**
	 * Sets the list of ProductBrandCostOwners.
	 *
	 * @param productBrandCostOwners the list of ProductBrandCostOwners.
	 */
	public void setProductBrandCostOwners(List<ProductBrandCostOwner> productBrandCostOwners) {
		this.productBrandCostOwners = productBrandCostOwners;
	}

	/**
	 * The display name for the Cost Owner
	 * @return the display name in the format "General Mills [1818]"
	 */
	public String getDisplayName(){
		return String.format(CostOwner.DISPLAY_NAME_FORMAT, this.getCostOwnerName().trim(),
				this.getCostOwnerId());
	}

	/**
	 * Returns a String representation of the object.
	 *
	 * @return A String representation of the object.
	 */
	@Override
	public String toString() {
		return "CostOwner{" +
				"costOwnerId=" + costOwnerId +
				", costOwnerName='" + costOwnerName + '\'' +
				", topToTopId=" + topToTopId +
				'}';
	}

	/**
	 * Compares another object to this one. If that object is a Location, it uses they keys
	 * to determine if they are equal and ignores non-key values for the comparison.
	 *
	 * @param o The object to compare to.
	 * @return True if they are equal and false otherwise.
	 */
	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		CostOwner costOwner = (CostOwner) o;

		if (costOwnerId != null ? !costOwnerId.equals(costOwner.costOwnerId) : costOwner.costOwnerId != null)
			return false;
		if (costOwnerName != null ? !costOwnerName.equals(costOwner.costOwnerName) : costOwner.costOwnerName != null)
			return false;
		return topToTopId != null ? topToTopId.equals(costOwner.topToTopId) : costOwner.topToTopId == null;
	}

	/**
	 * Returns a hash code for this object. If two objects are equal, they have the same hash. If they are not equal,
	 * they have different hash codes.
	 *
	 * @return The hash code for this obejct.
	 */
	@Override
	public int hashCode() {
		int result = costOwnerId != null ? costOwnerId.hashCode() : 0;
		result = 31 * result + (costOwnerName != null ? costOwnerName.hashCode() : 0);
		result = 31 * result + (topToTopId != null ? topToTopId.hashCode() : 0);
		return result;
	}
}
