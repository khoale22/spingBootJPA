/*
 * BaseProductHierarchyTreeBuilder.java
 *
 *  Copyright (c) 2019 H-E-B
 *  All rights reserved.
 *
 *  This software is the confidential and proprietary information
 *  of HEB.
 */
package com.heb.pm.productHierarchy;

import com.google.common.collect.ComparisonChain;
import com.heb.pm.entity.*;

import java.util.*;

/**
 * This base class helps to build product hierarchy tree based on sub commodity, class commodity, item class, sub department and department.
 *
 * @author vn70529
 * @since 2.33.0
 */
public abstract class BaseProductHierarchyTreeBuilder {
    /**
     * Holds the search results.
     */
    private Map<String, Department> searchResults = new HashMap<>();
    /**
     * Holds the list of item class ids that existing in search results.
     */
    private Map<String, Integer> excludeItemClassKey = new HashMap<>();
    /**
     * Holds the list of sub department keys that existing in search results.
     */
    private Map<String, SubDepartmentKey> excludeSubDepartmentKey = new HashMap<>();
    /**
     * Holds the list of department keys that existing in search results.
     */
    private Map<String, SubDepartmentKey> excludeDepartmentKey = new HashMap<>();
    /**
     * Holds the list of class commodity key that existing in search results.
     */
    private Map<String, ClassCommodityKey> excludeClassCommodityKey = new HashMap<>();
    /**
     * Holds the reference list of sub commodities of class commodity node.
     */
    private Map<String, List<SubCommodity>> subComByClassComKey = new HashMap<>();
    /**
     * Holds the reference list of class commodities of item class node.
     */
    private Map<String, List<ClassCommodity>> classComByItemClassKey = new HashMap<>();
    /**
     * Holds the reference list of item classes of sub department node.
     */
    private Map<String, List<ItemClass>> itemClassBySubDeptKey = new HashMap<>();
    /**
     * Holds the reference list of sub departments of department node.
     */
    private Map<String, List<SubDepartment>> subDeptByDeptKey = new HashMap<>();

    public BaseProductHierarchyTreeBuilder() {
    }

    /**
     * Build product hierarchy tree based on sub commodity, class commodity, item class, sub department and department.
     * @param item this is instance of sub commodity, class commodity, item class, sub department or department.
     */
    public void build(Object item){
        if (item instanceof Department) {
            addDeptToSearchResults((Department) item);
        } else if (item instanceof SubDepartment) {
            buildSubDepartmentHierarchy((SubDepartment) item);
        } else if (item instanceof ItemClass) {
            buildItemClassHierarchy((ItemClass) item);
        } else if (item instanceof ClassCommodity) {
            buildClassCommodityHierarchy((ClassCommodity) item);
        } else if (item instanceof SubCommodity) {
            buildSubCommodityHierarchy((SubCommodity) item);
        }
    }

    /**
     * Build the sub department hierarchy based on sub department > department.
     *
     * @param subDepartment the sub department.
     */
    protected abstract void buildSubDepartmentHierarchy(SubDepartment subDepartment);

    /**
     * Build item class hierarchy based on item class > sub department > department.
     *
     * @param itemClass the item class.
     */
    protected abstract void buildItemClassHierarchy(ItemClass itemClass) ;

    /**
     * Build sub commodity hierarchy based on sub commodity > class commodity > item class > sub department > department.
     *
     * @param subCommodity the sub commodity
     */
    protected abstract void buildSubCommodityHierarchy(SubCommodity subCommodity);
    /**
     * Build class commodity hierarchy based on class commodity > item class > sub department > department.
     *
     * @param classCommodity the class commodity.
     */
    protected abstract void buildClassCommodityHierarchy(ClassCommodity classCommodity);

    /**
     * Check sub commodity is existing in search results. If it's class commodity is existing in search results, then add sub commodity into
     * class commodity and then return true.
     * If it's class commodity is not existing in search results, then add it into class commodity and return false.
     * @param subCommodity the sub commodity
     * @param classCommodity the class commodity.
     * @return true if it's parent is existing in search results or false.
     */
    protected boolean isAddedSubCommodityToSearchResults(SubCommodity subCommodity, ClassCommodity classCommodity){
        final String key = classCommodity.getKey().toString();
        if (subComByClassComKey.containsKey(key)) {
            subComByClassComKey.get(key).add(subCommodity);
            Collections.sort(subComByClassComKey.get(key), Comparator.comparing(o -> o.getKey().getSubCommodityCode()));
            return true;
        }
        // Add sub commodity, class commodity, item class, sub dept and dept into results research.
        classCommodity.getSubCommodityList().add(subCommodity);
        // Create reference sub commodities of class commodity node.
        subComByClassComKey.put(key, classCommodity.getSubCommodityList());
        // Add exclude key for class commodity.
        excludeClassCommodityKey.put(key, classCommodity.getKey());
        return false;
    }

    /**
     * Check commodity is existing in search results. If it's item class is existing in search results, then add commodity into
     * item class and then return true. If it's item class is not existing in search results, then add it into item class
     * and return false.
     * @param classCommodity the class commodity
     * @param itemClass the item class
     * @return true if it's parent is existing in search results or false.
     */
    protected boolean isAddedClassCommodityToSearchResults(ClassCommodity classCommodity, ItemClass itemClass){
        final String key = String.valueOf(itemClass.getItemClassCode());
        if (classComByItemClassKey.containsKey(key)) {
            classComByItemClassKey.get(key).add(classCommodity);
            sortClassCommodities(classComByItemClassKey.get(key));
            return true;
        }
        itemClass.getCommodityList().add(classCommodity);
        // Create reference class commodities of item class node.
        classComByItemClassKey.put(key, itemClass.getCommodityList());
        // Add exclude key for item class
        excludeItemClassKey.put(key, itemClass.getItemClassCode());
        return false;
    }

    /**
     * Check item class is existing in search results. If it's sub department is existing in search results, then add item class into
     * sub department and then return true. If it's sub department is not existing in search results, then add it into  sub department
     * and return false.
     * @param itemClass the item class.
     * @param subDepartment the sub department.
     * @return true if it's parent is existing in search results or false.
     */
    protected boolean isAddedItemClassSearchResults(ItemClass itemClass, SubDepartment subDepartment){
        final String key = subDepartment.getKey().toString();
        if (itemClassBySubDeptKey.containsKey(key)) {
            itemClassBySubDeptKey.get(key).add(itemClass);
            Collections.sort(itemClassBySubDeptKey.get(key),
                    Comparator.comparing(o -> o.getItemClassCode()));
            return true;
        }
        subDepartment.getItemClasses().add(itemClass);
        // Create reference item classes of sub department node.
        itemClassBySubDeptKey.put(key, subDepartment.getItemClasses());
        // Add exclude key for sub department
        excludeSubDepartmentKey.put(key, subDepartment.getKey());
        return false;
    }

    /**
     * Check sub department is existing in search results. If it's department is existing in search results, then add sub department into
     * department and then return true. If it's department is not existing in search results, then add it into department
     * and return false.
     * @param subDepartment the sub department.
     * @param department the department.
     * @return true if it's parent is existing in search results or false.
     */
    protected boolean isAddedSubDeptToSearchResults(SubDepartment subDepartment, Department department){
        final String key = department.getKey().toString();
        if (subDeptByDeptKey.containsKey(key)) {
            subDeptByDeptKey.get(key).add(subDepartment);
            Collections.sort(subDeptByDeptKey.get(key), Comparator.comparing(o -> o.getKey().getSubDepartment()));
            return true;
        }

        department.getSubDepartmentList().add(subDepartment);
        // create reference sub departments of department node.
        subDeptByDeptKey.put(key, department.getSubDepartmentList());
        // Add exclude key for department
        excludeDepartmentKey.put(key, department.getKey());
        return false;
    }

    /**
     * Add department in to search results.
     * @param department the department.
     */
    protected void addDeptToSearchResults(Department department){
        final String key = department.getKey().toString();
        if (searchResults.containsKey(key)) {
            searchResults.get(key).getSubDepartmentList().addAll(department.getSubDepartmentList());
        } else {
            searchResults.put(key, department);
        }
    }

    /**
     * Get the exclude list of department keys that existing in search results
     *
     * @return list of department keys
     */
    public List<SubDepartmentKey> getExcludeDepartmentKeys() {
        return new ArrayList<>(excludeDepartmentKey.values());
    }

    /**
     * Get the exclude list of sub department keys that existing in search results.
     *
     * @return the list of sub department keys
     */
    public List<SubDepartmentKey> getExcludeSubDepartmentKeys() {
        return new ArrayList<>(excludeSubDepartmentKey.values());
    }

    /**
     * Get the exclude list of item class ids that existing in search results.
     *
     * @return list of item class keys
     */
    public List<Integer> getExcludeItemClassIds() {
        return new ArrayList<>(excludeItemClassKey.values());
    }

    /**
     * Get the exclude list class commodity keys that existing in search results.
     *
     * @return the list class commodity keys
     */
    public List<ClassCommodityKey> getExcludeClsCommodityKeys() {
        for (ClassCommodityKey item : excludeClassCommodityKey.values()) {
            System.out.println(item.toString());
        }
        return new ArrayList<>(excludeClassCommodityKey.values());
    }

    /**
     * Get the search results.
     *
     * @return the list of departments.
     */
    public List<Department> getSearchResults() {
        return new ArrayList<>(searchResults.values());
    }

    /**
     * Sort class commodities.
     *
     * @param clsCommodities the list of commodities.
     */
    private void sortClassCommodities(List<ClassCommodity> clsCommodities) {
        Collections.sort(clsCommodities, (o1, o2) ->
                ComparisonChain.start().compare(o1.getKey().getCommodityCode(), o2.getKey().getCommodityCode())
                        .compare(o1.getKey().getClassCode(), o2.getKey().getClassCode()).result());
    }
}
