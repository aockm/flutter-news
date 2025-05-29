class Page {
    int totalCount;
    int pageSize;
    int pageNo;
    int pageTotal;
    List<dynamic> list;

    Page({
        required this.totalCount,
        required this.pageSize,
        required this.pageNo,
        required this.pageTotal,
        required this.list,
    });

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        totalCount: json["totalCount"],
        pageSize: json["pageSize"],
        pageNo: json["pageNo"],
        pageTotal: json["pageTotal"],
        list: json["list"],
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "pageSize": pageSize,
        "pageNo": pageNo,
        "pageTotal": pageTotal,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
    };
}
