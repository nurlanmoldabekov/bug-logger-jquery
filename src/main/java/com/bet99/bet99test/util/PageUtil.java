package com.bet99.bet99test.util;

import org.springframework.data.domain.Sort;

public class PageUtil {

  public static Sort getSort(String sortBy, String sortDirection) {
    if (sortBy == null) {
      return Sort.unsorted();
    }

    String[] sortByArray = sortBy.split(",");
    var sort = setDirection(Sort.by(sortByArray[0]), sortDirection);

    if (sortByArray.length > 1) {
      for (int i = 1; i < sortByArray.length; i++) {
        var nextSort = setDirection(Sort.by(sortByArray[i]), sortDirection);
        sort = sort.and(nextSort);
      }
    }
    return sort;
  }

  private static Sort setDirection(Sort sort, String sortDirection) {
    if ("asc".equalsIgnoreCase(sortDirection)) {
      return sort.ascending();
    }
    if ("desc".equalsIgnoreCase(sortDirection)) {
      return sort.descending();
    }
    return sort;
  }
}