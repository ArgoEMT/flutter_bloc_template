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

  final int pages;
  final int perPage;
  final int total;

  List<T> items;
  int page;
}
