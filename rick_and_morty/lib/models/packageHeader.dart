class PackageHeader {
  int count;
  int pages;
  String? next;
  String? prev;

  PackageHeader(this.count, this.pages, this.next, this.prev);

  factory PackageHeader.fromJson(Map<String, dynamic> json) {
    return new PackageHeader(
      json["count"],
      json["pages"],
      json["next"],
      json["prev"],
    );
  }
}
