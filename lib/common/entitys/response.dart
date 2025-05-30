
class Response {
    String status;
    int code;
    String info;
    Map<String,dynamic> data;

    Response({
        required this.status,
        required this.code,
        required this.info,
        required this.data,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"],
        code: json["code"],
        info: json["info"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "info": info,
        "data": data,
    };
}
