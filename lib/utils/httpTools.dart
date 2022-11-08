class PagedFiltered {
  int limit;
  int page;
  List<String> filterFields = [];
  List<Object> filterValues = [];

  PagedFiltered({
    required this.limit,
    required this.page,
    List<String>? fields,
    List<Object>? values,
  }) {
    if (fields?.length != values?.length) throw 'Invalid filter configuration';
    filterFields.addAll(fields ?? []);
    filterValues.addAll(values ?? []);
  }

  String getQueryString() {
    bool filtering = filterFields.isNotEmpty &&
        filterValues.isNotEmpty &&
        filterValues.length == filterFields.length;

    String pageString = 'limit=$limit&page=$page';

    String filterString = '';

    if (filtering) {
      for (int i = 0; i < filterFields.length; i++) {
        filterString += 'field=${filterFields[i]}&';
      }
      for (int i = 0; i < filterValues.length; i++) {
        filterString +=
            i == filterValues.length ? 'value=${filterValues[i]}&' : 'value=${filterValues[i]}';
      }
    }
    return '$pageString${filtering ? '&' : ''}$filterString';
  }
}
