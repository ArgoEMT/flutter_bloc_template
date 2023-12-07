class ListPaginationResponse<T> {
  ListPaginationResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.pages,
    required this.perPage,
  });

  factory ListPaginationResponse.fromJson(Map<String, dynamic> json) =>
      ListPaginationResponse<T>(
        items: (json['items'] as List<dynamic>)
            .map((dynamic e) => e as T)
            .toList(),
        total: json['total'] as int,
        page: json['page'] as int,
        pages: json['pages'] as int,
        perPage: json['perPage'] as int,
      );

  List<T> items;
  final int total;
  int page;
  final int pages;
  final int perPage;
}
