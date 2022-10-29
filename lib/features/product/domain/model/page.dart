

class Page {
  int currentPage = 1;
  int perPage = 10;
  int lastPage = 1;
  int total = 0;

  Page(this.currentPage, this.perPage, this.lastPage, this.total);


  @override
  String toString() {
    return 'Page(currentPage: $currentPage, perPage: $perPage, totalPage: $lastPage , total: $total)';
  }
}
